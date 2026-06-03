import 'package:flutter/material.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/m_superior.dart';
import '../main.dart';

class POI {
  final String name;
  final String location;
  final String image;
  POI({required this.name, required this.location, required this.image});
}

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
        location: '41.6094°N, 0.6212°E',
        image: 'assets/images_points_of_interest/parc_cientific.jpg',
      ),
    ],
    'SPORTS': [
      POI(
        name: 'Sícoris Club',
        location: '41.6095°N, 0.6315°E',
        image: 'assets/images_points_of_interest/sicoris_club.jpg',
      ),
      POI(
        name: 'Camp d\'Esports',
        location: '41.6231°N, 0.6138°E',
        image: 'assets/images_points_of_interest/camp_sport.jpg',
      ),
    ],
    'HISTORY / HERITAGE': [
      POI(
        name: 'Castell Templer de Gardeny',
        location: '41.6096°N, 0.6136°E',
        image:
            'assets/images_points_of_interest/Castell Templer de Gardeny.jpg',
      ),
      POI(
        name: 'Statue of Indíbil and Mandoni',
        location: '41.6152°N, 0.6256°E',
        image:
            'assets/images_points_of_interest/Statue of Indíbil and Mandoni.jpg',
      ),
      POI(
        name: 'Old Hospital of Santa Maria',
        location: '41.6148°N, 0.6234°E',
        image:
            'assets/images_points_of_interest/Old Hospital of Santa Maria.jpg',
      ),
      POI(
        name: 'La Paeria',
        location: '41.6145°N, 0.6265°E',
        image: 'assets/images_points_of_interest/La Paeria.jpg',
      ),
      POI(
        name: 'Governor’s Fountain',
        location: '41.6150°N, 0.6270°E',
        image: 'assets/images_points_of_interest/Governor’s Fountain.jpg',
      ),
      POI(
        name: 'Hospital Fountain',
        location: '41.6149°N, 0.6235°E',
        image: 'assets/images_points_of_interest/Hospital Fountain.jpg',
      ),
      POI(
        name: 'La Mitjana (natural heritage)',
        location: '41.6280°N, 0.6400°E',
        image:
            'assets/images_points_of_interest/La Mitjana (natural heritage).jpg',
      ),
      POI(
        name: 'General’s Pillar',
        location: '41.6160°N, 0.6280°E',
        image: 'assets/images_points_of_interest/General’s Pillar.png',
      ),
      POI(
        name: 'La Suda of Lleida',
        location: '41.6181°N, 0.6272°E',
        image: 'assets/images_points_of_interest/La_Seu.jpg',
      ),
      POI(
        name: 'Sant Joan Square',
        location: '41.6158°N, 0.6275°E',
        image: 'assets/images_points_of_interest/Sant Joan Square.png',
      ),
      POI(
        name: 'Sant Anastasi Mill',
        location: '41.6100°N, 0.6200°E',
        image: 'assets/images_points_of_interest/Sant Anastasi Mill.png',
      ),
      POI(
        name: 'La Cuirassa',
        location: '41.6165°N, 0.6245°E',
        image: 'assets/images_points_of_interest/La Cuirassa.jpg',
      ),
      POI(
        name: 'Tanneries',
        location: '41.6140°N, 0.6285°E',
        image: 'assets/images_points_of_interest/Tanneries.jpg',
      ),
    ],
    'URBAN / CITY LANDMARKS': [
      POI(
        name: 'La Llotja',
        location: '41.6189°N, 0.6358°E',
        image: 'assets/images_points_of_interest/La Llotja.jpg',
      ),
      POI(
        name: 'Europa Square',
        location: '41.6245°N, 0.6285°E',
        image: 'assets/images_points_of_interest/Europa Square.jpeg',
      ),
      POI(
        name: 'Lleida Courthouse',
        location: '41.6210°N, 0.6220°E',
        image: 'assets/images_points_of_interest/Lleida Courthouse.jpg',
      ),
      POI(
        name: 'Lleida–Pirineus Train Station',
        location: '41.6214°N, 0.6319°E',
        image:
            'assets/images_points_of_interest/Lleida–Pirineus Train Station.png',
      ),
      POI(
        name: 'Camps Elisis Park',
        location: '41.6133°N, 0.6322°E',
        image: 'assets/images_points_of_interest/Camps Elisis Park.jpg',
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
        // Filtrado por categoría
        List<POI> pois = _selectedCategory == 'All'
            ? _data.values.expand((x) => x).toList()
            : (_data[_selectedCategory] ?? []);

        // Filtrado por búsqueda
        if (_searchQuery.isNotEmpty) {
          pois = pois
              .where(
                (poi) =>
                    poi.name.toLowerCase().contains(_searchQuery.toLowerCase()),
              )
              .toList();
        }

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
                          'assets/images_points_of_interest/lleida_arriba.jpg',
                        ),
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
                          Colors.black.withValues(alpha: 0.55),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.45),
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => MenuFlotante.mostrar(
                              context,
                              currentTitle: T.s('poi'),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 26,
                              ),
                            ),
                          ),
                          const AppTopBar(
                            onDarkBackground: true,
                            wifiOnly: true,
                          ),
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
                          color: Colors.black.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 22,
                        ),
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
                            color: Colors.white.withValues(alpha: 0.8),
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
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                            size: 16,
                          ),
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
                    child: _buildFilterBar(),
                  ),
                ],
              ),

              const SizedBox(height: 45),

              Expanded(
                child: pois.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off_rounded,
                              size: 80,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              T.s('no_results_found') ?? 'No results found',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (_searchQuery.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  '"$_searchQuery" does not exist',
                                  style: TextStyle(color: Colors.grey.shade400),
                                ),
                              ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 0,
                        ),
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
            color: Colors.black.withValues(alpha: 0.06),
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
              ),
              style: const TextStyle(fontSize: 16, color: Color(0xFF1C1C1E)),
            ),
          ),
          if (_searchQuery.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.close, size: 20, color: Color(0xFF8E8E93)),
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _searchQuery = '';
                });
              },
            ),
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
                  cat == 'All' ? T.s('show_all') : cat,
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
              _selectedCategory == 'All'
                  ? T.s('categories')
                  : _selectedCategory,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 13,
                color: Color(0xFF1C1C1E),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Color(0xFF1C1C1E),
              size: 18,
            ),
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
            color: Colors.black.withValues(alpha: 0.03),
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
                        const Icon(
                          Icons.explore_outlined,
                          size: 16,
                          color: Color(0xFF8E8E93),
                        ),
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F2F7).withValues(alpha: 0.6),
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
                          const Icon(
                            Icons.arrow_forward_rounded,
                            size: 16,
                            color: Color(0xFF6B5B45),
                          ),
                        ],
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
