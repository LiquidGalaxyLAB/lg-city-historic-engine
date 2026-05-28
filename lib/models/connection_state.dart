import 'package:flutter/material.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/services.dart';
import 'dart:async';

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

      final socket = await SSHSocket.connect(_ip, _port, timeout: const Duration(seconds: 5));
      _client = SSHClient(
        socket,
        username: _user,
        onPasswordRequest: () => _password,
      );

      // Esperar a que se autentique o falle
      await _client!.authenticated;
      
      _conectado = true;
      
      // Intentar enviar el logo tras conectar
      await _sendLogo();
      
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

  Future<void> _sendLogo() async {
    if (_client == null) return;

    try {
      // 1. Subir la imagen al LG vía SFTP
      final sftp = await _client!.sftp();
      // Usamos el nuevo logo
      final bytes = await rootBundle.load('assets/images/2026-05-17 09_25_11-NVIDIA GeForce Overlay.png');
      
      // Lo guardamos como logo.png para evitar problemas con espacios en el nombre de archivo en la URL
      final file = await sftp.open('/var/www/html/logo.png', 
          mode: SftpFileOpenMode.create | SftpFileOpenMode.write);
      await file.writeBytes(bytes.buffer.asUint8List());

      // 2. Determinar el slave de la izquierda. 
      // Según la lógica proporcionada: (screens / 2).floor() + 2
      int leftSlave = (_screens / 2).floor() + 2;

      // 3. Crear el KML del logo (ScreenOverlay)
      String logoKml = '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2">
  <Document>
    <name>Logo</name>
    <ScreenOverlay>
      <name>Logo</name>
      <Icon>
        <href>http://lg1/logo.png</href>
      </Icon>
      <overlayXY x="0" y="1" xunits="fraction" yunits="fraction"/>
      <screenXY x="0.02" y="0.95" xunits="fraction" yunits="fraction"/>
      <rotationXY x="0" y="0" xunits="fraction" yunits="fraction"/>
      <size x="0.4" y="0.4" xunits="fraction" yunits="fraction"/>
    </ScreenOverlay>
  </Document>
</kml>''';

      // 4. Escribir el KML en el slave correspondiente para que se visualice
      await ejecutar("echo '$logoKml' > /var/www/html/kml/slave_$leftSlave.kml");
      
    } catch (e) {
      print('Error al enviar el logo: $e');
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
}
