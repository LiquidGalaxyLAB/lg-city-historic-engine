import 'package:flutter/material.dart';
import 'package:prueba/screens/pag_inicio_categ.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_state.dart';

export 'app_state.dart';
export 'i18n/translations.dart';

Future<void> _loadLanguage() async {
  final prefs = await SharedPreferences.getInstance();
  final saved = prefs.getString('app_language');
  if (saved != null && saved.isNotEmpty) {
    languageNotifier.value = saved;
  }
}

void _persistLanguage() {
  SharedPreferences.getInstance().then(
    (prefs) => prefs.setString('app_language', languageNotifier.value),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _loadLanguage();
  languageNotifier.addListener(_persistLanguage);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, mode, __) {
        return ValueListenableBuilder<String>(
          valueListenable: languageNotifier,
          builder: (_, lang, __) {
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
                scaffoldBackgroundColor: const Color(0xFF1B1811),
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFF8B7355),
                  brightness: Brightness.dark,
                  surface: const Color(0xFF26221A),
                  onSurface: Colors.white,
                ),
              ),
              home: const PagCategorias(),
            );
          },
        );
      },
    );
  }
}
