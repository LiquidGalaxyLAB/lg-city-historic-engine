import 'package:flutter/material.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/m_superior.dart';
import '../main.dart';
import '../models/poi_model.dart';
import 'pag_lanza_lg.dart';

class PagHechosHistoricos extends StatefulWidget {
  const PagHechosHistoricos({super.key});

  @override
  State<PagHechosHistoricos> createState() => _PagHechosHistoricosState();
}

class _PagHechosHistoricosState extends State<PagHechosHistoricos> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final Map<String, List<POI>> _data = {
    'Antigüedad': [
      POI(
        name: 'Revolta d\'Indíbil i Mandoni',
        location: '41.6147° N, 0.6268° E',
        image: 'assets/images_historical_events/Revolta d\'Indíbil i Mandoni.jpg',
        lat: 41.6147, lng: 0.6268, range: 1500, tilt: 45,
        descriptions: {
          'es': 'Indíbil y Mandoni, líderes íberos, se rebelaron contra Roma al comprender que Escipión no traería la independencia. En el 205 a.C. formaron una coalición para expulsar a los invasores.',
          'en': 'Indibilis and Mandonius, Iberian leaders, rebelled against Rome. In 205 BC, they formed a coalition to expel the invaders.',
          'ca': 'Indíbil i Mandoni, líders ibers, es van rebel·lar contra Roma en comprendre que Escipió no portaria la independència. L\'any 205 aC, van formar una coalició per expulsar els invasors.',
          'tr': 'İber liderleri Indibilis ve Mandonius Roma\'ya isyan ettiler. MÖ 205\'te işgalcileri kovmak için bir koalisyon kurdular.'
        },
      ),
      POI(
        name: 'Batalla de Ilerda 49 aC',
        location: '41.6147° N, 0.6268° E',
        image: 'assets/images_historical_events/Batalla de Ilerda 49 aC.png',
        lat: 41.6147, lng: 0.6268, range: 2000, tilt: 30,
        descriptions: {
          'es': 'Julio César derrotó a los generales de Pompeyo en los alrededores de Lérida durante la Segunda Guerra Civil romana.',
          'en': 'Julius Caesar defeated Pompey\'s generals around Ilerda during the Roman Civil War.',
          'ca': 'Juli Cèsar va derrotar els generals de Pompeu als voltants de Lleida durant la Segona Guerra Civil romana.',
          'tr': 'Julius Caesar, Roma İç Savaşı sırasında Ilerda çevresinde Pompey\'in generallerini yendi.'
        },
      ),
    ],
    'Edad Media Temprana': [
      POI(
        name: 'Invasió musulmana',
        location: '41.6147° N, 0.6268° E',
        image: 'assets/images_historical_events/Invasio musulmana.jpg',
        lat: 41.6180, lng: 0.6258, range: 1000,
        descriptions: {
          'es': 'Ocupación de la ciudad por tropas árabes y bereberes entre 716 y 719. Se convirtió en una fortaleza estratégica llamada Lārida.',
          'en': 'Occupation of the city by Arab and Berber troops between 716 and 719. It became a strategic fortress called Lārida.',
          'ca': 'Ocupació de la ciutat per tropes àrabs i berbers entre 716 i 719. Es va transformar en una fortalesa estratègica anomenada Lārida.',
          'tr': 'Şehrin 716-719 yılları arasında Arap ve Berberi birlikleri tarafından işgali. Lārida adlı stratejik bir kale haline geldi.'
        },
      ),
      POI(
        name: 'Setge de lleida (800)',
        location: '41.6147° N, 0.6268° E',
        image: 'assets/images_historical_events/Setge de lleida (800).png',
        lat: 41.6147, lng: 0.6268, range: 1500,
        descriptions: {
          'es': 'Las tropas carolingias de Luis el Piadoso sitiaron Lérida para expandir la Marca Hispánica.',
          'en': 'Carolingian troops of Louis the Pious besieged Ilerda to expand the Spanish March.',
          'ca': 'Les tropes carolíngies de Lluís el Pietós van assetjar Lleida amb l\'objectiu d\'expandir la Marca Hispànica.',
          'tr': 'Dindar Louis\'in Karolenj birlikleri, İspanyol Sınırı\'nı genişletmek için Ilerda\'yı kuşattı.'
        },
      ),
    ],
    'Reconquista': [
      POI(
        name: 'Reonquista Cristiana 1149',
        location: '41.6147° N, 0.6268° E',
        image: 'assets/images_historical_events/Reonquista Cristiana1149.jpg',
        lat: 41.6176, lng: 0.6267, range: 800,
        descriptions: {
          'es': 'Ramón Berenguer IV y Ermengol VI conquistaron la ciudad el 24 de octubre de 1149.',
          'en': 'Ramon Berenguer IV and Ermengol VI conquered the city on October 24, 1149.',
          'ca': 'Ramon Berenguer IV i Ermengol VI van conquerir la ciutat el 24 d\'octubre de 1149.',
          'tr': 'Ramon Berenguer IV ve Ermengol VI, 24 Ekim 1149\'da şehri fethetti.'
        },
      ),
    ],
  };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, lang, _) {
        final List<POI> allPois = _selectedCategory == 'All'
            ? _data.values.expand((x) => x).toList()
            : (_data[_selectedCategory] ?? []);

        final List<POI> pois = allPois.where((poi) {
          return poi.name.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();

        return Scaffold(
          backgroundColor: const Color(0xFFF8F7F2),
          body: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/denoche.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.55),
                          Colors.transparent,
                          Colors.black.withOpacity(0.45),
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => MenuFlotante.mostrar(context),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.menu, color: Colors.white, size: 26),
                            ),
                          ),
                          const AppTopBar(onDarkBackground: true, wifiOnly: true),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16, top: 90,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20, bottom: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          T.s('events').toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900,
                            letterSpacing: 1.5, fontFamily: 'serif',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          T.s('events_subtitle'),
                          style: const TextStyle(
                            color: Colors.white70, fontSize: 15, fontWeight: FontWeight.w300,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -28, left: 16, right: 16,
                    child: _buildFilterBar(),
                  ),
                ],
              ),
              const SizedBox(height: 45),
              Expanded(
                child: pois.isEmpty
                    ? Center(child: Text(T.s('no_results_found')))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        physics: const BouncingScrollPhysics(),
                        itemCount: pois.length,
                        itemBuilder: (context, index) => _cardPunto(pois[index]),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterBar() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 20)],
      ),
      child: Row(
        children: [
          const SizedBox(width: 18),
          const Icon(Icons.search_rounded, color: Color(0xFF8E8E93), size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: T.s('search_events'),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardPunto(POI poi) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 16)],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: Image.asset(poi.image, height: 180, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(poi.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PagLanzaLG(poi: poi)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F2F7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      T.s('send_lg'),
                      style: const TextStyle(color: Color(0xFF6B5B45), fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
