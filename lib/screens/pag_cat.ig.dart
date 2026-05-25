import 'package:flutter/material.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/m_superior.dart';

class PagCatedralesIglesias extends StatelessWidget {
  const PagCatedralesIglesias({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E0D6),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 220,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/catedral.jpg'), fit: BoxFit.cover),
                ),
              ),
              Container(height: 220, color: Colors.black.withOpacity(0.3)),
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
                left: 50, bottom: 40, right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cathedrals & Churches', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500)),
                    SizedBox(height: 5),
                    Text('Sacred architecture and religious sites', style: TextStyle(fontSize: 14, color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: 21,
              itemBuilder: (context, index) => _cardPoint(index + 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardPoint(int num) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Point$num', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Row(children: const [
            Icon(Icons.public, size: 16, color: Colors.grey),
            SizedBox(width: 5),
            Text('41.6141°N, 0.6258°E', style: TextStyle(fontSize: 12, color: Colors.grey)),
            SizedBox(width: 10),
            Expanded(child: Text('Explore in Google Earth', style: TextStyle(fontSize: 12, color: Colors.orange))),
            Icon(Icons.arrow_forward, size: 16, color: Colors.orange),
          ]),
        ],
      ),
    );
  }
}
