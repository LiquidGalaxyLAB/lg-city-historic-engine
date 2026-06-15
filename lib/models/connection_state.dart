import 'dart:convert';
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

  bool get conectado => _isConnected;
  String get ip => _host ?? '';
  String? get username => _username;
  String? get password => _password;
  String? get sudoPassword => _sudoPassword ?? _password;
  int get screens => _screens;

  Future<bool> conectar({
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

      // Usamos comillas simples para el password para evitar problemas con caracteres especiales
      final sudo = this.sudoPassword;
      await execute("echo '$sudo' | sudo -S mkdir -p /var/www/html/logos");
      await execute("echo '$sudo' | sudo -S mkdir -p /var/www/html/kml");
      await execute("echo '$sudo' | sudo -S chmod -R 777 /var/www/html");

      await uploadAssets();
      await sendLogoKML(LogoOverlayManager.generate());

      return true;
    } catch (e) {
      debugPrint('LGService: Error de conexión: $e');
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
    try {
      _client?.close();
    } catch (e) {}
    _client = null;
  }

  void desconectar() => disconnect();

  Future<String?> execute(String command) async {
    if (_client == null || _client?.isClosed == true) await reconnect();
    if (!_isConnected || _client == null) return null;
    try {
      final session = await _client!.execute(command);
      final stdout = await utf8.decodeStream(session.stdout);
      final stderr = await utf8.decodeStream(session.stderr);

      if (stderr.isNotEmpty) {
        debugPrint('LGService Command Stderr: $stderr');
      }
      return stdout;
    } catch (e) {
      debugPrint('LGService Execution Error: $e');
      return null;
    }
  }

  Future<void> sendLogoKML(String kml) async {
    int slaveNo = _screens == 5 ? 4 : 2;
    await execute(
        "cat <<'EOF' > /var/www/html/kml/slave_$slaveNo.kml\n$kml\nEOF");
  }

  Future<void> uploadAssets() async {
    if (!_isConnected || _client == null) return;
    try {
      final sftp = await _client!.sftp();
      final byteData = await rootBundle.load('assets/images/KMLs/logos.png');
      final bytes = byteData.buffer.asUint8List();
      final file = await sftp.open('/var/www/html/logos/logos.png',
          mode: SftpFileOpenMode.create |
              SftpFileOpenMode.write |
              SftpFileOpenMode.truncate);
      await file.writeBytes(bytes);
      await file.close();
      await execute(
          "echo '$sudoPassword' | sudo -S chmod 644 /var/www/html/logos/logos.png");
    } catch (e) {
      debugPrint('LGService SFTP Error: $e');
    }
  }
}
