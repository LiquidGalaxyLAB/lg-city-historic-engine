import 'package:flutter/material.dart';

class PagPrincipal extends StatelessWidget {
  const PagPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E0D6), // 🎨 beige
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 40),

                // 🏷️ TÍTULO
                const Text(
                  'City Historic Engine\nCHE',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                ),

                const SizedBox(height: 25),

                // 🖼️ LOGO PRINCIPAL
                Image.asset(
                  'assets/images/che.png', // 👈 tu imagen
                  height: 180,
                ),

                const SizedBox(height: 30),

                // 🧩 LOGOS (GRID)
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 30,
                  runSpacing: 25,
                  children: [
                    _logo('assets/images/lg.jpg'),
                    _logo('assets/images/tic.jpg'),
                    _logo(
                      'assets/images/lg.jpg',
                    ), // google.png -> fallback to lg
                    _logo('assets/images/Parc-Agrobiotech.jpg'),
                    _logo('assets/images/lglab.jpg'),
                    _logo('assets/images/LGEU.jpg'),
                    _logo('assets/images/lglab.jpg'),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 WIDGET LOGO
  Widget _logo(String path) {
    return Image.asset(path, height: 60, fit: BoxFit.contain);
  }
}
