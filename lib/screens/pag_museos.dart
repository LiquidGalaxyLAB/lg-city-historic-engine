import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/themed_poi_card.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/m_superior.dart';
import '../main.dart';
import '../models/poi_model.dart';
import '../services/poi_localization.dart';
import 'pag_lanza_lg.dart';

class MuseumsPage extends StatefulWidget {
  const MuseumsPage({super.key});

  @override
  State<MuseumsPage> createState() => _MuseumsPageState();
}

class _MuseumsPageState extends State<MuseumsPage> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final Map<String, List<POI>> _data = {
    'Art': [
      POI(
        name: 'Museum of Modern and Contemporary Art of Lleida',
        location: '41.6176°N, 0.6297°E',
        image:
            'assets/images_museums/Museu d’Art Modern i Contemporani de Lleida.jpg',
        lat: 41.617625,
        lng: 0.629728,
        range: 64,
        heading: -74.0,
        tilt: 53.0,
        era: 'Contemporary Age',
        startDate: '1914',
        endDate: '1917',
        description:
            'The museum was founded in 1914 through the initiative of painter Jaume Morera and the City Council of Lleida. Its initial goal was to provide the city with a space dedicated to contemporary art of the time. Morera himself donated his personal collection, including works by masters such as Carlos de Haes. After decades of moving between temporary locations, the museum inaugurated its permanent location in 2024 in the former Courthouse on Rambla de Ferran.',
      ),
    ],
    'History/Heritage': [
      POI(
        name: 'Diocesan Museum',
        location: '41.6138°N, 0.6209°E',
        image: 'assets/images_museums/museonoche.jpg',
        lat: 41.613794,
        lng: 0.620883,
        range: 61,
        heading: 91.0,
        tilt: 56.0,
        era: 'Contemporary Age',
        startDate: '1893',
        endDate: '1893',
        description:
            'The Museum of Lleida, formerly known as the Diocesan and Regional Museum of Lleida, is a museum consortium created on August 1, 1997, made up of the Government of Catalonia, the Provincial Council and City Council of Lleida, the Segrià Regional Council, and the Bishopric of Lleida. The museum’s permanent headquarters was inaugurated in November 2007. In the autumn of 2020, the museum and its collection were declared of National Interest.',
      ),
    ],
    'Science/Technology': [
      POI(
        name: 'Water Museum',
        location: '41.6032°N, 0.6357°E',
        image: 'assets/images_museums/Museu de l’Aigua.jpg',
        lat: 41.603211,
        lng: 0.635728,
        range: 101,
        heading: 77.0,
        tilt: 60.0,
        era: 'Contemporary Age',
        startDate: '2004',
        endDate: '2004',
        description:
            'The Water Museum is made up of different spaces distributed throughout the city and the agricultural area of Lleida. Its central site is the “La Canadiense Camp,” followed by the Water Plan Reservoir, the Ice Wells, the Sant Anastasi Mill Mill, the monumental fountains, and the Piñana and Seròs canals. Lleida was founded on the banks of the Ebro River and has developed an extensive network of canals and irrigation channels.',
      ),
    ],
    'Automotive': [
      POI(
        name: 'Automotive Museum',
        location: '41.6133°N, 0.6328°E',
        image: 'assets/images_museums/Museu de l’Automoció.jpg',
        lat: 41.613319,
        lng: 0.632769,
        range: 75,
        heading: 177.0,
        tilt: 64.0,
        era: 'Contemporary Age',
        startDate: '2002',
        endDate: '2002',
        description:
            'The Automotive Museum of Lleida is a municipal museum dedicated to the world of automotive engineering in general, with a specialization in vintage vehicles. Inaugurated in September 2002, the project is linked to the Foundation for Industrial Archaeological Heritage. The museum is structured into five main sections: automobiles, motorcycles, the workshop, engines, and miniatures.',
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
        final List<POI> allPois = (_selectedCategory == 'All'
                ? _data.values.expand((x) => x)
                : (_data[_selectedCategory] ?? []))
            .map(PoiLocalization.instance.enrich)
            .toList();

        final List<POI> pois = allPois
            .where((poi) => poi.matchesSearch(_searchQuery, lang))
            .toList();

        return Scaffold(
          backgroundColor: AppTheme.pageBackground(
            context,
            light: const Color(0xFFF8F7F2),
          ),
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
                        image:
                            AssetImage('assets/images_museums/museonoche.jpg'),
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
                          Colors.black.withOpacity(0.5),
                          Colors.transparent,
                          Colors.black.withOpacity(0.45),
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => FloatingMenu.show(context,
                                currentTitle: T.s('museums')),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.menu,
                                  color: Colors.white, size: 26),
                            ),
                          ),
                          const AppTopBar(
                              onDarkBackground: true, wifiOnly: true),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    top: 90,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.white, size: 22),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          T.s('museums').toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                            fontFamily: 'serif',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          T.s('museums_subtitle'),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 35,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.location_on_outlined,
                              color: Colors.white, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            '${pois.length} ${T.s('available')}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: -28,
                      left: 16,
                      right: 16,
                      child: _buildFilterBar()),
                ],
              ),
              const SizedBox(height: 45),
              Expanded(
                child: pois.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_off_rounded,
                                size: 80, color: Colors.grey[300]),
                            const SizedBox(height: 16),
                            Text(
                              T.s('no_results_found'),
                              style: TextStyle(
                                fontSize: 18,
                                color: context.appOnSurfaceVariant,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 0),
                        physics: const BouncingScrollPhysics(),
                        itemCount: pois.length,
                        itemBuilder: (context, index) =>
                            _cardPunto(pois[index], lang),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterBar() {
    return ThemedListFilterBar(
      searchController: _searchController,
      searchHint: T.s('search'),
      searchQuery: _searchQuery,
      onSearchChanged: (value) => setState(() => _searchQuery = value),
      onClearSearch: () {
        _searchController.clear();
        setState(() => _searchQuery = '');
      },
      categoryMenu: _buildCategoryDropdown(),
    );
  }

  Widget _buildCategoryDropdown() {
    return PopupMenuButton<String>(
      onSelected: (String value) {
        setState(() {
          _selectedCategory = value;
        });
      },
      offset: const Offset(0, 60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 12,
      itemBuilder: (context) {
        List<String> categories = ['All', ..._data.keys];
        return categories
            .map(
              (cat) => PopupMenuItem<String>(
                value: cat,
                child: Text(
                  cat == 'All' ? T.s('show_all') : T.category(cat),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: _selectedCategory == cat
                        ? FontWeight.w700
                        : FontWeight.w500,
                    color: context.appOnSurface,
                  ),
                ),
              ),
            )
            .toList();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.chipBackground(context),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              T.s('categories'),
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 13,
                color: context.appOnSurface,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down_rounded,
                color: context.appOnSurface, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _cardPunto(POI poi, String lang) {
    return ThemedPoiCard(
      imageAsset: poi.image,
      title: poi.getName(lang),
      actionLabel: T.s('send_lg'),
      onSend: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => LaunchLGPage(poi: poi)),
      ),
    );
  }
}
