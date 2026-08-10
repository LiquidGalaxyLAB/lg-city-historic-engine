import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/services.dart' show rootBundle;
import '../data/chromium_image_catalog.dart';
import '../main.dart';
import '../models/connection_state.dart';
import '../models/poi_model.dart';

/// Opens Chromium in kiosk mode on every LG screen to show a wide POI image
/// split across the physical wall (same approach as the dinosaur project).
class ChromiumService {
  final LGConnectionState _conn = LGConnectionState();

  static const String _htmlFileName = 'poi_view.html';
  static const Duration _defaultDisplayDuration = Duration(seconds: 3);
  static const Duration _lg1FocusDelay = Duration(milliseconds: 350);

  int _showGeneration = 0;
  final Set<String> _uploadedRemoteImages = {};

  /// Shows the POI chromium image for [duration], then closes Chromium.
  /// Returns false when the POI has no chromium asset or SSH is unavailable.
  Future<bool> showPoiImageTimed(
    POI poi, {
    Duration duration = _defaultDisplayDuration,
  }) async {
    final generation = ++_showGeneration;

    if (!_conn.isConnected) {
      debugPrint('ChromiumService: not connected');
      return false;
    }

    final assetPath = await ChromiumImageCatalog.resolve(poi);
    if (assetPath == null) {
      debugPrint('ChromiumService: no chromium image for ${poi.name}');
      return false;
    }

    final imageFileName = _remoteImageFileName(assetPath);
    final lang = languageNotifier.value;
    final title = poi.getName(lang);

    final uploadResults = await Future.wait<bool>([
      _uploadImageAsset(assetPath, imageFileName),
      _uploadHtml(imageFileName: imageFileName, title: title),
    ]);
    if (!uploadResults.every((ok) => ok)) {
      debugPrint('ChromiumService: upload failed for ${poi.name}');
      return false;
    }
    if (generation != _showGeneration) return false;

    await _stopChromiumProcesses(fast: true);
    if (generation != _showGeneration) return false;

    final opened =
        await openChromiumOnAllScreens('http://lg1:81/$_htmlFileName');
    if (!opened) {
      debugPrint('ChromiumService: could not open Chromium for ${poi.name}');
      return false;
    }

    debugPrint(
      'ChromiumService: showing ${poi.name} for ${duration.inSeconds}s',
    );

    await Future.delayed(duration);
    if (generation != _showGeneration) return true;

    await closeChromiumQuick();
    return true;
  }

  /// Cierra Chromium rápido para mostrar el balloon sin esperar refocus en 5 pantallas.
  Future<bool> closeChromiumQuick() async {
    if (!_conn.isConnected) return false;

    await _stopChromiumProcesses(fast: true);

    try {
      await _conn.execute("echo '' > /tmp/query.txt");
      return true;
    } catch (e) {
      debugPrint('ChromiumService: error cleaning query.txt: $e');
      return false;
    }
  }

  void cancelPendingShow() {
    _showGeneration++;
  }

  Future<bool> openChromiumOnAllScreens(String url) async {
    if (!_conn.isConnected) return false;

    final password = _shellQuote(_conn.password ?? '');
    final user = _shellQuote(_conn.username ?? 'lg');
    final screens = _conn.screens;

    try {
      final baseUrl =
          url.replaceFirst('http://lg1:81', 'http://localhost:81');
      final fullUrl1 = '$baseUrl?screen=1&total=$screens';
      final quotedUrl1 = _shellQuote(fullUrl1);
      final launch1 = 'chromium-browser --kiosk --no-first-run --disable-infobars '
          '$quotedUrl1 || google-chrome --kiosk --no-first-run --disable-infobars '
          '$quotedUrl1';
      await _conn.execute(
        'DISPLAY=:0 nohup sh -c ${_shellQuote(launch1)} > /dev/null 2>&1 &',
      );

      if (screens > 1) {
        final remoteLaunches = StringBuffer();
        for (var i = 2; i <= screens; i++) {
          final fullUrl = '$url?screen=$i&total=$screens';
          final quotedUrl = _shellQuote(fullUrl);
          final remoteLaunch = 'chromium-browser --kiosk --no-first-run --disable-infobars '
              '$quotedUrl || google-chrome --kiosk --no-first-run --disable-infobars '
              '$quotedUrl';
          remoteLaunches.write(
            'sshpass -p $password ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 '
            '$user@lg$i '
            '"DISPLAY=:0 nohup sh -c ${_shellQuote(remoteLaunch)} > /dev/null 2>&1 &" & ',
          );
        }
        remoteLaunches.write('wait');
        await _conn.execute(remoteLaunches.toString());
      }

      await Future.delayed(_lg1FocusDelay);
      await _conn.execute(
        "DISPLAY=:0 wmctrl -a Chromium 2>/dev/null || "
        "DISPLAY=:0 wmctrl -a 'Google Chrome' 2>/dev/null || true",
      );

      debugPrint('ChromiumService: opened on all $screens screens');
      return true;
    } catch (e) {
      debugPrint('ChromiumService: error opening Chromium: $e');
      return false;
    }
  }

  Future<bool> closeChromiumOnAllScreens({bool cancelPending = true}) async {
    if (!_conn.isConnected) return false;

    if (cancelPending) {
      cancelPendingShow();
    }
    await _stopChromiumProcesses();
    await _refocusGoogleEarthOnAllScreens();

    try {
      await _conn.execute(
        "echo 'exittour=true' > /tmp/query.txt",
      );
      await _conn.execute("echo '' > /tmp/query.txt");
      return true;
    } catch (e) {
      debugPrint('ChromiumService: error cleaning query.txt: $e');
      return false;
    }
  }

