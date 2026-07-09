import 'package:flutter/material.dart';
import '../models/connection_state.dart';
import 'm_superior.dart';

/// Reusable top bar for all pages.
/// [onDarkBackground]: true = over a dark image (shows only the white wifi icon)
/// [wifiOnly]: true = shows only the wifi icon (no menu button), useful when the menu is managed separately
class AppTopBar extends StatefulWidget {
  final bool onDarkBackground;
  final bool wifiOnly;
  final String? currentTitle;

  const AppTopBar({
    super.key,
    this.onDarkBackground = false,
    this.wifiOnly = false,
    this.currentTitle,
  });

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
    final connected = _conn.isConnected;

    // Wifi-only mode (for headers with a dark image)
    if (widget.wifiOnly) {
      return _WifiIcon(connected: connected, onDark: widget.onDarkBackground);
    }

    // Full mode: menu + wifi
    if (widget.onDarkBackground) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => FloatingMenu.show(
              context,
              currentTitle: widget.currentTitle,
            ),
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
          onTap: () =>
              FloatingMenu.show(context, currentTitle: widget.currentTitle),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 6,
                ),
              ],
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
