import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/section_hero_header.dart';
import '../widgets/themed_poi_card.dart';
import '../widgets/m_superior.dart';
import '../main.dart';
import '../models/poi_model.dart';
import '../services/poi_localization.dart';
import 'pag_lanza_lg.dart';

class CathedralsChurchesPage extends StatefulWidget {
  const CathedralsChurchesPage({super.key});

  @override
  State<CathedralsChurchesPage> createState() => _CathedralsChurchesPageState();
}

class _CathedralsChurchesPageState extends State<CathedralsChurchesPage> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final Map<String, List<POI>> _data = {
    'Cathedrals': [
      POI(
        name: 'Seu Vella Cathedral',
        location: '41.6175°N, 0.6269°E',
        image: 'assets/images_points_of_interest/La_Seu.jpg',
        lat: 41.617475,
        lng: 0.626900,
        range: 404,
        heading: -40.0,
        tilt: 62.0,
        era: 'Middle Ages',
        startDate: '1203',
        endDate: '1431',
        description:
            'La Seu Vella is the most iconic monument of Lleida. Built in the Romanesque style with Gothic vaults, it stands on the hill of the Old Cathedral, overlooking Lleida and the Segrià region. The cloister, with views over the city, was built between the 13th and 14th centuries. In the 15th century, the bell tower and the Apostles’ Gate were added. In 1707, due to its strategic position, the building was converted into a military barracks.',
      ),
      POI(
        name: 'New Cathedral',
        location: '41.6129°N, 0.6231°E',
        image: 'assets/images_churches_cathedrals/catedral.jpg',
        lat: 41.612900,
        lng: 0.623125,
        range: 108,
        heading: -5.0,
        tilt: 57.0,
        era: 'Modern Age',
        startDate: '1761',
        endDate: '1781',
        description:
            'Between 1761 and 1781, the construction of the New Cathedral of Lleida took place thanks to contributions from the people of Lleida, King Charles III of Spain, and Bishop Joaquín Sánchez. Baroque in style, with a strong tendency toward French academic classicism, it is located in the heart of the commercial axis, opposite the former Hospital of Santa Maria. The temple houses the image of the Virgin of Montserrat (La Moreneta), patron saint of Catalonia.',
      ),
    ],
    'Churches': [
      POI(
        name: 'Church of Sant Llorenç',
        location: '41.6143°N, 0.6216°E',
        image: 'assets/images_churches_cathedrals/Iglesia de Sant Llorenç.jpg',
        lat: 41.614250,
        lng: 0.621639,
        range: 92,
        heading: -10.0,
        tilt: 61.0,
        era: 'Middle Ages',
        startDate: '1150',
        endDate: '1400',
        description:
            'What was twice the seat of a cathedral is a Romanesque-style construction with Gothic extensions and finishes. Considered the second most important church after the La Seu Vella, it has three naves of equal height and three apses. The building preserves four important Gothic altarpieces, the largest of which is dedicated to Saint Lawrence.',
      ),
      POI(
        name: 'Old Church of San Martí',
        location: '41.6177°N, 0.6220°E',
        image: 'assets/images_churches_cathedrals/Iglesia antigua de Sant Martí.jpg',
        lat: 41.617669,
        lng: 0.622039,
        range: 78,
        heading: 26.0,
        tilt: 57.0,
        era: 'Middle Ages',
        startDate: '1150',
        endDate: '1200',
        description:
            'This church is a Romanesque gem located in the heart of the city. Built in the 12th century, it became the chapel of the Estudi General in 1300. In 1648, during the Reapers\' War, it was converted into a military barracks, and in the 19th century it was used as the municipal prison. In 1893, Bishop Messeguer Costa ordered its restoration.',
      ),
      POI(
        name: 'Church of San Juan',
        location: '41.6164°N, 0.6277°E',
        image: 'assets/images_churches_cathedrals/Iglesia de San Juan.jpg',
        lat: 41.616403,
        lng: 0.627722,
        range: 72,
        heading: 0.0,
        tilt: 59.0,
        era: 'Middle Ages',
        startDate: '1885',
        endDate: '1895',
        description:
            'In one of the most characteristic squares of the city stands the Church of Sant John. This Neo-Gothic building dates from the late 19th century and was designed by Julio de Saracíbar and Celestino Capmany.',
      ),
      POI(
        name: 'Chapel of Sant Jaume',
        location: '41.6135°N, 0.6246°E',
        image: 'assets/images_churches_cathedrals/Capella de Sant Jaume.jpg',
        lat: 41.613458,
        lng: 0.624600,
        range: 63,
        heading: 0.0,
        tilt: 61.0,
        era: 'Middle Ages',
        startDate: '1399',
        endDate: '1399',
        description:
            'This small chapel, originally dedicated to Our Lady of the Snows, was built during the Muslim period in what was then the Christian quarter, and it is currently dedicated to the worship of the Apostle James (Saint James).',
      ),
      POI(
        name: 'Chapel of la Sang',
        location: '41.6119°N, 0.6212°E',
        image: 'assets/images_churches_cathedrals/Capella_sang.png',
        lat: 41.611911,
        lng: 0.621158,
        range: 75,
        heading: -52.0,
        tilt: 58.0,
        era: 'Middle Ages',
        startDate: '1470',
        endDate: '1499',
        description:
            'The Oratory of the Blood of Lleida takes its name from the Congregation of the Most Pure Blood of Our Lord Jesus. The Oratory of the Blood is the chapel from which the Holy Week processional floats depart.',
      ),
      POI(
        name: 'Church of Sant Pere',
        location: '41.6143°N, 0.6261°E',
        image: 'assets/images_churches_cathedrals/Sant_pere.jpg',
        lat: 41.614269,
        lng: 0.626103,
        range: 49,
        heading: -112.0,
        tilt: 55.0,
        era: 'Middle Ages',
        startDate: '1731',
        endDate: '1749',
        description:
            'Located in Saint Francis Square, the Church of Saint Peter of Lleida was founded in 1731. It originally served as the church of the Franciscan Convent (1217).',
      ),
      POI(
        name: 'Hermitage of Granyena',
        location: '41.6419°N, 0.6621°E',
        image: 'assets/images_churches_cathedrals/Ermita de Granyena.jpg',
        lat: 41.641917,
        lng: 0.662147,
        range: 60,
        heading: 124.0,
        tilt: 64.0,
        era: 'Middle Ages',
        startDate: '1300',
        endDate: '1308',
        description:
            'It is a large building with a ground floor and one upper level, topped with a gabled roof. It was originally a mosque. Already mentioned in 1308, it is the site where the Virgin Mary of Granyena, patron saint of Alcoletge, is venerated.',
      ),
      POI(
        name: 'Convent del Roser',
        location: '41.6144°N, 0.6240°E',
        image: 'assets/images_churches_cathedrals/Convent del Roser.jpg',
        lat: 41.614419,
        lng: 0.623989,
        range: 151,
        heading: -24.0,
        tilt: 62.0,
        era: 'Middle Ages',
        startDate: '1669',
        endDate: '1669',
        description:
            'In the Reapers\' War, when Lleida was under French sovereignty in 1642, the Roser was located below the hill of the Seu Vella. In 1669 it was rebuilt in the city centre on Carrer Cavallers.',
      ),
      POI(
        name: 'Academia Mariana',
        location: '41.6109°N, 0.6190°E',
        image: 'assets/images_churches_cathedrals/academia_mariana.jpg',
        lat: 41.610928,
        lng: 0.619022,
        range: 73,
        heading: -40.0,
        tilt: 60.0,
        era: 'Contemporary Age',
        startDate: '1862',
        endDate: '1862',
        description:
            'Since its foundation in 1862, the Academia Mariana has been a true symbol of the city. The Sanctuary of the Patroness of Lleida contains several artistic treasures unique in the world, including 300 square meters of fresco paintings from 1871 depicting the life of the Virgin.',
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
              SectionHeroHeader(
                imageAsset: 'assets/images_churches_cathedrals/catedral.jpg',
                menuTitle: T.s('cathedrals'),
                title: T.s('cathedrals').toUpperCase(),
                subtitle: T.s('cathedrals_subtitle'),
                filterBar: _buildFilterBar(),
                onMenuTap: () =>
                    FloatingMenu.show(context, currentTitle: T.s('cathedrals')),
              ),
              const SizedBox(height: 45),
              Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  itemCount: pois.length,
                  itemBuilder: (context, index) =>
                      _placeCard(pois[index], lang),
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
      categoryMenu: CategoryFilterDropdown(
        selectedCategory: _selectedCategory,
        categories: ['All', ..._data.keys],
        onSelected: (value) => setState(() => _selectedCategory = value),
        labelForCategory: (cat) =>
            cat == 'All' ? T.s('show_all') : T.category(cat),
      ),
    );
  }

  Widget _placeCard(POI poi, String lang) {
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
