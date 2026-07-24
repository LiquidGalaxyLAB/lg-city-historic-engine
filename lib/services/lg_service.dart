import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/services.dart' show rootBundle;
import '../main.dart';
import '../models/connection_state.dart';
import '../models/poi_model.dart';
import '../kmls/logos_kml.dart';
import '../kmls/panorama_kml.dart';
import '../kmls/placemark_icon.dart';
import '../kmls/kml_escape.dart';
import 'chromium_service.dart';
import '../data/chromium_image_catalog.dart';
import 'image_slicer.dart';

class LGService {
  final LGConnectionState _conn = LGConnectionState();
  final ChromiumService _chromium = ChromiumService();
  static bool _isOrbiting = false;
  static int _presentGeneration = 0;
  static Future<void> _presentQueue = Future.value();
  static POI? _lastPresentedPoi;

  /// The three middle screens that together show ONE panorama image,
  /// ORDERED LEFT TO RIGHT as they are physically placed in the rig.
  /// Confirmed physical order (left to right): lg4, lg5, lg1, lg2, lg3.
  /// Of the three middle screens used here: lg5 (left) - lg1 (center) - lg2 (right).
  static const List<int> _panoramaScreensLeftToRight = [5, 1, 2];

  /// Assumed aspect ratio (width/height) of each physical screen.
  /// Adjust if your monitors aren't 16:9.
  static const double _screenAspect = 16 / 9;

  /// How much of the COMBINED 3-screen width the image occupies (0-1).
  /// Lower = smaller image. 1.0 would span the full 3 screens edge to edge.
  /// 0.75 gives roughly: lg5 ~62% covered, lg1 (center) 100% covered,
  /// lg2 ~62% covered — so all three screens clearly show part of it.
  static const double _panoramaWidthFraction = 0.75;

  /// Gap between the BOTTOM of the image and the bottom edge of the screen,
  /// as a fraction of one screen's height. 0 = touching the very bottom.
  static const double _panoramaBottomMargin = 0.06;

  /// Fondo beige de la app (balloon).
  static const String _appBackground = '#F5F1E9';
  static const String _appText = '#1C1C1E';

  /// The "Solo KML" filename each machine's sync_nlc_N.php serves.
  /// Machine 1 (the master) is the ONE exception: it's named `master_1.kml`,
  /// not `slave_1.kml`. Every other machine follows `slave_N.kml`.
  String _soloKmlFilename(int machineNumber) {
    return machineNumber == 1 ? 'master_1.kml' : 'slave_$machineNumber.kml';
  }

  Future<void> sendKML(String kml) async {
    await _conn.execute("cat <<'EOF' > /var/www/html/kmls.kml\n$kml\nEOF");
  }

  /// Moves the camera without deleting the logo or other KMLs.
  Future<bool> flyToPOI(POI poi) async {
    final lat = poi.lat ?? 41.6147;
    final lng = poi.lng ?? 0.6268;
    final range = poi.range ?? 1000.0;
    final tilt = poi.tilt ?? 45.0;
    final heading = poi.heading ?? 0.0;
    final altitudeMode = poi.altitudeMode ?? 'relativeToGround';

    final String command =
        'echo "flytoview=<LookAt><longitude>$lng</longitude><latitude>$lat</latitude><range>$range</range><tilt>$tilt</tilt><heading>$heading</heading><altitudeMode>$altitudeMode</altitudeMode></LookAt>" > /tmp/query.txt';
    final result = await _conn.execute(command);
    return result != null;
  }

