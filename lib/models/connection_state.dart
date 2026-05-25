import 'package:flutter/material.dart';

/// Estado global de conexión compartido por toda la app.
class LGConnectionState extends ChangeNotifier {
  static final LGConnectionState _instance = LGConnectionState._internal();
  factory LGConnectionState() => _instance;
  LGConnectionState._internal();

  bool _conectado = false;
  String _ip = '';

  bool get conectado => _conectado;
  String get ip => _ip;

  void conectar(String ip) {
    _conectado = true;
    _ip = ip;
    notifyListeners();
  }

  void desconectar() {
    _conectado = false;
    _ip = '';
    notifyListeners();
  }
}
