import 'package:flutter/material.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/m_superior.dart';
import '../main.dart';
import '../models/poi_model.dart'; // Usa el modelo global
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
        epoca: 'Edad Media',
        description: 'La catedral antigua de Lleida es el monumento más emblemático de la ciudad.',
      ),
      POI(
        name: 'New Cathedral',
        location: '41.6130° N, 0.6232° E',
        image: 'assets/images_churches_cathedrals/catedral.jpg',
        lat: 41.6129,
        lng: 0.6232,
        range: 400,
        epoca: 'Edad Moderna',
        description: 'Construida en estilo barroco entre 1761 y 1781.',
      ),
    ],
    'Churches': [
      POI(
        name: 'Iglesia de Sant Llorenç',
        location: '41.6144° N, 0.6219° E',
        image: 'assets/images_churches_cathedrals/Iglesia de Sant Llorenç.jpg',
        lat: 41.6144,
        lng: 0.6219,
        epoca: 'Edad Media',
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
                        image: AssetImage('assets/images_churches_cathedrals/catedral.jpg'),
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
                          Colors.black.withValues(alpha: 0.5),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.4),
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
                            onTap: () => MenuFlotante.mostrar(context, currentTitle: T.s('cathedrals')),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
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
                    left: 16,
                    top: 90,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
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
                          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 1.5, fontFamily: 'serif'),
                        ),
                        const SizedBox(height: 4),
                        Text(T.s('cathedrals_subtitle'), style: const TextStyle(color: Colors.white70, fontSize: 15, fontWeight: FontWeight.w300, letterSpacing: 0.5)),
                      ],
                    ),
                  ),
                  Positioned(bottom: -28, left: 16, right: 16, child: _buildFilterBar()),
                ],
              ),
              const SizedBox(height: 45),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 15, offset: const Offset(0, 8))],
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
              decoration: InputDecoration(hintText: T.s('search'), border: InputBorder.none),
            ),
          ),
          _buildCategoryDropdown(),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return PopupMenuButton<String>(
      onSelected: (String value) => setState(() => _selectedCategory = value),
      itemBuilder: (context) => ['All', 'Cathedrals', 'Churches'].map((cat) => PopupMenuItem(value: cat, child: Text(cat == 'All' ? T.s('show_all') : cat))).toList(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(color: const Color(0xFFF2F2F7), borderRadius: BorderRadius.circular(12)),
        child: Row(children: [Text(T.s('categories')), const Icon(Icons.keyboard_arrow_down)]),
      ),
    );
  }

  Widget _cardPunto(POI poi) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 16, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                Expanded(child: Text(poi.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, fontFamily: 'serif'))),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PagLanzaLG(poi: poi))),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(color: const Color(0xFFF2F2F7), borderRadius: BorderRadius.circular(12)),
                    child: Text(T.s('send_lg'), style: const TextStyle(color: Color(0xFF6B5B45), fontWeight: FontWeight.w900)),
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
