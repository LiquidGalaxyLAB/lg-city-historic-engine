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

  int _showGeneration = 0;

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

    if (!await _uploadImageAsset(assetPath, imageFileName)) {
      return false;
    }

    if (!await _uploadHtml(
      imageFileName: imageFileName,
      title: title,
    )) {
      return false;
    }

    await _killChromiumOnAllScreens();
    if (generation != _showGeneration) return false;

    final opened =
        await openChromiumOnAllScreens('http://lg1:81/$_htmlFileName');
    if (!opened) return false;

    await Future.delayed(duration);
    if (generation != _showGeneration) return true;

    await closeChromiumOnAllScreens();
    return true;
  }

  void cancelPendingShow() {
    _showGeneration++;
  }

  Future<bool> openChromiumOnAllScreens(String url) async {
    if (!_conn.isConnected) return false;

    final password = _conn.password;
    final user = _conn.username;
    final screens = _conn.screens;

    try {
      for (var i = 1; i <= screens; i++) {
        final fullUrl = '$url?screen=$i&total=$screens';
        final hostname = i == 1 ? 'localhost' : 'lg$i';
        final command =
            'sshpass -p $password ssh -o StrictHostKeyChecking=no -t $user@$hostname '
            '"DISPLAY=:0 chromium-browser --kiosk --no-first-run --disable-infobars '
            "'$fullUrl' > /dev/null 2>&1 &\"";

        await _conn.execute(command);
        debugPrint('ChromiumService: opened on lg$i');
        await Future.delayed(const Duration(milliseconds: 500));
      }
      return true;
    } catch (e) {
      debugPrint('ChromiumService: error opening Chromium: $e');
      return false;
    }
  }

  Future<bool> closeChromiumOnAllScreens() async {
    if (!_conn.isConnected) return false;

    cancelPendingShow();
    await _killChromiumOnAllScreens();

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

  Future<void> _killChromiumOnAllScreens() async {
    final password = _conn.password;
    final user = _conn.username;
    final screens = _conn.screens;

    for (var i = 1; i <= screens; i++) {
      final hostname = i == 1 ? 'localhost' : 'lg$i';
      final command =
          'sshpass -p $password ssh -o StrictHostKeyChecking=no -t $user@$hostname '
          '"pkill -f chromium-browser || true; '
          'pkill -f chromium || true; '
          'pkill -f chrome || true; '
          'sleep 2; '
          'DISPLAY=:0 wmctrl -a \'Google Earth\' || true; '
          'DISPLAY=:0 xdotool search --name \'Google Earth\' windowactivate || true; '
          'DISPLAY=:0 xdotool key F11 || true"';

      await _conn.execute(command);
      await Future.delayed(const Duration(milliseconds: 700));
    }
  }

  Future<bool> _uploadImageAsset(String assetPath, String fileName) async {
    try {
      final byteData = await rootBundle.load(assetPath);
      await _conn.uploadImageBytes(
        byteData.buffer.asUint8List(),
        fileName,
        remoteDir: '/var/www/html',
      );
      return true;
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
    }
    return ok;
  }

  String _remoteImageFileName(String assetPath) {
    final rawName = assetPath.split('/').last;
    return rawName.replaceAll(RegExp(r'[^\w.\-]'), '_');
  }
}
