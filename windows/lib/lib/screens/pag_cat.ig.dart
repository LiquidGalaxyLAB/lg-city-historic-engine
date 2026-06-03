import 'package:flutter/material.dart';

class PagCatedralesIglesias extends StatelessWidget {
  const PagCatedralesIglesias({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E0D6),
      body: Column(
        children: [
          // 🔝 HEADER CON IMAGEN
          Stack(
            children: [
              Container(
                height: 220,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/catedral_nova.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // OSCURECER IMAGEN
              Container(height: 220, color: Colors.black.withOpacity(0.3)),

              // ICONOS
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.menu, color: Colors.white, size: 28),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // TEXTO HEADER
              const Positioned(
                left: 20,
                bottom: 30,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cathedrals & Churches',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Sacred architecture and religious sites',
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // 📜 LISTA
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: 21, // 🔥 21 puntos
              itemBuilder: (context, index) {
                return _cardPoint(index + 1);
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 TARJETA
  Widget _cardPoint(int num) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TÍTULO
          Text(
            'Point$num',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 10),

          const Divider(),

          const SizedBox(height: 10),

          // INFO + LINK
          Row(
            children: [
              const Icon(Icons.public, size: 16, color: Colors.grey),
              const SizedBox(width: 5),
              const Text(
                '41.6141°N, 0.6258°E',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Explore in Google Earth',
                  style: TextStyle(fontSize: 12, color: Colors.orange),
                ),
              ),
              const Icon(Icons.arrow_forward, size: 16, color: Colors.orange),
            ],
          ),
        ],
      ),
    );
  }
}
