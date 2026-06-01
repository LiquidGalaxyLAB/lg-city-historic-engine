import 'package:flutter/material.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:prueba/models/logo_overlay_manager.dart';
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

      await _client!.authenticated;

      _conectado = true;

      final logoManager = LogoOverlayManager(_client!);
      await logoManager.showLogo(
        screens: _screens,
        masterIp: _ip,           // ← añadido
        assetPath: 'assets/images/logos.png',
      );

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
}