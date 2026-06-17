import 'package:flutter/material.dart';
import '../models/poi_model.dart';
import '../services/lg_service.dart';
import '../widgets/m_superior.dart';

class PagLanzaLG extends StatefulWidget {
  final POI poi;

  const PagLanzaLG({super.key, required this.poi});

  @override
  State<PagLanzaLG> createState() => _PagLanzaLGState();
}

class _PagLanzaLGState extends State<PagLanzaLG> {
  final LGService _lgService = LGService();
  bool _isOrbiting = false;

  @override
  void initState() {
    super.initState();
    _initLG();
  }

  Future<void> _initLG() async {
    await _sendToLG();
    await _lgService.flyToPOI(widget.poi);
    await _lgService.sendBalloon(widget.poi);
  }

  Future<void> _sendToLG() async {
    final kml = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document>
    <LookAt>
      <longitude>${widget.poi.lng ?? 0.6268}</longitude>
      <latitude>${widget.poi.lat ?? 41.6147}</latitude>
      <range>${widget.poi.range ?? 1000}</range>
      <tilt>${widget.poi.tilt ?? 45}</tilt>
      <heading>${widget.poi.heading ?? 0}</heading>
      <altitudeMode>${widget.poi.altitudeMode ?? 'relativeToGround'}</altitudeMode>
    </LookAt>
  </Document>
</kml>''';
    await _lgService.sendKML(kml);
  }

  void _toggleOrbit() {
    setState(() => _isOrbiting = !_isOrbiting);
    if (_isOrbiting) {
      _lgService.startOrbitPOI(widget.poi);
    } else {
      _lgService.stopOrbit();
    }
  }

  @override
  void dispose() {
    _lgService.stopOrbit();
    _lgService.clearBalloon();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1E9),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => MenuFlotante.mostrar(context,
                        currentTitle: widget.poi.name),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: const Icon(Icons.menu, color: Colors.black87),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD7F5E9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(Icons.wifi, color: Color(0xFF4CAF50)),
                  ),
                ],
              ),
            ),

            // Back Arrow
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back,
                      color: Color(0xFF6B5B45), size: 30),
                  onPressed: () {
                    _lgService.stopOrbit();
                    _lgService.clearBalloon();
                    Navigator.pop(context);
                  },
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Main Card
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      // Image
                      Expanded(
                        flex: 5,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(40)),
                          child: Image.asset(
                            widget.poi.image,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.image_not_supported,
                                  size: 80),
                            ),
                          ),
                        ),
                      ),

                      // Title
                      Padding(
                        padding: const EdgeInsets.only(top: 25, bottom: 10),
                        child: Text(
                          widget.poi.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'serif',
                            color: Color(0xFF1C1C1E),
                          ),
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child:
                            Divider(color: Color(0xFFF2F2F7), thickness: 1.5),
                      ),

                      const Spacer(),

                      // Action Buttons
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 30, left: 20, right: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildActionCard(
                                icon: Icons.volume_up_outlined,
                                label: 'AI Narration',
                                onTap: () {},
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: _buildActionCard(
                                icon: Icons.near_me_outlined,
                                label: 'Orbit',
                                isActive: _isOrbiting,
                                onTap: _toggleOrbit,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    final Color bgColor =
        isActive ? const Color(0xFF4E342E) : const Color(0xFFFBF9F6);
    final Color iconColor = isActive ? Colors.white : const Color(0xFF6B5B45);
    final Color textColor = isActive ? Colors.white : const Color(0xFF1C1C1E);
    final Color circleColor =
        isActive ? const Color(0xFF3E2723) : const Color(0xFFF5F1E9);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
              color: isActive ? Colors.transparent : const Color(0xFFF2F2F7)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
