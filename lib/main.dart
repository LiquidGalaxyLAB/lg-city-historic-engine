import 'package:flutter/material.dart';
import 'package:prueba/screens/pag_acerca_de.dart';
import 'package:prueba/screens/pag_ayuda.dart';
import 'package:prueba/screens/pag_cat.ig.dart';
import 'package:prueba/screens/pag_conectar.dart';
import 'package:prueba/screens/pag_hechos_h.dart';
import 'package:prueba/screens/pag_inicio_categ.dart';
import 'package:prueba/screens/pag_museos.dart';
import 'package:prueba/screens/pag_tools.dart';
import 'package:prueba/screens/pag_ubi_interes.dart';
import 'package:prueba/widgets/m_superior.dart';
import '../screens/pag_principal.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, mode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: mode,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorSchemeSeed: const Color(0xFF8B7355),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF1B1811), // Marrón muy oscuro
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF8B7355),
              brightness: Brightness.dark,
              surface: const Color(0xFF26221A), // Superficie marrón oscuro
              onSurface: Colors.white,
            ),
          ),
          home: const PagCategorias(),
        );
      },
    );
  }
}