// ─────────────────────────────────────────────────────────────────────────────
// PEGA ESTOS DOS MÉTODOS AL FINAL DE LA CLASE LGService, justo antes del } final
// ─────────────────────────────────────────────────────────────────────────────

Future<void> sendBalloon(POI poi) async {
  final int slaveNo = _conn.screens == 5 ? 4 : 2;

  // Construye las líneas opcionales de época y fechas
  final String epocaLine = (poi.epoca != null && poi.epoca!.isNotEmpty)
      ? '<p style="font-size:12px;color:#A0856A;margin:0 0 12px 0;text-transform:uppercase;letter-spacing:1px;">${poi.epoca}</p>'
      : '';

  final String fechaLine = (poi.fechaInici != null && poi.fechaInici!.isNotEmpty)
      ? '<p style="font-size:12px;color:#A0856A;margin:0 0 16px 0;">'
      '${poi.fechaInici}'
      '${poi.fechaFi != null && poi.fechaFi != poi.fechaInici ? " – ${poi.fechaFi}" : ""}'
      '</p>'
      : '';

  final String descLine = (poi.description != null && poi.description!.isNotEmpty)
      ? '<p style="font-size:14px;line-height:1.75;color:#E0D8CC;margin:0;">${poi.description}</p>'
      : '';

  final String kml = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document>
    <Placemark>
      <name>${poi.name}</name>
      <description><![CDATA[
        <html>
        <body style="margin:0;padding:0;background:#1C1C1E;font-family:Georgia,serif;color:#F5F1E9;width:100%;height:100%;">
          <div style="padding:28px 28px 24px 28px;">
            <h2 style="font-size:24px;font-weight:400;margin:0 0 10px 0;color:#F5F1E9;line-height:1.3;">
              ${poi.name}
            </h2>
            <div style="width:40px;height:2px;background:#C8A96E;margin-bottom:14px;"></div>
            $epocaLine
            $fechaLine
            $descLine
          </div>
        </body>
        </html>
      ]]></description>
      <Point>
        <coordinates>${poi.lng ?? 0.6268},${poi.lat ?? 41.6147},0</coordinates>
      </Point>
    </Placemark>
  </Document>
</kml>''';

  await _conn.execute(
      "cat <<'KMLEOF' > /var/www/html/kml/slave_$slaveNo.kml\n$kml\nKMLEOF");
}

<<<<<<< HEAD
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
=======
Future<void> clearBalloon() async {
  final int slaveNo = _conn.screens == 5 ? 4 : 2;
  const String blank = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2"><Document></Document></kml>''';
  await _conn.execute(
      "cat <<'KMLEOF' > /var/www/html/kml/slave_$slaveNo.kml\n$blank\nKMLEOF");
}
>>>>>>> parent of fdca477 (17/06/2026)
