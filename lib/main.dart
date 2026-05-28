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
      'poi_subtitle': 'Historic landmarks and monuments',
      'cathedrals': 'Cathedrals & Churches',
      'cathedrals_subtitle': 'Sacred architecture and religious sites',
      'museums': 'Museums',
      'museums_subtitle': 'Cultural institutions and exhibitions',
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
    },
    'es': {
      'settings': 'Ajustes',
      'theme': 'Tema',
      'language': 'Idioma',
      'light': 'Claro',
      'dark': 'Oscuro',
      'poi': 'Puntos de Interés',
      'poi_subtitle': 'Monumentos y lugares históricos',
      'cathedrals': 'Catedrales e Iglesias',
      'cathedrals_subtitle': 'Arquitectura sagrada y sitios religiosos',
      'museums': 'Museos',
      'museums_subtitle': 'Instituciones culturales y exposiciones',
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
    },
    'ca': {
      'settings': 'Ajustos',
      'theme': 'Tema',
      'language': 'Idioma',
      'light': 'Clar',
      'dark': 'Fosc',
      'poi': 'Punts d\'Interès',
      'poi_subtitle': 'Monuments i llocs històrics',
      'cathedrals': 'Catedrals i Esglésies',
      'cathedrals_subtitle': 'Arquitectura sagrada i llocs religiosos',
      'museums': 'Museus',
      'museums_subtitle': 'Institucions culturals i exposicions',
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
    },
    'tr': {
      'settings': 'Ayarlar',
      'theme': 'Tema',
      'language': 'Dil',
      'light': 'Aydınlık',
      'dark': 'Karanlık',
      'poi': 'İlgi Çekici Yerler',
      'poi_subtitle': 'Tarihi yapılar ve anıtlar',
      'cathedrals': 'Katedraller ve Kiliseler',
      'cathedrals_subtitle': 'Kutsal mimari ve dini yerler',
      'museums': 'Müzeler',
      'museums_subtitle': 'Kültürel kurumlar ve sergiler',
      'events': 'Tarihi Olaylar',
      'events_subtitle': 'Lleida tarihindeki önemli anlar',
      'categories': 'Kategoriler',
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
    },
  };

  static String s(String key) {
    return _data[languageNotifier.value]?[key] ?? _data['en']![key] ?? key;
  }
}
