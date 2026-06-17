import 'package:flutter/material.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/m_superior.dart';
import '../main.dart';
import '../models/poi_model.dart';
import 'pag_lanza_lg.dart';

class PagCatedralesIglesias extends StatefulWidget {
  const PagCatedralesIglesias({super.key});

  @override
  State<PagCatedralesIglesias> createState() => _PagCatedralesIglesiasState();
}

class _PagCatedralesIglesiasState extends State<PagCatedralesIglesias> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final Map<String, List<POI>> _data = {
    'Cathedrals': [
      POI(
        name: 'Seu Vella Cathedral',
        location: '41.6176° N, 0.6267° E',
        image: 'assets/images_churches_cathedrals/img.png',
        lat: 41.6176,
        lng: 0.6267,
        range: 1000,
      ),
      POI(
        name: 'New Cathedral',
        location: '41.6130° N, 0.6232° E',
        image: 'assets/images_churches_cathedrals/catedral.jpg',
        lat: 41.612959,
        lng: 0.623249,
        range: 276,
        heading: -5.0,
        tilt: 51.0,
      ),
    ],
    'Churches': [
      POI(
        name: 'Iglesia de Sant Llorenç',
        location: '41.6144° N, 0.6219° E',
        image: 'assets/images_churches_cathedrals/Iglesia de Sant Llorenç.jpg',
        lat: 41.614377,
        lng: 0.621855,
        range: 240,
        heading: 0.0,
        tilt: 46.0,
      ),
      POI(
        name: 'Iglesia de San Juan',
        location: '41.6166° N, 0.6278° E',
        image: 'assets/images_churches_cathedrals/Iglesia de San Juan.jpg',
        lat: 41.616598,
        lng: 0.627847,
        range: 194,
        heading: 28.0,
        tilt: 47.0,
      ),
      POI(
        name: 'Sant Pere',
        location: '41.6144° N, 0.6261° E',
        image: 'assets/images_churches_cathedrals/Sant_pere.jpg',
        lat: 41.614393,
        lng: 0.626055,
        range: 205,
        heading: -107.0,
        tilt: 48.0,
      ),
      POI(
        name: 'Acadèmia Mariana',
        location: '41.6108° N, 0.6191° E',
        image: 'assets/images_churches_cathedrals/academia_mariana.jpg',
        lat: 41.610831,
        lng: 0.619077,
        range: 339,
        heading: 120.0,
        tilt: 38.0,
      ),
      POI(
        name: 'Capella de la Sang',
        location: '41.6118° N, 0.6210° E',
        image: 'assets/images_churches_cathedrals/Capella_sang.png',
        lat: 41.611802,
        lng: 0.621009,
        range: 280,
        heading: 0.0,
        tilt: 42.0,
      ),
      POI(
        name: 'Convent del Roser',
        location: '41.6140° N, 0.6242° E',
        image: 'assets/images_churches_cathedrals/Convent del Roser.jpg',
        lat: 41.614047,
        lng: 0.624225,
        range: 299,
        heading: 3.0,
        tilt: 36.0,
      ),
      POI(
        name: 'Ermita de Granyena',
        location: '41.6419° N, 0.6625° E',
        image: 'assets/images_churches_cathedrals/Ermita de Granyena.jpg',
        lat: 41.641936,
        lng: 0.662474,
        range: 192,
        heading: 52.0,
        tilt: 63.0,
      ),
      POI(
        name: 'Capella de Sant Jaume',
        location: '41.6136° N, 0.6247° E',
        image: 'assets/images_churches_cathedrals/Capella de Sant Jaume.jpg',
        lat: 41.613570,
        lng: 0.624676,
        range: 262,
        heading: -1.0,
        tilt: 34.0,
      ),
      POI(
        name: 'Iglesia antigua de Sant Martí',
        location: '41.6085° N, 0.6147° E',
        image:
            'assets/images_churches_cathedrals/Iglesia antigua de Sant Martí.jpg',
        lat: 41.608475,
        lng: 0.614723,
        range: 190,
        heading: 0.0,
        tilt: 43.0,
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
                            'assets/images_churches_cathedrals/catedral.jpg'),
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
                          Colors.black.withOpacity(0.4),
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
                                currentTitle: T.s('cathedrals')),
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
                          T.s('cathedrals').toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                            fontFamily: 'serif',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          T.s('cathedrals_subtitle'),
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
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
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
        List<String> categories = const ['All', 'Cathedrals', 'Churches'];
        return categories
            .map(
              (cat) => PopupMenuItem<String>(
                value: cat,
                child: Text(
                  cat == 'All' ? T.s('show_all') : cat,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: _selectedCategory == cat
                        ? FontWeight.w700
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
                fontWeight: FontWeight.w800,
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
            color: Colors.black.withOpacity(0.04),
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
                            color: Colors.grey,
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
                          color: const Color(0xFFF2F2F7).withOpacity(0.5),
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
                                letterSpacing: 0.5,
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
