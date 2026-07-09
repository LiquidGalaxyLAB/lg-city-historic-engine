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
    // Logo on LG4 (slave_4)
    const int slaveNo = 4;
    await execute(
        "cat <<'EOF' > /var/www/html/kml/slave_$slaveNo.kml\n$kml\nEOF");
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
  Future<void> uploadImageBytes(Uint8List bytes, String remoteFileName) async {
    if (!_isConnected || _client == null) return;
    try {
      final sftp = await _client!.sftp();
      final file = await sftp.open('/var/www/html/logos/$remoteFileName',
          mode: SftpFileOpenMode.create |
              SftpFileOpenMode.write |
              SftpFileOpenMode.truncate);
      await file.writeBytes(bytes);
      await file.close();
      await execute(
          "echo '$sudoPassword' | sudo -S chmod 644 /var/www/html/logos/$remoteFileName");
    } catch (e) {
      debugPrint('LGService SFTP Error uploading bytes to $remoteFileName: $e');
    }
  }
}
