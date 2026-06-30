import 'package:flutter/material.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/m_superior.dart';
import '../main.dart';
import '../models/poi_model.dart';
import 'pag_lanza_lg.dart';

class PagUbicInteres extends StatefulWidget {
  const PagUbicInteres({super.key});

  @override
  State<PagUbicInteres> createState() => _PagUbicInteresState();
}

class _PagUbicInteresState extends State<PagUbicInteres> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final Map<String, List<POI>> _data = {
    'SCIENCE / TECHNOLOGY': [
      POI(
        name: 'Parc Científic',
        location: '41.6051°N, 0.6071°E',
        image: 'assets/images_points_of_interest/parc_cientific.jpg',
        lat: 41.605135,
        lng: 0.607070,
        range: 434,
        heading: -9.0,
        tilt: 51.0,
      ),
    ],
    'SPORTS': [
      POI(
        name: 'Sícoris Club',
        location: '41.6065°N, 0.6403°E',
        image: 'assets/images_points_of_interest/sicoris_club.jpg',
        lat: 41.606516,
        lng: 0.640333,
        range: 111,
        heading: 19.0,
        tilt: 47.0,
      ),
      POI(
        name: 'Camp d\'Esports',
        location: '41.6231°N, 0.6138°E',
        image: 'assets/images_points_of_interest/camp_sport.jpg',
        lat: 41.6231,
        lng: 0.6138,
        range: 1000,
      ),
    ],
    'HISTORY / HERITAGE': [
      POI(
        name: 'Castell Templer de Gardeny',
        location: '41.6084°N, 0.6148°E',
        image:
            'assets/images_points_of_interest/Castell Templer de Gardeny.jpg',
        lat: 41.608434,
        lng: 0.614781,
        range: 191,
        heading: -3.0,
        tilt: 62.0,
      ),
      POI(
        name: 'Statue of Indíbil and Mandoni',
        location: '41.6150°N, 0.6273°E',
        image:
            'assets/images_points_of_interest/Statue of Indíbil and Mandoni.jpg',
        lat: 41.614953,
        lng: 0.627290,
        range: 168,
        heading: -56.0,
        tilt: 52.0,
      ),
      POI(
        name: 'Old Hospital of Santa Maria',
        location: '41.6126°N, 0.6238°E',
        image:
            'assets/images_points_of_interest/Old Hospital of Santa Maria.jpg',
        lat: 41.612631,
        lng: 0.623788,
        range: 258,
        heading: 14.0,
        tilt: 50.0,
      ),
      POI(
        name: 'La Paeria',
        location: '41.6146°N, 0.6269°E',
        image: 'assets/images_points_of_interest/La Paeria.jpg',
        lat: 41.614631,
        lng: 0.626850,
        range: 279,
        heading: -51.0,
        tilt: 55.0,
      ),
      POI(
        name: 'Governor’s Fountain',
        location: '41.6173°N, 0.6289°E',
        image: 'assets/images_points_of_interest/Governor’s Fountain.jpg',
        lat: 41.617291,
        lng: 0.628925,
        range: 167,
        heading: -48.0,
        tilt: 57.0,
      ),
      POI(
        name: 'Hospital Fountain',
        location: '41.6126°N, 0.6240°E',
        image: 'assets/images_points_of_interest/Hospital Fountain.jpg',
        lat: 41.612600,
        lng: 0.623997,
        range: 272,
        heading: 38.0,
        tilt: 42.0,
      ),
      POI(
        name: 'La Mitjana (natural heritage)',
        location: '41.6289°N, 0.6435°E',
        image:
            'assets/images_points_of_interest/La Mitjana (natural heritage).jpg',
        lat: 41.628880,
        lng: 0.643496,
        range: 513,
        heading: 49.0,
        tilt: 44.0,
      ),
      POI(
        name: 'General’s Pillar',
        location: '41.6154°N, 0.6273°E',
        image: 'assets/images_points_of_interest/General’s Pillar.png',
        lat: 41.615434,
        lng: 0.627330,
        range: 262,
        heading: -102.0,
        tilt: 43.0,
      ),
      POI(
        name: 'La Suda of Lleida',
        location: '41.6181°N, 0.6272°E',
        image: 'assets/images_points_of_interest/La_Seu.jpg',
        lat: 41.6181,
        lng: 0.6272,
        range: 1000,
      ),
      POI(
        name: 'Sant Joan Square',
        location: '41.6157°N, 0.6273°E',
        image: 'assets/images_points_of_interest/Sant Joan Square.png',
        lat: 41.615692,
        lng: 0.627325,
        range: 431,
        heading: 78.0,
        tilt: 38.0,
      ),
      POI(
        name: 'Sant Anastasi Mill',
        location: '41.6054°N, 0.6404°E',
        image: 'assets/images_points_of_interest/Sant Anastasi Mill.jpg',
        lat: 41.605431,
        lng: 0.640435,
        range: 155,
        heading: 0.0,
        tilt: 53.0,
      ),
      POI(
        name: 'La Cuirassa',
        location: '41.6142°N, 0.6249°E',
        image: 'assets/images_points_of_interest/La Cuirassa.jpg',
        lat: 41.614227,
        lng: 0.624879,
        range: 294,
        heading: 158.0,
        tilt: 28.0,
      ),
      POI(
        name: 'Tanneries',
        location: '41.6172°N, 0.6295°E',
        image: 'assets/images_points_of_interest/Tanneries.jpg',
        lat: 41.617193,
        lng: 0.629525,
        range: 180,
        heading: -20.0,
        tilt: 37.0,
      ),
    ],
    'URBAN / CITY LANDMARKS': [
      POI(
        name: 'La Llotja',
        location: '41.6193°N, 0.6383°E',
        image: 'assets/images_points_of_interest/La Llotja.jpg',
        lat: 41.619262,
        lng: 0.638298,
        range: 368,
        heading: -25.0,
        tilt: 56.0,
      ),
      POI(
        name: 'Europa Square',
        location: '41.6257°N, 0.6226°E',
        image: 'assets/images_points_of_interest/Europa Square.jpeg',
        lat: 41.625674,
        lng: 0.622631,
        range: 611,
        heading: -136.0,
        tilt: 34.0,
      ),
      POI(
        name: 'Lleida Courthouse',
        location: '41.6170°N, 0.6279°E',
        image: 'assets/images_points_of_interest/Lleida Courthouse.jpg',
        lat: 41.617003,
        lng: 0.627903,
        range: 564,
        heading: -42.0,
        tilt: 46.0,
      ),
      POI(
        name: 'Lleida–Pirineus Train Station',
        location: '41.6204°N, 0.6332°E',
        image:
            'assets/images_points_of_interest/Lleida–Pirineus Train Station.jpg',
        lat: 41.620362,
        lng: 0.633234,
        range: 420,
        heading: 42.0,
        tilt: 44.0,
      ),
      POI(
        name: 'Camps Elisis Park',
        location: '41.6140°N, 0.6324°E',
        image: 'assets/images_points_of_interest/Camps Elisis Park lleida.jpg',
        lat: 41.613950,
        lng: 0.632387,
        range: 282,
        heading: 1.0,
        tilt: 46.0,
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
                        image: AssetImage(
                            'assets/images_points_of_interest/La_Seu.jpg'),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => MenuFlotante.mostrar(context,
                                menuKey: 'poi'),
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
                          color: Colors.black.withOpacity(0.2),
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
                          T.s('poi').toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.8,
                            fontFamily: 'serif',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          T.s('poi_subtitle'),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
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
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white24),
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
                                color: Colors.grey[600],
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
                            _cardPunto(pois[index]),
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 18),
          const Icon(Icons.search_rounded, color: Color(0xFF8E8E93), size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: T.s('search'),
                hintStyle: const TextStyle(
                  color: Color(0xFF8E8E93),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.2,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(fontSize: 16, color: Color(0xFF1C1C1E)),
            ),
          ),
          if (_searchQuery.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                setState(() {
                  _searchQuery = '';
                });
              },
              child: const Icon(Icons.close_rounded,
                  color: Color(0xFF8E8E93), size: 20),
            ),
          const SizedBox(width: 10),
          _buildCategoryDropdown(),
          const SizedBox(width: 8),
        ],
      ),
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
                        ? FontWeight.w800
                        : FontWeight.w500,
                    color: const Color(0xFF1C1C1E),
                  ),
                ),
              ),
            )
            .toList();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              T.s('categories'),
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 13,
                color: Color(0xFF1C1C1E),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down_rounded,
                color: Color(0xFF1C1C1E), size: 18),
          ],
        ),
      ),
    );
  }

  Widget _cardPunto(POI poi) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: Image.asset(
              poi.image,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 180,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported,
                      size: 50, color: Colors.grey),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  poi.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'serif',
                    color: Color(0xFF1C1C1E),
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(color: Color(0xFFF2F2F7), thickness: 1.5),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.explore_outlined,
                            size: 16, color: Color(0xFF8E8E93)),
                        const SizedBox(width: 6),
                        Text(
                          T.s('details'),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF8E8E93),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => PagLanzaLG(poi: poi)),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F2F7).withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Text(
                              T.s('send_lg'),
                              style: const TextStyle(
                                color: Color(0xFF6B5B45),
                                fontWeight: FontWeight.w900,
                                fontSize: 13,
                                letterSpacing: 0.6,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_rounded,
                                size: 16, color: Color(0xFF6B5B45)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
