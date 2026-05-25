import 'package:flutter/material.dart';
import '../widgets/m_superior.dart';

class PagAcercaDe extends StatelessWidget {
  const PagAcercaDe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EBE0),
      body: SafeArea(
        child: Column(
          children: [
            // ── TOP BAR ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => MenuFlotante.mostrar(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6),
                        ],
                      ),
                      child: const Icon(Icons.menu, size: 22),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4C9B0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.auto_awesome, size: 22, color: Colors.brown),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, size: 22),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            const Text('About Us', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Text(
                      'Nombre del autor - Yasmina Ramadan\n'
                      'Nombre del mentor\n'
                      'Nombre del administrador de la organización - Andreu Ibáñez\n\n'
                      'Información de contacto del autor -\n'
                      'yasiramadan@gmail.com\n'
                      'Soporte Lleida Liquid Galaxy LAB',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, height: 1.6, color: Colors.black87),
                    ),
                    const SizedBox(height: 30),
                    Image.asset('assets/images/lg.jpg', height: 80),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/images/tic.jpg', height: 60),
                        Image.asset('assets/images/verano.jpg', height: 60),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/images/Parc-Agrobiotech.jpg', height: 60),
                        Image.asset('assets/images/lglab.jpg', height: 50),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Image.asset('assets/images/LGEU.jpg', height: 50),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
