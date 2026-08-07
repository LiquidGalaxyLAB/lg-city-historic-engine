import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/connection_state.dart';
import '../navigation/app_navigation.dart';
import 'm_superior.dart';
import 'section_back_button.dart';

/// Reusable top bar for all pages.
/// [onDarkBackground]: true = over a dark image (shows only the white wifi icon)
/// [wifiOnly]: true = shows only the wifi icon (no menu button), useful when the menu is managed separately
/// [showBack]: shows a back button before the menu
class AppTopBar extends StatefulWidget {
  final bool onDarkBackground;
  final bool wifiOnly;
  final bool showBack;
  final String? currentTitle;
  final VoidCallback? onBack;

  const AppTopBar({
    super.key,
    this.onDarkBackground = false,
    this.wifiOnly = false,
    this.showBack = false,
    this.currentTitle,
    this.onBack,
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
      return _WifiIcon(
        connected: connected,
        onDark: widget.onDarkBackground,
        onTap: () => _openConnectPage(context),
      );
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
          _WifiIcon(
            connected: connected,
            onDark: true,
            onTap: () => _openConnectPage(context),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.showBack)
              SectionBackButton(
                icon: Icons.arrow_back,
                iconSize: 28,
                onPressed: widget.onBack,
              ),
            GestureDetector(
              onTap: () => FloatingMenu.show(
                context,
                currentTitle: widget.currentTitle,
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: AppTheme.shadowAlpha(context),
                      ),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.menu,
                  size: 28,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
        _WifiIcon(
          connected: connected,
          onDark: false,
          onTap: () => _openConnectPage(context),
        ),
      ],
    );
  }

  void _openConnectPage(BuildContext context) {
    AppNavigation.openConnect(context);
  }
}

class _WifiIcon extends StatelessWidget {
  final bool connected;
  final bool onDark;
  final VoidCallback? onTap;

  const _WifiIcon({
    required this.connected,
    required this.onDark,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (onDark) {
      return GestureDetector(
        onTap: onTap,
        child: Icon(
          connected ? Icons.wifi : Icons.wifi_off,
          color: connected ? const Color(0xFF80E8C0) : Colors.white70,
          size: 30,
        ),
      );
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: connected
              ? (Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF2A3D2A)
                  : const Color(0xFFD4EDD4))
              : (Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF3A342C)
                  : const Color(0xFFD4C9B0)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          connected ? Icons.wifi : Icons.wifi_off,
          size: 26,
          color: connected ? const Color(0xFF2E7D52) : const Color(0xFF6B5B45),
        ),
      ),
    );
  }
}
