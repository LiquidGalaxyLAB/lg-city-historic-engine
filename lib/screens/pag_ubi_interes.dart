import 'package:flutter/material.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/m_superior.dart';

class PagUbicInteres extends StatelessWidget {
  const PagUbicInteres({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E0D6),
      body: Stack(
        children: [
          SizedBox(
            height: 220,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset('assets/images/Castillo_L.jpg', fit: BoxFit.cover),
                Container(color: Colors.black.withOpacity(0.3)),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => MenuFlotante.mostrar(context),
                          child: const Icon(Icons.menu, color: Colors.white, size: 26),
                        ),
                        const AppTopBar(onDarkBackground: true, wifiOnly: true),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 20, bottom: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                  ),
                ),
                const Positioned(
                  left: 50, bottom: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Points of interest', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500)),
                      SizedBox(height: 5),
                      Text('Historic landmarks and monuments', style: TextStyle(color: Colors.white70, fontSize: 14)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 180),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: 21,
              itemBuilder: (context, index) => _cardPunto(index + 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardPunto(int numero) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text('Point$numero', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 8),
            Row(children: const [
              Icon(Icons.public, size: 16, color: Colors.grey),
              SizedBox(width: 6),
              Expanded(child: Text('41.6141°N, 0.6258°E  Explore in Google Earth', style: TextStyle(fontSize: 12, color: Colors.grey))),
              Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
            ]),
          ],
        ),
      ),
    );
  }
}
