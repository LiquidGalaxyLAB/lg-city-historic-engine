import 'dart:convert';
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Estado global de conexión compartido por toda la app.
class LGConnectionState extends ChangeNotifier {
  static final LGConnectionState _instance = LGConnectionState._internal();
  factory LGConnectionState() => _instance;
  LGConnectionState._internal();

  bool _isConnected = false;
  String? _host;
  String? _username;
  String? _password;
  int? _port;
  int _screens = 5;
  SSHClient? _client;

  bool get conectado => _isConnected;
  String get ip => _host ?? '';
  int get screens => _screens;

  Future<bool> conectar({
    required String ip,
    required String user,
    required String password,
    int port = 22,
    int screens = 5,
  }) async {
    _host = ip;
    _username = user;
    _password = password;
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

      debugPrint('LGService: Autenticando usuario $user...');
      await _client!.authenticated.timeout(const Duration(seconds: 15));

      _isConnected = true;
      notifyListeners();
      debugPrint('LGService: Conexión establecida con éxito');

      await execute('mkdir -p /var/www/html/logos');
      await execute('mkdir -p /var/www/html/kml');

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
        _password == null)
      return;
    try {
      final socket = await SSHSocket.connect(
        _host!,
        _port!,
        timeout: const Duration(seconds: 10),
      );
      _client = SSHClient(
        socket,
        username: _username!,
        onPasswordRequest: () => _password,
      );
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
    } catch (e) {
      // Ignore errors during close
    }
    _client = null;
  }

  void desconectar() => disconnect();

  Future<String?> execute(String command) async {
    if (_client == null || _client?.isClosed == true) {
      await reconnect();
    }
    if (!_isConnected || _client == null) return null;
    try {
      final session = await _client!.execute(command);
      final result = await utf8.decodeStream(session.stdout);
      return result;
    } catch (e) {
      debugPrint('LGService: Execution error for "$command": $e');
      // Only disconnect if it's a connection-related error
      if (e.toString().contains('SocketException') ||
          e.toString().contains('Connection failed')) {
        _isConnected = false;
        notifyListeners();
      }
      return null;
    }
  }

  Future<void> sendKML(String kml) async {
    await execute("cat <<'EOF' > /var/www/html/kmls.kml\n$kml\nEOF");
    await _setKmlTxt();
  }

  Future<void> sendTimeKML(String kml) async {
    await execute("cat <<'EOF' > /var/www/html/time.kml\n$kml\nEOF");
    await _setTimeKmlTxt();
  }

  Future<void> sendLogoKML(String kml) async {
    // En tu configuración de 5 pantallas, slave_4 es la de la izquierda del todo.
    // En uno de 3 pantallas, es slave_2.
    int slaveNo = _screens == 5 ? 4 : 2;

    await execute('echo $_password | sudo -S mkdir -p /var/www/html/kml');
    await execute('echo $_password | sudo -S chmod -R 777 /var/www/html/kml');
    await execute(
      "cat <<'EOF' > /var/www/html/kml/slave_$slaveNo.kml\n$kml\nEOF",
    );
  }

  Future<void> uploadAssets() async {
    if (!_isConnected || _client == null || _password == null) return;

    final assets = [
      {'path': 'assets/images/KMLs/logos.png', 'name': 'logos.png'},
    ];

    try {
      // 1. Crear el directorio y dar permisos totales usando sudo
      await execute('echo $_password | sudo -S mkdir -p /var/www/html/logos');
      await execute(
        'echo $_password | sudo -S chmod -R 777 /var/www/html/logos',
      );

      final sftp = await _client!.sftp();

      for (var asset in assets) {
        try {
          final byteData = await rootBundle.load(asset['path']!);
          final bytes = byteData.buffer.asUint8List();
          final remotePath = '/var/www/html/logos/${asset['name']}';

          final file = await sftp.open(
            remotePath,
            mode: SftpFileOpenMode.create |
                SftpFileOpenMode.write |
                SftpFileOpenMode.truncate,
          );
          await file.write(Stream.value(bytes));
          await file.close();
          debugPrint('LGService: cargado ${asset['name']} en $remotePath');
        } catch (e) {
          debugPrint('LGService: Error subiendo ${asset['name']}: $e');
        }
      }
    } catch (e) {
      debugPrint('L  GService: Error de SFTP: $e');
    }
  }

  Future<void> _setKmlTxt() async {
    final kmlContent = "echo 'http://lg1:81/kmls.kml' > /var/www/html/kmls.txt";
    await execute(kmlContent);
  }

  Future<void> _setTimeKmlTxt() async {
    final kmlContent = "echo 'http://lg1:81/time.kml' > /var/www/html/kmls.txt";
    await execute(kmlContent);
  }

  Future<void> sendQuery(String query) async {
    await execute('echo "$query" > /tmp/query.txt');
  }
}
