import 'package:flutter/material.dart';
import 'package:prueba/screens/pag_ubi_interes.dart';
import 'package:prueba/screens/pag_cat.ig.dart';
import 'package:prueba/screens/pag_museos.dart';
import 'package:prueba/screens/pag_hechos_h.dart';
import 'package:prueba/screens/pag_conectar.dart';
import 'package:prueba/widgets/m_superior.dart';

class PagCategorias extends StatelessWidget {
  const PagCategorias({super.key});

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
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 6,
                          ),
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

            // ── LOGO CHE ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/che.png',
                      height: 90,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            // ── CATEGORY CARDS ──
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _CategoryCard(
                    color: const Color(0xFFFFF8EE),
                    iconBgColor: const Color(0xFFFFF0D0),
                    icon: Icons.location_on_outlined,
                    iconColor: const Color(0xFFD4913A),
                    title: 'Points of interest',
                    subtitle: 'Discover historics landmarks\nand monuments across Lleida',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PagUbicInteres()),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _CategoryCard(
                    color: const Color(0xFFEEF3FA),
                    iconBgColor: const Color(0xFFDCE8F5),
                    icon: Icons.account_balance_outlined,
                    iconColor: const Color(0xFF5B7FA6),
                    title: 'Cathedrals & Churches',
                    subtitle: 'Explore sacrted archuteture\nand religious heritage',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PagCatedralesIglesias()),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _CategoryCard(
                    color: const Color(0xFFEEF8F3),
                    iconBgColor: const Color(0xFFD4EDE3),
                    icon: Icons.museum_outlined,
                    iconColor: const Color(0xFF3A8C63),
                    title: 'Museums',
                    subtitle: 'Visit cultural institutions\nand exhibition spaces',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PagMuseos()),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _CategoryCard(
                    color: const Color(0xFFF3EEF8),
                    iconBgColor: const Color(0xFFE3D8F0),
                    icon: Icons.calendar_month_outlined,
                    iconColor: const Color(0xFF7A5AA6),
                    title: 'Historical Events',
                    subtitle: 'Learn about significant\nmoments in Lleida history',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PagHechosHistoricos()),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── CONNECT BUTTON ──
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PagConectar()),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      decoration: BoxDecoration(
                        color: const Color(0xFFCFE8E0),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Text(
                        'Connect to Liquid Galaxy',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final Color color;
  final Color iconBgColor;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.color,
    required this.iconBgColor,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon box
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 26),
            ),
            const SizedBox(width: 14),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: Colors.black54,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 15, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}
