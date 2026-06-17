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
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Revolta d\'Indíbil i Mandoni.jpg',
        lat: 41.6191230, lng: 0.6232056, range: 1480.59, heading: -25.26, tilt: 65.45,
      ),
      POI(
        name: 'Batalla de Ilerda 49 aC',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Batalla de Ilerda 49 aC.png',
        lat: 41.6191230, lng: 0.6232056, range: 1480.59, heading: -25.26, tilt: 65.45,
      ),
    ],
    'Edad Media Temprana': [
      POI(
        name: 'Invasió musulmana',
        location: '41.6180° N, 0.6258° E',
        image: 'assets/images_historical_events/Invasio musulmana.jpg',
        lat: 41.6180451, lng: 0.6258326, range: 361.12, heading: 12.41, tilt: 0.0,
      ),
      POI(
        name: 'Setge de Lleida (800)',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Setge de lleida (800).png',
        lat: 41.6191230, lng: 0.6232056, range: 1480.59, heading: -25.26, tilt: 65.45,
      ),
      POI(
        name: 'Setge de Lleida (884)',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Setge de lleida (884).png',
        lat: 41.6191230, lng: 0.6232056, range: 1480.59, heading: -25.26, tilt: 65.45,
      ),
    ],
    'Reconquista / Alta Edad Media': [
      POI(
        name: 'Reconquesta Cristiana 1149',
        location: '41.6090° N, 0.6103° E',
        image: 'assets/images_historical_events/Reonquista Cristiana1149.jpg',
        lat: 41.6089691, lng: 0.6103237, range: 1159.27, heading: -53.72, tilt: 56.84,
      ),
      POI(
        name: 'Unió del regne de Aragó i comtat de Barcelona',
        location: '41.6168° N, 0.6255° E',
        image: 'assets/images_historical_events/Unio del regne de Arago i comtat de barcelona.jpg',
        lat: 41.6167910, lng: 0.6254991, range: 1480.59, heading: -25.26, tilt: 65.45,
      ),
    ],
    'Edad Media / Baja Edad Media': [
      POI(
        name: 'Jura de fidelitat a Jaume I',
        location: '41.6180° N, 0.6258° E',
        image: 'assets/images_historical_events/jura de fidelitat a Jaume I.jpg',
        lat: 41.6180451, lng: 0.6258326, range: 361.12, heading: 12.41, tilt: 0.0,
      ),
      POI(
        name: 'Primera universitat del regne d\'Aragó',
        location: '41.6147° N, 0.6199° E',
        image: 'assets/images_historical_events/Primera universitat del regne d\'arago.jpg',
        lat: 41.6146803, lng: 0.6198760, range: 270.14, heading: -70.55, tilt: 47.35,
      ),
      POI(
        name: 'Setge de Lleida (1413)',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Setge de lleida (1413).jpg',
        lat: 41.6191230, lng: 0.6232056, range: 1480.59, heading: -25.26, tilt: 65.45,
      ),
    ],
    'Edad Moderna': [
      POI(
        name: 'La batalla de Lleida (1642)',
        location: '41.6100° N, 0.6367° E',
        image: 'assets/images_historical_events/La batalla de Lleida (1642).jpg',
        lat: 41.6100091, lng: 0.6367412, range: 2017.02, heading: -53.71, tilt: 56.85,
      ),
      POI(
        name: 'Setge de Lleida (1644)',
        location: '41.6149° N, 0.6204° E',
        image: 'assets/images_historical_events/Setge de lleida (1644).png',
        lat: 41.6149206, lng: 0.6204228, range: 1229.41, heading: -52.03, tilt: 60.58,
      ),
      POI(
        name: 'Setge de Lleida (1646)',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Setge de lleida (1646).jpg',
        lat: 41.6191230, lng: 0.6232056, range: 1480.59, heading: -25.26, tilt: 65.45,
      ),
      POI(
        name: 'Setge de Lleida (1647)',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Setge de lleida (1647).png',
        lat: 41.6191230, lng: 0.6232056, range: 1480.59, heading: -25.26, tilt: 65.45,
      ),
      POI(
        name: 'Setge de Lleida (1707)',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Setge de lleida (1707)png.png',
        lat: 41.6191230, lng: 0.6232056, range: 1480.59, heading: -25.26, tilt: 65.45,
      ),
    ],
    'Edad Contemporánea': [
      POI(
        name: 'Setge de Lleida (1810)',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Setge de lleida (1810).png',
        lat: 41.6191230, lng: 0.6232056, range: 1480.59, heading: -25.26, tilt: 65.45,
      ),
      POI(
        name: 'Batalla de Lleida (1938)',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Batalla de Lleida (1938).jpeg',
        lat: 41.6191230, lng: 0.6232056, range: 1480.59, heading: -25.26, tilt: 65.45,
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
                              currentTitle: T.s('events'),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
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
                          color: Colors.black.withOpacity(0.15),
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
                          T.s('events').toUpperCase(),
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
                          T.s('events_subtitle'),
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
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.history_edu_outlined,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${pois.length} ${T.s('events_available')}',
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
                              color: Colors.grey[300],
                            ),
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
                hintText: T.s('search_events'),
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
              child: const Icon(
                Icons.close_rounded,
                color: Color(0xFF8E8E93),
                size: 20,
              ),
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
                  cat == 'All' ? T.s('show_all') : cat,
                  style: TextStyle(
                    fontSize: 13,
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
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 50,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    poi.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'serif',
                      color: Color(0xFF1C1C1E),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PagLanzaLG(poi: poi),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F2F7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      T.s('send_lg'),
                      style: const TextStyle(
                        color: Color(0xFF6B5B45),
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                        letterSpacing: 0.6,
                      ),
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
