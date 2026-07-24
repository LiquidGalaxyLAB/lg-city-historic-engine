import 'package:flutter/material.dart';
import 'app_state.dart';
import 'screens/pag_splash.dart';
import 'services/poi_localization.dart';
import 'theme/app_theme.dart';

export 'app_state.dart';
export 'i18n/translations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppState();
  await PoiLocalization.instance.init();
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
              theme: AppTheme.light(),
              darkTheme: AppTheme.dark(),
              home: const SplashPage(),
            );
          },
        );
      },
    );
  }
}
