import 'package:flutter/material.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../kml/logoche_logos.dart';

/// Estado global de conexión compartido por toda la app.
class LGConnectionState extends ChangeNotifier {
  static final LGConnectionState _instance = LGConnectionState._internal();
  factory LGConnectionState() => _instance;
  LGConnectionState._internal();

  bool _conectado = false;
  String _ip = '';
  String _user = '';
  String _password = '';
  int _port = 22;
  int _screens = 5;

  SSHClient? _client;

  bool get conectado => _conectado;
  String get ip => _ip;
  int get screens => _screens;

  Future<bool> conectar({
    required String ip,
    required String user,
    required String password,
    int port = 22,
    int screens = 5,
  }) async {
    try {
      _ip = ip;
      _user = user;
      _password = password;
      _port = port;
      _screens = screens;

      final socket = await SSHSocket.connect(
        _ip,
        _port,
        timeout: const Duration(seconds: 5),
      );
      _client = SSHClient(
        socket,
        username: _user,
        onPasswordRequest: () => _password,
      );

      await _client!.authenticated;

      _conectado = true;
      await showLogo();

      notifyListeners();
      return true;
    } catch (e) {
      print('Error de conexión SSH: $e');
      _conectado = false;
      _client = null;
      notifyListeners();
      return false;
    }
  }

  void desconectar() {
    _client?.close();
    _client = null;
    _conectado = false;
    notifyListeners();
  }

  Future<String?> ejecutar(String comando) async {
    if (!_conectado || _client == null) return null;
    try {
      final result = await _client!.run(comando);
      return String.fromCharCodes(result);
    } catch (e) {
      print('Error al ejecutar comando: $e');
      return null;
    }
  }

  // ── TOOLS ──

  Future<void> relaunchLG() async {
    for (var i = _screens; i >= 1; i--) {
      await ejecutar(
        'sshpass -p $_password ssh -t lg$i "/home/$_user/bin/lg-relaunch"',
      );
    }
  }

  Future<void> rebootLG() async {
    for (var i = _screens; i >= 1; i--) {
      await ejecutar(
        'sshpass -p $_password ssh -t lg$i "echo $_password | sudo -S reboot"',
      );
    }
  }

  Future<void> shutdownLG() async {
    for (var i = _screens; i >= 1; i--) {
      await ejecutar(
        'sshpass -p $_password ssh -t lg$i "echo $_password | sudo -S poweroff"',
      );
    }
  }

  Future<void> cleanKMLs() async {
    try {
      await ejecutar('> /var/www/html/kmls.txt');
      await cleanLogos();
    } catch (e) {
      print('Error cleaning KMLs: $e');
    }
  }

  Future<void> showLogo() async {
    if (_client == null) return;
    try {
      final sftp = await _client!.sftp();
      // Logo solicitado: logoche_logos.png
      final bytes = await rootBundle.load('assets/images/logoche_logos.png');
      final file = await sftp.open(
        '/var/www/html/logo.png',
        mode: SftpFileOpenMode.create | SftpFileOpenMode.write,
      );
      await file.writeBytes(bytes.buffer.asUint8List());

      int leftSlave = (_screens / 2).floor() + 2;

      // Usando el generador externo de KML con el método correcto
      String logoKml = LogocheLogosKML.generate();

      await ejecutar(
        "echo '$logoKml' > /var/www/html/kml/slave_$leftSlave.kml",
      );
    } catch (e) {
      print('Error showing logo: $e');
    }
  }

  Future<void> cleanLogos() async {
    String blankKml = '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document></Document>
</kml>''';

    for (var i = 2; i <= _screens; i++) {
      await ejecutar("echo '$blankKml' > /var/www/html/kml/slave_$i.kml");
    }
  }
}
