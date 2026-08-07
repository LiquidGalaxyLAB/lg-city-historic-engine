import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../kmls/logos_kml.dart';
import '../kmls/poi_highlight_circle.dart';

class LGConnectionState extends ChangeNotifier {
  static final LGConnectionState _instance = LGConnectionState._internal();
  factory LGConnectionState() => _instance;
  LGConnectionState._internal();

  bool _isConnected = false;
  String? _host;
  String? _username;
  String? _password;
  String? _sudoPassword;
  int? _port;
  int _screens = 5;
  SSHClient? _client;
  Future<void> _opQueue = Future.value();

  /// Serializa operaciones SSH/SFTP para evitar condiciones de carrera en el rig.
  Future<T> runExclusive<T>(Future<T> Function() action) async {
    final previous = _opQueue;
    final gate = Completer<void>();
    _opQueue = gate.future;
    await previous;
    try {
      return await action();
    } finally {
      gate.complete();
    }
  }

  bool get isConnected => _isConnected;
  String get ip => _host ?? '';
  String? get username => _username;
  String? get password => _password;
  String? get sudoPassword => _sudoPassword ?? _password;
  int get screens => _screens;

  Future<bool> connect({
    required String ip,
    required String user,
    required String password,
    String? sudoPassword,
    int port = 22,
    int screens = 5,
  }) async {
    _host = ip;
    _username = user;
    _password = password;
    _sudoPassword = sudoPassword;
    _port = port;
    _screens = screens;

    try {
      final socket = await SSHSocket.connect(
        _host!,
        _port!,
        timeout: const Duration(seconds: 10),
      );

      _client = SSHClient(
        socket,
        username: user,
        onPasswordRequest: () => password,
      );

      await _client!.authenticated.timeout(const Duration(seconds: 15));

      _isConnected = true;
      notifyListeners();

      final sudo = this.sudoPassword;
      await execute("echo '$sudo' | sudo -S mkdir -p /var/www/html/logos");
      await execute("echo '$sudo' | sudo -S mkdir -p /var/www/html/kml");
      await execute("echo '$sudo' | sudo -S chmod -R 777 /var/www/html");

      await uploadAssets();
      // Send the logo to the left screen (LG4)
      await sendLogoKML(LogoOverlayManager.generate());

      return true;
    } catch (e) {
      debugPrint('LGService: Connection error: $e');
      _isConnected = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> reconnect() async {
    if (_host == null ||
        _port == null ||
        _username == null ||
        _password == null) return;
    try {
      try {
        _client?.close();
      } catch (_) {}
      _client = null;
      await Future.delayed(const Duration(milliseconds: 250));

      final socket = await SSHSocket.connect(_host!, _port!,
          timeout: const Duration(seconds: 10));
      _client = SSHClient(socket,
          username: _username!, onPasswordRequest: () => _password);
      await _client!.authenticated.timeout(const Duration(seconds: 15));
      _isConnected = true;
      notifyListeners();
    } catch (e) {
      debugPrint('LGService: reconnect failed: $e');
      _isConnected = false;
      notifyListeners();
    }
  }

  Future<void> _resetClient() async {
    _isConnected = false;
    try {
      _client?.close();
    } catch (_) {}
    _client = null;
    await Future.delayed(const Duration(milliseconds: 350));
    await reconnect();
  }

  bool _isRecoverableSshError(Object e) {
    final message = e.toString().toLowerCase();
    return message.contains('sshchannelopenerror') ||
        message.contains('open failed') ||
        message.contains('connection closed') ||
        message.contains('socket');
  }

  Future<String?> _executeRaw(String command, {int retries = 3}) async {
    for (var attempt = 0; attempt < retries; attempt++) {
      if (_client == null || _client?.isClosed == true) await reconnect();
      if (!_isConnected || _client == null) return null;
      try {
        final session = await _client!.execute(command);
        final stdout = await utf8.decodeStream(session.stdout);
        await session.done;
        return stdout;
      } catch (e) {
        debugPrint(
          'LGService Execution Error (attempt ${attempt + 1}/$retries): $e',
        );
        if (_isRecoverableSshError(e) && attempt < retries - 1) {
          await _resetClient();
          continue;
        }
        return null;
      }
    }
    return null;
  }

  Future<void> disconnect() async {
    _isConnected = false;
    notifyListeners();
    _client?.close();
    _client = null;
  }

  /// Comprueba que SSH responde antes de enviar un POI.
  Future<bool> ensureReady() async {
    if (_client == null || _client?.isClosed == true) {
      await reconnect();
    }
    if (!_isConnected || _client == null) return false;

    for (var attempt = 0; attempt < 3; attempt++) {
      final pong = await execute('echo lg_ok');
      if (pong != null && pong.contains('lg_ok')) return true;
      await _resetClient();
      await Future.delayed(const Duration(milliseconds: 400));
    }
    return false;
  }

  Future<String?> execute(String command) async {
    return runExclusive(() => _executeRaw(command));
  }

  /// Avisa al sync_nlc del rig de que cambió el KML solo de [machineNo].
  /// LG1 (centro) usa master_1.kml; el resto slave_N.kml.
  Future<bool> notifySoloKmlChanged(int machineNo) async {
    final kmlPath = _soloKmlPath(machineNo);
    final listPath = '/var/www/html/kmls_$machineNo.txt';
    final url = _soloKmlUrl(machineNo);

    for (var attempt = 0; attempt < 3; attempt++) {
      final touchKml = await execute('touch $kmlPath');
      final touchList = await execute(
        "test -f '$listPath' && touch '$listPath' || echo '$url' > '$listPath'",
      );
      if (touchKml != null && touchList != null) {
        debugPrint('LGService: notify OK -> $kmlPath');
        return true;
      }
      debugPrint(
        'LGService: notify FAILED for $kmlPath (attempt ${attempt + 1}/3)',
      );
      await _resetClient();
      await Future.delayed(const Duration(milliseconds: 400));
    }
    return false;
  }

  Future<bool> notifySlaveKmlChanged(int slaveNo) =>
      notifySoloKmlChanged(slaveNo);

  /// Paths de listas KML que debe refrescar cada pantalla del rig.
  List<String> _poiHighlightListPaths() {
    return [
      '/var/www/html/kmls.txt',
      for (var i = 1; i <= _screens; i++) '/var/www/html/kmls_$i.txt',
    ];
  }

  String _shellQuote(String value) => "'${value.replaceAll("'", "'\\''")}'";

  String _poiHighlightListUpdateScript(String url) {
    final lists = _poiHighlightListPaths().map(_shellQuote).join(' ');
    final quotedUrl = _shellQuote(url);
    final kmlPath = _shellQuote(PoiHighlightCircle.kmlPath);

    return '''
update_poi_highlight_list() {
  local list="\$1"
  local url=$quotedUrl
  if [ -f "\$list" ]; then
    grep -v 'poi_highlight.kml' "\$list" > "\$list.new" || true
    mv "\$list.new" "\$list"
  else
    : > "\$list"
  fi
  echo "\$url" >> "\$list"
  touch "\$list"
}
for list in $lists; do
  update_poi_highlight_list "\$list"
done
touch $kmlPath
''';
  }

  String _poiHighlightListRemoveScript() {
    final lists = _poiHighlightListPaths().map(_shellQuote).join(' ');
    final kmlPath = _shellQuote(PoiHighlightCircle.kmlPath);

    return '''
for list in $lists; do
  if [ -f "\$list" ]; then
    grep -v 'poi_highlight.kml' "\$list" > "\$list.new" || true
    mv "\$list.new" "\$list"
    touch "\$list"
  fi
done
touch $kmlPath
''';
  }

  /// Refresca el contorno POI en el globo compartido y en cada pantalla del rig.
  ///
  /// Registra la URL en `kmls.txt` (master.kml) y en cada `kmls_N.txt`
  /// (master_1 / slave_N) para que LG1–LG5 reciban el NetworkLink.
  Future<bool> notifyPoiHighlightOnAllScreens({int? cacheVersion}) async {
    final version =
        cacheVersion ?? DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final url = '${PoiHighlightCircle.kmlUrl}?v=$version';
    final script = _poiHighlightListUpdateScript(url);

    for (var attempt = 0; attempt < 3; attempt++) {
      final ok = await execute(script);
      if (ok != null) {
        for (var screen = 1; screen <= _screens; screen++) {
          await notifySoloKmlChanged(screen);
        }
        debugPrint(
          'LGService: notify OK -> $url (kmls.txt + kmls_1..$_screens.txt)',
        );
        return true;
      }
      debugPrint(
        'LGService: notify FAILED for poi_highlight (attempt ${attempt + 1}/3)',
      );
      await _resetClient();
      await Future.delayed(const Duration(milliseconds: 400));
    }
    return false;
  }

  /// Quita el contorno POI de todas las listas KML del rig.
  Future<bool> removePoiHighlightFromAllScreens() async {
    final script = _poiHighlightListRemoveScript();

    for (var attempt = 0; attempt < 3; attempt++) {
      final ok = await execute(script);
      if (ok != null) {
        for (var screen = 1; screen <= _screens; screen++) {
          await notifySoloKmlChanged(screen);
        }
        debugPrint(
          'LGService: removed poi_highlight from kmls.txt + kmls_1..$_screens.txt',
        );
        return true;
      }
      await _resetClient();
      await Future.delayed(const Duration(milliseconds: 400));
    }
    return false;
  }

  /// Refresca la capa principal del globo registrada en `kmls.txt`.
  Future<bool> notifyMainKmlChanged() => notifyPoiHighlightOnAllScreens();

  Future<void> sendLogoKML(String kml) async {
    final slaveNo = _leftMostScreen(_screens);
    final withId = _ensureDocumentId(kml, 'slave_$slaveNo');
    await writeRemoteFile('/var/www/html/kml/slave_$slaveNo.kml', withId);
    await notifySlaveKmlChanged(slaveNo);
  }

  /// Pantalla izquierda del rig según número de pantallas (lg-server formula).
  int _leftMostScreen(int screens) => (screens ~/ 2) + 2;

  /// Pantalla derecha del rig según número de pantallas (lg-server formula).
  int _rightMostScreen(int screens) => (screens ~/ 2) + 1;

  String _ensureDocumentId(String kml, String documentId) {
    if (kml.contains('id="$documentId"') || kml.contains("id='$documentId'")) {
      return kml;
    }
    return kml.replaceFirst('<Document>', '<Document id="$documentId">');
  }

  String _soloKmlPath(int machineNo) => machineNo == 1
      ? '/var/www/html/kml/master_1.kml'
      : '/var/www/html/kml/slave_$machineNo.kml';

  String _soloKmlUrl(int machineNo) => machineNo == 1
      ? 'http://lg1:81/kml/master_1.kml'
      : 'http://lg1:81/kml/slave_$machineNo.kml';

  /// Escribe el KML solo de una máquina (1 = centro/master, resto = slave).
  Future<bool> writeSoloKml(int machineNo, String content) async {
    return writeRemoteFile(_soloKmlPath(machineNo), content);
  }

  /// Escribe un KML en la pantalla esclava [slaveNo] (p. ej. 3 = LG3 balloon).
  Future<bool> writeSlaveKml(int slaveNo, String content) async {
    return writeSoloKml(slaveNo, content);
  }

  /// Writes [content] to [path] on the remote rig.
  ///
  /// Prefiere SFTP (fiable para KML grandes). Si falla, prueba heredoc y
  /// base64 como respaldo.
  Future<bool> writeRemoteFile(
    String path,
    String content, {
    bool useSudo = false,
  }) async {
    return runExclusive(
      () => _writeRemoteFileRaw(path, content, useSudo: useSudo),
    );
  }

  Future<bool> _writeRemoteFileRaw(
    String path,
    String content, {
    bool useSudo = false,
  }) async {
    for (var attempt = 0; attempt < 3; attempt++) {
      if (_client == null || _client?.isClosed == true) await reconnect();
      if (!_isConnected || _client == null) {
        debugPrint('LGService: writeRemoteFile skipped (no connection): $path');
        return false;
      }

      final bytes = utf8.encode(content);

      // 1) SFTP
      try {
        final sftp = await _client!.sftp();
        final file = await sftp.open(
          path,
          mode: SftpFileOpenMode.create |
              SftpFileOpenMode.write |
              SftpFileOpenMode.truncate,
        );
        await file.writeBytes(bytes);
        await file.close();
        debugPrint('LGService: SFTP wrote ${bytes.length} bytes -> $path');
        return true;
      } catch (e) {
        debugPrint(
          'LGService: SFTP write failed for $path (attempt ${attempt + 1}/3): $e',
        );
        if (_isRecoverableSshError(e) && attempt < 2) {
          await _resetClient();
          continue;
        }
      }

      // 2) Heredoc
      try {
        const marker = 'LGKMLWRITEEOF';
        await _executeRaw("cat <<'$marker' > '$path'\n$content\n$marker");
        final sizeStr = await _executeRaw("wc -c < '$path'");
        final size = int.tryParse(sizeStr?.trim() ?? '') ?? 0;
        if (size > 0) {
          debugPrint('LGService: heredoc wrote $path ($size bytes)');
          return true;
        }
      } catch (e) {
        debugPrint('LGService: heredoc write failed for $path: $e');
      }

      // 3) Base64
      try {
        final b64 = base64Encode(bytes);
        if (useSudo && (sudoPassword?.isNotEmpty ?? false)) {
          final sudo = sudoPassword!;
          await _executeRaw(
            "echo '$sudo' | sudo -S bash -c \"echo '$b64' | base64 -d > '$path'\"",
          );
        } else {
          await _executeRaw("echo '$b64' | base64 -d > '$path'");
        }
        debugPrint('LGService: base64 wrote ${bytes.length} bytes -> $path');
        return true;
      } catch (e) {
        debugPrint('LGService: base64 write failed for $path: $e');
      }

      if (attempt < 2) {
        await _resetClient();
      }
    }
    return false;
  }

  Future<void> uploadAssets() async {
    await uploadImageAsset('assets/images/KMLs/logos.png', 'logos.png');
  }

  /// Uploads a bundled Flutter asset image to the LG rig so it can be
  /// referenced from a KML (e.g. via http://lg1:81/logos/<remoteFileName>).
  Future<void> uploadImageAsset(String assetPath, String remoteFileName) async {
    if (!_isConnected || _client == null) return;
    try {
      final byteData = await rootBundle.load(assetPath);
      await uploadImageBytes(byteData.buffer.asUint8List(), remoteFileName);
    } catch (e) {
      debugPrint('LGService SFTP Error uploading $assetPath: $e');
    }
  }

  /// Uploads raw image bytes (e.g. a slice cropped in memory) to the LG rig.
  Future<bool> uploadImageBytes(
    Uint8List bytes,
    String remoteFileName, {
    String remoteDir = '/var/www/html/logos',
  }) async {
    return runExclusive(() async {
      final remotePath = '$remoteDir/$remoteFileName';
      for (var attempt = 0; attempt < 3; attempt++) {
        if (_client == null || _client?.isClosed == true) await reconnect();
        if (!_isConnected || _client == null) return false;
        try {
          final sftp = await _client!.sftp();
          final file = await sftp.open(
            remotePath,
            mode: SftpFileOpenMode.create |
                SftpFileOpenMode.write |
                SftpFileOpenMode.truncate,
          );
          await file.writeBytes(bytes);
          await file.close();
          await _executeRaw(
            "echo '$sudoPassword' | sudo -S chmod 644 '$remotePath'",
          );
          debugPrint(
            'LGService: uploaded ${bytes.length} bytes -> $remotePath',
          );
          return true;
        } catch (e) {
          debugPrint(
            'LGService SFTP Error uploading bytes to $remotePath '
            '(attempt ${attempt + 1}/3): $e',
          );
          if (attempt < 2) {
            await _resetClient();
          }
        }
      }
      return false;
    });
  }
}
