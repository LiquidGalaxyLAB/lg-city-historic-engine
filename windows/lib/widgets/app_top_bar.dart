import 'package:flutter/material.dart';
import '../models/connection_state.dart';
import 'm_superior.dart';

/// Top bar reutilizable para todas las páginas.
/// [onDarkBackground]: true = sobre imagen oscura (solo muestra el icono wifi en blanco)
/// [wifiOnly]: true = solo muestra el icono wifi (sin botón menú), útil cuando el menú se gestiona aparte
class AppTopBar extends StatefulWidget {
  final bool onDarkBackground;
  final bool wifiOnly;
  final String? currentTitle;

  const AppTopBar({super.key, this.onDarkBackground = false, this.wifiOnly = false, this.currentTitle});

  @override
  State<AppTopBar> createState() => _AppTopBarState();
}

class _AppTopBarState extends State<AppTopBar> {
  final _conn = LGConnectionState();

  @override
  void initState() {
    super.initState();
    _conn.addListener(_refresh);
  }

  @override
  void dispose() {
    _conn.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final connected = _conn.conectado;

    // Modo solo wifi (para headers con imagen oscura)
    if (widget.wifiOnly) {
      return _WifiIcon(connected: connected, onDark: widget.onDarkBackground);
    }

    // Modo completo: menú + wifi
    if (widget.onDarkBackground) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => MenuFlotante.mostrar(context, currentTitle: widget.currentTitle),
            child: const Icon(Icons.menu, color: Colors.white, size: 32),
          ),
          _WifiIcon(connected: connected, onDark: true),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => MenuFlotante.mostrar(context, currentTitle: widget.currentTitle),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6)],
            ),
            child: const Icon(Icons.menu, size: 28),
          ),
        ),
        _WifiIcon(connected: connected, onDark: false),
      ],
    );
  }
}

class _WifiIcon extends StatelessWidget {
  final bool connected;
  final bool onDark;

  const _WifiIcon({required this.connected, required this.onDark});

  @override
  Widget build(BuildContext context) {
    if (onDark) {
      return Icon(
        connected ? Icons.wifi : Icons.wifi_off,
        color: connected ? const Color(0xFF80E8C0) : Colors.white70,
        size: 30,
      );
    }
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: connected ? const Color(0xFFD4EDD4) : const Color(0xFFD4C9B0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        connected ? Icons.wifi : Icons.wifi_off,
        size: 26,
        color: connected ? const Color(0xFF2E7D52) : const Color(0xFF6B5B45),
      ),
    );
  }
}
