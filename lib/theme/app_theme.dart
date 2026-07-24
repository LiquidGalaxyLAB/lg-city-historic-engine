import 'package:flutter/material.dart';

/// Colores y [ThemeData] compartidos por toda la app.
class AppTheme {
  AppTheme._();

  static const Color _seed = Color(0xFF8B7355);

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: Brightness.light,
      surface: Colors.white,
      onSurface: const Color(0xFF1C1C1E),
      onSurfaceVariant: const Color(0xFF6B6459),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: const Color(0xFFF0EBE0),
      cardColor: Colors.white,
      dividerColor: const Color(0xFFF2F2F7),
      iconTheme: const IconThemeData(color: Color(0xFF1C1C1E)),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFF1C1C1E)),
        bodyMedium: TextStyle(color: Colors.black87),
        bodySmall: TextStyle(color: Colors.black54),
      ),
      popupMenuTheme: const PopupMenuThemeData(color: Colors.white),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Color(0xFF8E8E93)),
      ),
    );
  }

  static ThemeData dark() {
    const surface = Color(0xFF26221A);
    final scheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: Brightness.dark,
      surface: surface,
      onSurface: Colors.white,
      onSurfaceVariant: const Color(0xFFB8B0A6),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: const Color(0xFF1B1811),
      cardColor: surface,
      dividerColor: const Color(0xFF3A342C),
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white70),
        bodySmall: TextStyle(color: Colors.white60),
      ),
      popupMenuTheme: const PopupMenuThemeData(color: surface),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Color(0xFF8E8E93)),
      ),
    );
  }

  static Color pageBackground(
    BuildContext context, {
    Color light = const Color(0xFFF0EBE0),
  }) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF1B1811)
        : light;
  }

  static Color tintedCard(BuildContext context, Color lightTint) {
    if (Theme.of(context).brightness == Brightness.light) return lightTint;
    return Color.alphaBlend(
      lightTint.withValues(alpha: 0.22),
      const Color(0xFF26221A),
    );
  }

  static Color tintedIconBg(BuildContext context, Color lightTint) {
    if (Theme.of(context).brightness == Brightness.light) return lightTint;
    return Color.alphaBlend(
      lightTint.withValues(alpha: 0.35),
      const Color(0xFF1B1811),
    );
  }

  /// Fondo de las tarjetas de categoría en Home (un poco más oscuro que el resto).
  static Color categoryCardBackground(BuildContext context, Color lightTint) {
    if (Theme.of(context).brightness == Brightness.light) return lightTint;
    return Color.alphaBlend(
      lightTint.withValues(alpha: 0.08),
      const Color(0xFF12100C),
    );
  }

  static Color categoryIconBackground(BuildContext context, Color lightTint) {
    if (Theme.of(context).brightness == Brightness.light) return lightTint;
    return Color.alphaBlend(
      lightTint.withValues(alpha: 0.14),
      const Color(0xFF12100C),
    );
  }

  static Color menuPanelBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF26221A)
        : const Color(0xFFF5F0E8);
  }

  static Color chipBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF352E25)
        : const Color(0xFFF2F2F7);
  }

  static double shadowAlpha(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? 0.28 : 0.06;
  }
}

extension AppThemeContext on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  Color get appSurface => Theme.of(this).colorScheme.surface;
  Color get appOnSurface => Theme.of(this).colorScheme.onSurface;
  Color get appOnSurfaceVariant => Theme.of(this).colorScheme.onSurfaceVariant;
}
