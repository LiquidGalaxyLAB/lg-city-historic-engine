import 'package:flutter/material.dart';

class PagHechosHistoricos extends StatelessWidget {
  const PagHechosHistoricos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E0D6),
      body: Stack(
        children: [

          // 🖼️ HEADER CON IMAGEN
          SizedBox(
            height: 220,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/denoche.jpg', // 👈 tu imagen
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.black.withOpacity(0.3),
                ),

                // 🔝 ICONOS
                Positioned(
                  top: 40,
                  left: 20,
                  child: Column(
                    children: [
                      const Icon(Icons.menu, color: Colors.white),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ],
                  ),
                ),

                // 🏷️ TEXTOS
                const Positioned(
                  left: 20,
                  bottom: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Historical events',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Significant moments in Lleida history',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 📜 LISTA
          Padding(
            padding: const EdgeInsets.only(top: 180),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: 25, // 🔥 25 puntos
              itemBuilder: (context, index) {
                return _cardPunto(index + 1);
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 CARD
  Widget _cardPunto(int numero) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🏷️ TITULO
            Center(
              child: Text(
                'Point$numero',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 10),

            const Divider(),

            const SizedBox(height: 8),

            // 🌍 INFO
            Row(
              children: const [
                Icon(Icons.public, size: 16, color: Colors.grey),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    '41.6141°N, 0.6258°E  Explore in Google Earth',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }
}