  Future<void> startOrbitPOI(POI poi) async {
    _isOrbiting = true;
    double heading = poi.heading ?? 0;
    final lat = poi.lat ?? 41.6147;
    final lng = poi.lng ?? 0.6268;
    final range = poi.range ?? 1000.0;
    final tilt = poi.tilt ?? 45.0;
    final altitudeMode = poi.altitudeMode ?? 'relativeToGround';

    while (_isOrbiting) {
      heading = (heading + 10) % 360;
      final String command =
          'echo "flytoview=<LookAt><longitude>$lng</longitude><latitude>$lat</latitude><range>$range</range><tilt>$tilt</tilt><heading>$heading</heading><altitudeMode>$altitudeMode</altitudeMode></LookAt>" > /tmp/query.txt';
      await _conn.execute(command);
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  void stopOrbit() {
    _isOrbiting = false;
  }

  /// Cambia al POI en el rig sobrescribiendo el anterior (sin limpiar antes).
  Future<void> presentPoi(POI poi) async {
    final previous = _presentQueue;
    final gate = Completer<void>();
    _presentQueue = gate.future;
    await previous;
    try {
      await _presentPoiWithRetry(poi);
    } finally {
      gate.complete();
    }
  }

  Future<void> _presentPoiWithRetry(POI poi) async {
    for (var attempt = 0; attempt < 2; attempt++) {
      if (attempt > 0) {
        debugPrint('LGService: presentPoi retry ${attempt + 1} (${poi.name})');
        await _conn.reconnect();
        await Future.delayed(const Duration(milliseconds: 800));
      }

      final ok = await _presentPoiOnce(poi);
      if (ok) {
        _lastPresentedPoi = poi;
        return;
      }
    }
    debugPrint('LGService: presentPoi FAILED after retries (${poi.name})');
  }

  Future<bool> _presentPoiOnce(POI poi) async {
    final generation = ++_presentGeneration;

    stopOrbit();
    if (!await _conn.ensureReady()) {
      debugPrint('LGService: presentPoi skipped — SSH not ready');
      return false;
    }

    debugPrint('LGService: presentPoi start (${poi.name}, gen=$generation)');

    if (!await _hideBalloon()) {
      debugPrint('LGService: hideBalloon failed (${poi.name})');
      return false;
    }
    if (generation != _presentGeneration) return false;
    await Future.delayed(const Duration(milliseconds: 700));

    if (!await flyToPOI(poi)) {
      debugPrint('LGService: flyToPOI failed (${poi.name})');
      return false;
    }
    if (generation != _presentGeneration) return false;
    await Future.delayed(_flySettleDelay(poi));

    final placemarkOk = await sendCenterPlacemark(poi);
    if (generation != _presentGeneration) return false;
    if (!placemarkOk) {
      debugPrint('LGService: placemark failed (${poi.name})');
      return false;
    }
    await Future.delayed(const Duration(milliseconds: 900));

    final balloonOk = await sendBalloon(poi);
    if (!balloonOk) {
      debugPrint('LGService: balloon failed (${poi.name})');
      return false;
    }
    if (generation != _presentGeneration) return false;

    final chromiumAsset = await ChromiumImageCatalog.resolve(poi);
    if (chromiumAsset != null) {
      unawaited(_chromium.showPoiImageTimed(poi));
    } else {
      debugPrint('LGService: no chromium image (${poi.name})');
    }

    debugPrint('LGService: presentPoi done (${poi.name}, gen=$generation)');
    return true;
  }

  /// Cierra Chromium en todas las pantallas y vuelve a Google Earth.
  Future<void> closeChromium() => _chromium.closeChromiumOnAllScreens();

  Duration _flySettleDelay(POI poi) {
    final prev = _lastPresentedPoi;
    if (prev == null) {
      return const Duration(milliseconds: 2000);
    }

    final lat1 = prev.lat ?? 41.6147;
    final lng1 = prev.lng ?? 0.6268;
    final lat2 = poi.lat ?? 41.6147;
    final lng2 = poi.lng ?? 0.6268;
    final dLat = (lat2 - lat1).abs();
    final dLng = (lng2 - lng1).abs();
    final distance = math.sqrt(dLat * dLat + dLng * dLng);

    if (distance > 0.05) return const Duration(milliseconds: 3500);
    if (distance > 0.01) return const Duration(milliseconds: 2500);
    return const Duration(milliseconds: 1800);
  }

  /// Cierra el balloon abierto antes de volar a otro sitio.
  Future<bool> _hideBalloon() async {
    if (!_conn.isConnected) return false;

    final slaveNo = _rightMostScreen(_conn.screens);
    final String kml = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
  <Document id="slave_$slaveNo">
    <Placemark id="poi_balloon">
      <gx:balloonVisibility>0</gx:balloonVisibility>
      <Point><coordinates>0,0,0</coordinates></Point>
    </Placemark>
  </Document>
</kml>''';
    final ok = await _conn.writeSlaveKml(slaveNo, kml);
    if (!ok) return false;
    return _conn.notifySlaveKmlChanged(slaveNo);
  }

  /// Limpieza completa (Tools / desconexión). No usar al cambiar de sitio.
  Future<void> clearPoiPresentation() async {
    _presentGeneration++;
    stopOrbit();
    if (!_conn.isConnected) return;

    await clearBalloon();
    await clearCenterPlacemark();
  }

  Future<void> clearKMLs() async {
    _requireConnection();
    const String blankMain = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document></Document>
</kml>''';

    await _conn.writeRemoteFile('/var/www/html/kmls.kml', blankMain);
    await _conn.execute('touch /var/www/html/kmls.kml');

    await _conn.writeSoloKml(1, PanoramaOverlayManager.blankMaster());
    await _conn.notifySoloKmlChanged(1);

    final screens = _conn.screens;
    for (var i = 2; i <= screens; i++) {
      await _conn.writeRemoteFile(
        '/var/www/html/kml/slave_$i.kml',
        PanoramaOverlayManager.blankSlave(i),
      );
      await _conn.notifySlaveKmlChanged(i);
    }
    await _conn.writeRemoteFile(
      '/var/www/html/kml/slave_1.kml',
      PanoramaOverlayManager.blankSlave(1),
    );
    await _conn.execute('touch /var/www/html/kml/slave_1.kml');

    debugPrint('LGService: clearKMLs OK ($screens screens)');
  }

  /// Quita el panel de logos de la pantalla izquierda del rig.
  Future<void> clearLogos() async {
    _requireConnection();
    final slaveNo = _leftMostScreen(_conn.screens);
    final ok = await _conn.writeRemoteFile(
      '/var/www/html/kml/slave_$slaveNo.kml',
      PanoramaOverlayManager.blankSlave(slaveNo),
    );
    if (!ok) {
      throw StateError('No se pudo escribir slave_$slaveNo.kml');
    }
    await _conn.notifySlaveKmlChanged(slaveNo);
    debugPrint('LGService: clearLogos OK -> slave_$slaveNo.kml');
  }

  /// Muestra el panel de logos en la pantalla izquierda (p. ej. LG4).
  Future<void> showLogos() async {
    _requireConnection();
    await _conn.uploadAssets();
    await _conn.sendLogoKML(LogoOverlayManager.generate());
    debugPrint('LGService: showLogos OK');
  }

  void _requireConnection() {
    if (!_conn.isConnected) {
      throw StateError('No hay conexión SSH con el Liquid Galaxy');
    }
  }

  Future<void> relaunch() async {
    final password = _conn.password;
    final sudo = _conn.sudoPassword;
    final user = _conn.username;
    final screens = _conn.screens;

    for (int i = 1; i <= screens; i++) {
      final String hostname = i == 1 ? 'localhost' : 'lg$i';
      final relaunchCommand = """RELAUNCH_CMD="\\
if [ -f /etc/init/lxdm.conf ]; then
  export SERVICE=lxdm
elif [ -f /etc/init/lightdm.conf ]; then
  export SERVICE=lightdm
else
  exit 1
fi
if  [[ \\\$(service \\\$SERVICE status) =~ 'stop' ]]; then
  echo $sudo | sudo -S service \\\${SERVICE} start
else
  echo $sudo | sudo -S service \\\${SERVICE} restart
fi
" && sshpass -p $password ssh -o StrictHostKeyChecking=no -x -t $user@$hostname "\$RELAUNCH_CMD\"""";

      if (i == 1) {
        await _conn.execute(
            '"/home/$user/bin/lg-relaunch" > /home/$user/log.txt 2>&1');
      }
      await _conn.execute(relaunchCommand);
    }
  }

  Future<void> shutdown() async {
    final password = _conn.password;
    final user = _conn.username;
    final sudo = _conn.sudoPassword;
    final screens = _conn.screens;

    for (var i = screens; i >= 1; i--) {
      final String hostname = i == 1 ? 'localhost' : 'lg$i';
      await _conn.execute(
          'sshpass -p $password ssh -o StrictHostKeyChecking=no -t $user@$hostname "echo $sudo | sudo -S poweroff"');
    }
  }

  Future<void> reboot() async {
    final password = _conn.password;
    final user = _conn.username;
    final sudo = _conn.sudoPassword;
    final screens = _conn.screens;

    for (var i = screens; i >= 1; i--) {
      final String hostname = i == 1 ? 'localhost' : 'lg$i';
      await _conn.execute(
          'sshpass -p $password ssh -o StrictHostKeyChecking=no -t $user@$hostname "echo $sudo | sudo -S reboot"');
    }
  }

  /// LG1 (master) es siempre la pantalla central del rig.
  static const int _centerScreen = 1;

  /// Índice de pantalla del rig para logo (izquierda) y balloon (derecha).
  int _leftMostScreen(int screens) => (screens ~/ 2) + 2;
  int _rightMostScreen(int screens) => (screens ~/ 2) + 1;

  /// Muestra un pin en la pantalla central (LG1) en las coordenadas del POI.
  Future<bool> sendCenterPlacemark(POI poi) async {
    if (!_conn.isConnected) {
      debugPrint('LGService: sendCenterPlacemark skipped — not connected');
      return false;
    }

    const machineNo = _centerScreen;
    const documentId = 'master_1';
    final lat = poi.lat ?? 41.6147;
    final lng = poi.lng ?? 0.6268;

    try {
      final iconBytes = await PlacemarkIconManager.buildColoredIcon(poi);
      await _conn.uploadImageBytes(
        iconBytes,
        PlacemarkIconManager.remoteFileNameFor(poi),
        remoteDir: '/var/www/html/kml',
      );
    } catch (e) {
      debugPrint('LGService: sendCenterPlacemark icon upload failed: $e');
      return false;
    }

    final kml = PlacemarkIconManager.kmlPlacemark(
      poi: poi,
      lat: lat,
      lng: lng,
      documentId: documentId,
    );

    final ok = await _conn.writeSoloKml(machineNo, kml);
    if (!ok) {
      debugPrint('LGService: sendCenterPlacemark FAILED write master_1.kml');
      return false;
    }

    final notified = await _conn.notifySoloKmlChanged(machineNo);
    if (!notified) {
      debugPrint('LGService: sendCenterPlacemark FAILED notify master_1.kml');
      return false;
    }

    final color = PlacemarkIconManager.colorForPoi(poi);
    debugPrint(
      'LGService: sendCenterPlacemark OK -> master_1.kml (${poi.name}, rgb(${color.r},${color.g},${color.b}))',
    );
    return true;
  }

  /// Quita el pin de la pantalla central.
  Future<void> clearCenterPlacemark() async {
    const machineNo = _centerScreen;
    const String blank = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
  <Document id="master_1"></Document>
</kml>''';
    await _conn.writeSoloKml(machineNo, blank);
    await _conn.notifySoloKmlChanged(machineNo);
  }

  /// Sends the balloon to the right-most screen of the rig.
  Future<bool> sendBalloon(POI poi) async {
    final screens = _conn.screens;
    final slaveNo = _rightMostScreen(screens);

    if (!_conn.isConnected) {
      debugPrint('LGService: sendBalloon skipped — not connected');
      return false;
    }

    final lang = languageNotifier.value;
    final String localizedDescription =
        sanitizeCData(escapeHtml(poi.getDescription(lang)));
    final String safeName = escapeXml(poi.getName(lang));
    final String safeEra = poi.era != null && poi.era!.isNotEmpty
        ? escapeHtml(poi.getEra(lang))
        : '';
    final String safeStartDate =
        poi.startDate != null && poi.startDate!.isNotEmpty
            ? escapeHtml(poi.startDate!)
            : '';
    final String safeEndDate = poi.endDate != null && poi.endDate!.isNotEmpty
        ? escapeHtml(poi.endDate!)
        : '';

    String? imageBlock;
    if (poi.image.isNotEmpty) {
      try {
        final rawName = poi.image.split('/').last;
        final safeNameFile =
            'balloon_${Object.hash(poi.name, poi.image).abs()}_$rawName'
                .replaceAll(RegExp(r'[^\w.\-]'), '_');
        await _conn.uploadImageAsset(poi.image, safeNameFile);
        imageBlock =
            '<img src="http://lg1:81/logos/$safeNameFile" alt="$safeName" '
            'style="width:100%;max-height:320px;object-fit:cover;display:block;" />';
      } catch (e) {
        debugPrint('LGService: balloon image upload failed: $e');
      }
    }

    final String eraLine = safeEra.isNotEmpty
        ? '<p style="font-size:22px;color:$_appText;margin:0 0 12px 0;text-transform:uppercase;font-weight:bold;">$safeEra</p>'
        : '';

    final String dateLine = safeStartDate.isNotEmpty
        ? '<p style="font-size:20px;color:$_appText;margin:0 0 24px 0;">'
            '$safeStartDate'
            '${safeEndDate.isNotEmpty && safeEndDate != safeStartDate ? " – $safeEndDate" : ""}'
            '</p>'
        : '';

    final String descLine = localizedDescription.isNotEmpty
        ? '<p style="font-size:30px;line-height:1.55;color:$_appText;margin:0;text-align:justify;">$localizedDescription</p>'
        : '';

    final String imageHtml = imageBlock ?? '';

    // Document id="slave_N" es obligatorio en Liquid Galaxy para que GE recargue la capa solo.
    final String kml = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
  <Document id="slave_$slaveNo">
    <Placemark id="poi_balloon">
      <name>$safeName</name>
      <gx:balloonVisibility>1</gx:balloonVisibility>
      <description><![CDATA[
        <html>
        <body style="margin:0;padding:0;background-color:$_appBackground;font-family:Georgia,serif;color:$_appText;width:100%;height:100%;overflow-y:auto;">
          $imageHtml
          <div style="padding:36px 40px 40px 40px;">
            <h1 style="font-size:54px;font-weight:bold;margin:0 0 18px 0;color:$_appText;border-bottom:2px solid #6B5B45;padding-bottom:12px;">
              $safeName
            </h1>
            $eraLine
            $dateLine
            $descLine
          </div>
        </body>
        </html>
      ]]></description>
      <Point>
        <coordinates>${poi.lng ?? 0.6268},${poi.lat ?? 41.6147},0</coordinates>
      </Point>
    </Placemark>
  </Document>
</kml>''';

    final ok = await _conn.writeSlaveKml(slaveNo, kml);
    if (!ok) {
      debugPrint('LGService: sendBalloon FAILED write slave_$slaveNo.kml');
      return false;
    }

    final notified = await _conn.notifySlaveKmlChanged(slaveNo);
    if (!notified) {
      debugPrint('LGService: sendBalloon FAILED notify slave_$slaveNo.kml');
      return false;
    }

    debugPrint(
      'LGService: sendBalloon OK -> slave_$slaveNo.kml (${poi.name}, $screens screens)',
    );
    return true;
  }

  /// Clears the right-most screen balloon layer.
  Future<void> clearBalloon() async {
    final slaveNo = _rightMostScreen(_conn.screens);
    final String blank = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
  <Document id="slave_$slaveNo"></Document>
</kml>''';
    await _conn.writeSlaveKml(slaveNo, blank);
    await _conn.notifySlaveKmlChanged(slaveNo);
  }

  /// Uploads [poi.panoramaImage] (if set) and shows it, SMALLER than full
  /// screen and positioned near the bottom, split across the three middle
  /// screens — LG5 (left), LG1 (center), LG2 (right) — so that, physically
  /// side by side, they reconstruct the single original image intact
  /// (not three copies of the same image, and never distorted).
  /// Being a ScreenOverlay, it stays fixed on screen and never moves when
  /// the camera moves.
  Future<void> sendPanoramaImage(POI poi) async {
    final String? asset = poi.panoramaImage;
    if (asset == null || asset.isEmpty) return;

    final ui.Image image;
    try {
      image = await ImageSlicer.loadImage(asset);
    } catch (e) {
      debugPrint('LGService: could not load panorama asset "$asset": $e');
      return;
    }
    final double imgAspect = image.width / image.height;

    final int screenCount = _panoramaScreensLeftToRight.length;

    // Treat the N screens as one long combined canvas (in "screen-height"
    // units, assuming all screens share the same height and aspect ratio).
    final double canvasWidth = screenCount * _screenAspect;
    final double displayedWidth = _panoramaWidthFraction * canvasWidth;
    // Preserve the image's own aspect ratio -> never stretched/cropped.
    final double displayedHeight = displayedWidth / imgAspect;
    final double xStart = (canvasWidth - displayedWidth) / 2; // centered

    final String baseName = asset.split('/').last.split('.').first;

    for (int i = 0; i < screenCount; i++) {
      final int slaveNo = _panoramaScreensLeftToRight[i];
      try {
        final double screenLeft = i * _screenAspect;
        final double screenRight = screenLeft + _screenAspect;

        final double visLeft = math.max(screenLeft, xStart);
        final double visRight = math.min(screenRight, xStart + displayedWidth);

        if (visRight <= visLeft) {
          // The image doesn't reach this screen at all: make sure it's clear.
          await _conn.execute(
              "cat <<'KMLEOF' > /var/www/html/kml/slave_$slaveNo.kml\n${PanoramaOverlayManager.blank()}\nKMLEOF");
          continue;
        }

        // Where, within THIS screen (0-1), the visible part starts and how wide it is.
        final double localLeft = (visLeft - screenLeft) / _screenAspect;
        final double localWidth = (visRight - visLeft) / _screenAspect;

        // Which pixel range of the SOURCE image corresponds to that visible part.
        // Clamp defensively: rounding can push these 1px past the image edges.
        int pixelStart = ((visLeft - xStart) / displayedWidth * image.width)
            .round()
            .clamp(0, image.width - 1);
        int pixelEnd = ((visRight - xStart) / displayedWidth * image.width)
            .round()
            .clamp(pixelStart + 1, image.width);
        final int pixelWidth = pixelEnd - pixelStart;

        final Uint8List slice =
            await ImageSlicer.cropHorizontal(image, pixelStart, pixelWidth);

        final String fileName = '${baseName}_s$i.png';
        await _conn.uploadImageBytes(slice, fileName);

        // LG1 is the master: its own Google Earth instance runs on the
        // same machine as the web server, so it must fetch the image via
        // 'localhost' (same pattern used in relaunch()/shutdown()/reboot()
        // above). LG2 and LG5 are separate machines and reach the master
        // over the network via the 'lg1' hostname.
        final String imageHost = slaveNo == 1 ? 'localhost' : 'lg1';
        final String kml = PanoramaOverlayManager.generatePositioned(
          'http://$imageHost:81/logos/$fileName',
          left: localLeft,
          bottom: _panoramaBottomMargin,
          width: localWidth,
          height: displayedHeight,
        );
        await _conn.execute(
            "cat <<'KMLEOF' > /var/www/html/kml/slave_$slaveNo.kml\n$kml\nKMLEOF");
      } catch (e) {
        // Never let one screen's failure stop the other screens from updating.
        debugPrint(
            'LGService: failed to send panorama slice to slave_$slaveNo: $e');
      }
    }
  }

  /// Removes the panorama image from LG5, LG1 and LG2.
  /// LG4's logo is untouched since it's never overwritten in the first place.
  Future<void> clearPanoramaImage() async {
    final String blank = PanoramaOverlayManager.blank();
    for (final slaveNo in _panoramaScreensLeftToRight) {
      final String fileName = _soloKmlFilename(slaveNo);
      await _conn.execute(
          "cat <<'KMLEOF' > /var/www/html/kml/$fileName\n$blank\nKMLEOF");
    }
  }

  /// Shows a FULL-WIDTH, bottom-anchored panorama for [siteId] across the
  /// three middle screens (LG5 left, LG1 center, LG2 right), reusing slices
  /// that were already uploaded/pre-cut server-side under
  /// `/var/www/html/logos/`, named:
  ///   <siteId>_L.png  <siteId>_C.png  <siteId>_R.png
  ///
  /// This is the reusable version of what we did manually for
  /// "la_seu_vella": call this from ANY "send to LG" button by just passing
  /// that site's [siteId] — no per-site KML files needed.
  ///
  /// Requires the three PNGs to already exist on the master's Apache
  /// (upload them once per site, e.g. via [LGConnectionState.uploadImageBytes]
  /// or manually to /var/www/html/logos/).
  Future<void> sendSitePanorama(String siteId) async {
    // Always resolve against lg1 (the master), never localhost — slaves
    // must reach the image over the network via the 'lg1' hostname, and
    // lg1 itself resolves 'lg1:81' fine too (Apache is on the same box).
    const String imageHost = 'lg1';

    final Map<int, String> suffixByScreen = {
      5: 'L', // left
      1: 'C', // center
      2: 'R', // right
    };

    for (final slaveNo in _panoramaScreensLeftToRight) {
      try {
        final String suffix = suffixByScreen[slaveNo]!;
        final String imageUrl =
            'http://$imageHost:81/logos/${siteId}_$suffix.png';
        final String kml = PanoramaOverlayManager.generateFullWidth(imageUrl);
        final String fileName = _soloKmlFilename(slaveNo);
        await _conn.execute(
            "cat <<'KMLEOF' > /var/www/html/kml/$fileName\n$kml\nKMLEOF");
      } catch (e) {
        debugPrint(
            'LGService: failed to send site panorama slice to slave_$slaveNo: $e');
      }
    }
  }

  /// Clears the full-width site panorama from LG5, LG1 and LG2.
  /// Use this before switching to a different site, or when hiding it.
  Future<void> clearSitePanorama() async {
    final String blank = PanoramaOverlayManager.blank();
    for (final slaveNo in _panoramaScreensLeftToRight) {
      final String fileName = _soloKmlFilename(slaveNo);
      await _conn.execute(
          "cat <<'KMLEOF' > /var/www/html/kml/$fileName\n$blank\nKMLEOF");
    }
  }
}