  /// Stops Chromium/Chrome without stealing focus from the next launch.
  Future<void> _stopChromiumProcesses({bool fast = false}) async {
    final password = _shellQuote(_conn.password ?? '');
    final user = _shellQuote(_conn.username ?? 'lg');
    final screens = _conn.screens;
    const killCmd =
        'pkill -f chromium-browser || true; '
        'pkill -f chromium || true; '
        'pkill -f google-chrome || true; '
        'pkill -f chrome || true';
    final betweenScreens = fast
        ? Duration.zero
        : const Duration(milliseconds: 250);

    if (fast && screens > 1) {
      final remoteKills = StringBuffer();
      for (var i = 2; i <= screens; i++) {
        remoteKills.write(
          'sshpass -p $password ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 '
          '$user@lg$i "$killCmd" & ',
        );
      }
      remoteKills.write('wait');
      await _conn.execute(killCmd);
      await _conn.execute(remoteKills.toString());
      return;
    }

    for (var i = 1; i <= screens; i++) {
      if (i == 1) {
        await _conn.execute(killCmd);
      } else {
        final hostname = 'lg$i';
        await _conn.execute(
          'sshpass -p $password ssh -o StrictHostKeyChecking=no -t $user@$hostname '
          '"$killCmd"',
        );
      }
      if (!fast) {
        await Future.delayed(betweenScreens);
      }
    }
  }

  Future<void> _refocusGoogleEarthOnAllScreens() async {
    final password = _shellQuote(_conn.password ?? '');
    final user = _shellQuote(_conn.username ?? 'lg');
    final screens = _conn.screens;
    const focusCmd =
        'sleep 1; '
        'DISPLAY=:0 wmctrl -a \'Google Earth\' || true; '
        'DISPLAY=:0 xdotool search --name \'Google Earth\' windowactivate || true; '
        'DISPLAY=:0 xdotool key F11 || true';

    for (var i = 1; i <= screens; i++) {
      if (i == 1) {
        await _conn.execute(focusCmd);
      } else {
        final hostname = 'lg$i';
        await _conn.execute(
          'sshpass -p $password ssh -o StrictHostKeyChecking=no -t $user@$hostname '
          '"$focusCmd"',
        );
      }
      await Future.delayed(const Duration(milliseconds: 350));
    }
  }
  Future<bool> _uploadImageAsset(String assetPath, String fileName) async {
    if (_uploadedRemoteImages.contains(fileName)) {
      debugPrint('ChromiumService: reusing cached image $fileName');
      return true;
    }

    try {
      final byteData = await rootBundle.load(assetPath);
      final ok = await _conn.uploadImageBytes(
        byteData.buffer.asUint8List(),
        fileName,
        remoteDir: '/var/www/html',
      );
      if (ok) {
        _uploadedRemoteImages.add(fileName);
      }
      return ok;
    } catch (e) {
      debugPrint('ChromiumService: image upload failed: $e');
      return false;
    }
  }

  Future<bool> _uploadHtml({
    required String imageFileName,
    required String title,
    double imageHeight = 95,
  }) async {
    final safeTitle = title
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;');

    final html = '''
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>$safeTitle</title>

<style>
html, body {
  margin: 0;
  padding: 0;
  width: 100%;
  height: 100%;
  overflow: hidden;
  background: black;
}

#container {
  position: relative;
  width: 100vw;
  height: 100vh;
  overflow: hidden;
}

#poi-img {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  height: ${imageHeight}vh;
  width: auto;
  max-width: none;
  object-fit: contain;
  image-rendering: auto;
}
</style>
</head>

<body>

<div id="container">
  <img id="poi-img" src="$imageFileName" alt="$safeTitle">
</div>

<script>
const params = new URLSearchParams(window.location.search);

const screen = parseInt(params.get("screen") || "1");
const total = parseInt(params.get("total") || "1");

const img = document.getElementById("poi-img");

const leftSide = [];
const rightSide = [];

for (let i = 2; i <= total; i++) {
  if (i <= Math.ceil(total / 2)) {
    rightSide.push(i);
  } else {
    leftSide.push(i);
  }
}

const screenOrder = [...leftSide, 1, ...rightSide];
const imageScreens = total;
const activeScreens = screenOrder;
const localIndex = activeScreens.indexOf(screen);

if (localIndex === -1) {
  img.style.display = "none";
}

img.onload = () => {
  if (localIndex === -1) return;

  const screenWidth = window.innerWidth;
  const wallWidth = screenWidth * imageScreens;
  const imgWidth = img.offsetWidth;
  const startX = (wallWidth - imgWidth) / 2;

  img.style.left = (startX - (localIndex * screenWidth)) + "px";
};
</script>

</body>
</html>
''';

    final ok =
        await _conn.writeRemoteFile('/var/www/html/$_htmlFileName', html);
    if (!ok) {
      debugPrint('ChromiumService: HTML upload failed');
      return false;
    }

    await _conn.execute("chmod 644 '/var/www/html/$_htmlFileName'");
    return true;
  }

  String _remoteImageFileName(String assetPath) {
    final rawName = assetPath.split('/').last;
    return rawName.replaceAll(RegExp(r'[^\w.\-]'), '_');
  }

  String _shellQuote(String value) {
    return "'${value.replaceAll("'", "'\\''")}'";
  }
}
