import 'package:flutter/material.dart';
import 'package:prueba/screens/pag_inicio_categ.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
final ValueNotifier<String> languageNotifier = ValueNotifier('en');

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

class T {
  static final Map<String, Map<String, String>> _data = {
    'en': {
      'settings': 'Settings',
      'theme': 'Theme',
      'language': 'Language',
      'light': 'Light',
      'dark': 'Dark',
      'poi': 'Points of Interest',
      'poi_subtitle': 'Discover historic landmarks and monuments across Lleida',
      'cathedrals': 'Cathedrals & Churches',
      'cathedrals_subtitle':
          'Explore sacred architecture and religious heritage',
      'museums': 'Museums',
      'museums_subtitle': 'Visit cultural institutions and exhibition spaces',
      'events': 'Historical Events',
      'events_subtitle': 'Significant moments in Lleida history',
      'categories': 'Categories',
      'search': 'Search locations...',
      'show_all': 'Show all',
      'send_lg': 'SEND TO LG',
      'details': 'Open details',
      'available': 'locations available',
      'events_available': 'events available',
      'history_details': 'History details',
      'search_events': 'Search events...',
      'help': 'Help',
      'about': 'About',
      'connect': 'Connect',
      'tools': 'Tools',
      'home': 'Home',
      'no_results_found': 'No results found',
    },
    'es': {
      'settings': 'Ajustes',
      'theme': 'Tema',
      'language': 'Idioma',
      'light': 'Claro',
      'dark': 'Oscuro',
      'poi': 'Puntos de Interés',
      'poi_subtitle': 'Descubre monumentos y lugares históricos en Lleida',
      'cathedrals': 'Catedrales e Iglesias',
      'cathedrals_subtitle':
          'Explora la arquitectura sagrada y el patrimonio religioso',
      'museums': 'Museos',
      'museums_subtitle':
          'Visita instituciones culturales y espacios de exposición',
      'events': 'Eventos Históricos',
      'events_subtitle': 'Momentos significativos de la historia de Lleida',
      'categories': 'Categorías',
      'search': 'Buscar ubicaciones...',
      'show_all': 'Mostrar todo',
      'send_lg': 'ENVIAR A LG',
      'details': 'Ver detalles',
      'available': 'ubicaciones disponibles',
      'events_available': 'eventos disponibles',
      'history_details': 'Detalles históricos',
      'search_events': 'Buscar eventos...',
      'help': 'Ayuda',
      'about': 'Acerca de',
      'connect': 'Conectar',
      'tools': 'Herramientas',
      'home': 'Inicio',
      'no_results_found': 'No se encontraron resultados',
    },
    'ca': {
      'settings': 'Ajustos',
      'theme': 'Tema',
      'language': 'Idioma',
      'light': 'Clar',
      'dark': 'Fosc',
      'poi': 'Punts d\'Interès',
      'poi_subtitle': 'Descobreix monuments i llocs històrics a Lleida',
      'cathedrals': 'Catedrals i Esglésies',
      'cathedrals_subtitle':
          'Explora l\'arquitectura sagrada i el patrimoni religiós',
      'museums': 'Museus',
      'museums_subtitle': 'Visita institucions culturals i espais d\'exposició',
      'events': 'Esdeveniments Històrics',
      'events_subtitle': 'Moments significatius de la història de Lleida',
      'categories': 'Categories',
      'search': 'Cercar ubicacions...',
      'show_all': 'Mostrar-ho tot',
      'send_lg': 'ENVIAR A LG',
      'details': 'Veure detalls',
      'available': 'ubicacions disponibles',
      'events_available': 'esdeveniments disponibles',
      'history_details': 'Detalls històrics',
      'search_events': 'Cercar esdeveniments...',
      'help': 'Ajuda',
      'about': 'Quant a',
      'connect': 'Connectar',
      'tools': 'Eines',
      'home': 'Inici',
      'no_results_found': 'No s\'han trobat resultats',
    },
    'tr': {
      'settings': 'Ayarlar',
      'theme': 'Tema',
      'language': 'Dil',
      'light': 'Aydınlık',
      'dark': 'Karanlık',
      'poi': 'İlgi Çekici Yerler',
      'poi_subtitle': 'Lleida\'daki tarihi yapıları yand anıtları keşfedin',
      'cathedrals': 'Katedraller ve Kiliseler',
      'cathedrals_subtitle': 'Kutsal mimariyi ve dini mirası keşfedin',
      'museums': 'Müzeler',
      'museums_subtitle': 'Kültürel kurumları ve sergi alanlarını ziyaret edin',
      'events': 'Tarihi Olaylar',
      'events_subtitle': 'Lleida tarihindeki önemli anlar',
      'categories': 'Categoriler',
      'search': 'Konum ara...',
      'show_all': 'Hepsini göster',
      'send_lg': 'LG\'YE GÖNDER',
      'details': 'Detayları aç',
      'available': 'konum mevcut',
      'events_available': 'etkinlik mevcut',
      'history_details': 'Tarih detayları',
      'search_events': 'Etkinlik ara...',
      'help': 'Yardım',
      'about': 'Hakkında',
      'connect': 'Bağlan',
      'tools': 'Araçlar',
      'home': 'Ana Sayfa',
      'no_results_found': 'Sonuç bulunamadı',
    },
  };

  static String s(String key) {
    return _data[languageNotifier.value]?[key] ?? _data['en']![key] ?? key;
  }
}
