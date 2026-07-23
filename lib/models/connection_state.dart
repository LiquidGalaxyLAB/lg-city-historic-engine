import 'dart:convert';
import 'dart:typed_data';
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../kmls/logos_kml.dart';

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
      final socket = await SSHSocket.connect(_host!, _port!,
          timeout: const Duration(seconds: 10));
      _client = SSHClient(socket,
          username: _username!, onPasswordRequest: () => _password);
      await _client!.authenticated.timeout(const Duration(seconds: 15));
      _isConnected = true;
      notifyListeners();
    } catch (e) {
      _isConnected = false;
      notifyListeners();
    }
  }

  Future<void> disconnect() async {
    _isConnected = false;
    notifyListeners();
    _client?.close();
    _client = null;
  }


  Future<String?> execute(String command) async {
    if (_client == null || _client?.isClosed == true) await reconnect();
    if (!_isConnected || _client == null) return null;
    try {
      final session = await _client!.execute(command);
      final stdout = await utf8.decodeStream(session.stdout);
      return stdout;
    } catch (e) {
      debugPrint('LGService Execution Error: $e');
      return null;
    }
  }

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

  /// Avisa al sync_nlc del rig de que cambió el KML solo de [machineNo].
  /// LG1 (centro) usa master_1.kml; el resto slave_N.kml.
  Future<void> notifySoloKmlChanged(int machineNo) async {
    final kmlPath = _soloKmlPath(machineNo);
    final listPath = '/var/www/html/kmls_$machineNo.txt';
    final url = _soloKmlUrl(machineNo);
    await execute('touch $kmlPath');
    await execute(
      "test -f '$listPath' && touch '$listPath' || echo '$url' > '$listPath'",
    );
  }

  Future<void> notifySlaveKmlChanged(int slaveNo) =>
      notifySoloKmlChanged(slaveNo);

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
    if (!_isConnected || _client == null) {
      debugPrint('LGService: writeRemoteFile skipped (no connection): $path');
      return false;
    }

    final bytes = utf8.encode(content);

    // 1) SFTP — mismo canal que las imágenes del balloon; evita límites del shell.
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
      debugPrint('LGService: SFTP write failed for $path: $e');
    }

    // 2) Heredoc sin sudo — funcionaba en rigs con /var/www/html en 777.
    try {
      const marker = 'LGKMLWRITEEOF';
      await execute("cat <<'$marker' > '$path'\n$content\n$marker");
      final sizeStr = await execute("wc -c < '$path'");
      final size = int.tryParse(sizeStr?.trim() ?? '') ?? 0;
      if (size > 0) {
        debugPrint('LGService: heredoc wrote $path ($size bytes)');
        return true;
      }
    } catch (e) {
      debugPrint('LGService: heredoc write failed for $path: $e');
    }

    // 3) Base64 por shell (solo payloads pequeños).
    try {
      final b64 = base64Encode(bytes);
      if (useSudo && (sudoPassword?.isNotEmpty ?? false)) {
        final sudo = sudoPassword!;
        await execute(
          "echo '$sudo' | sudo -S bash -c \"echo '$b64' | base64 -d > '$path'\"",
        );
      } else {
        await execute("echo '$b64' | base64 -d > '$path'");
      }
      debugPrint('LGService: base64 wrote ${bytes.length} bytes -> $path');
      return true;
    } catch (e) {
      debugPrint('LGService: base64 write failed for $path: $e');
      return false;
    }
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
  Future<void> uploadImageBytes(
    Uint8List bytes,
    String remoteFileName, {
    String remoteDir = '/var/www/html/logos',
  }) async {
    if (!_isConnected || _client == null) return;
    final remotePath = '$remoteDir/$remoteFileName';
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
      await execute(
        "echo '$sudoPassword' | sudo -S chmod 644 $remotePath",
      );
    } catch (e) {
      debugPrint('LGService SFTP Error uploading bytes to $remotePath: $e');
    }
  }
}