import 'package:flutter/material.dart';
import 'package:prueba/screens/pag_ubi_interes.dart';
import 'package:prueba/screens/pag_cat.ig.dart';
import 'package:prueba/screens/pag_museos.dart';
import 'package:prueba/screens/pag_hechos_h.dart';
import 'package:prueba/screens/pag_conectar.dart';
import 'package:prueba/widgets/app_top_bar.dart';
import '../main.dart';

class PagCategorias extends StatelessWidget {
  const PagCategorias({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, lang, _) {
        return Scaffold(
          backgroundColor: const Color(0xFFF0EBE0),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
                  child: AppTopBar(currentTitle: T.s('home')),
                ),

                // ── LOGO NUEVO  ──
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Image.asset(
                    'assets/images/2026-05-17 09_25_11-NVIDIA GeForce Overlay.png', 
                    height: 118,
                  ),
                ),

                const SizedBox(height: 18),

                // ── CATEGORY CARDS ──
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    children: [
                      _CategoryCard(
                        color: const Color(0xFFFFF8EE),
                        iconBgColor: const Color(0xFFFFF0D0),
                        icon: Icons.location_on_outlined,
                        iconColor: const Color(0xFFD4913A),
                        title: T.s('poi'),
                        subtitle: T.s('poi_subtitle'),
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const PagUbicInteres())),
                      ),
                      const SizedBox(height: 12),
                      _CategoryCard(
                        color: const Color(0xFFEEF3FA),
                        iconBgColor: const Color(0xFFDCE8F5),
                        icon: Icons.account_balance_outlined,
                        iconColor: const Color(0xFF5B7FA6),
                        title: T.s('cathedrals'),
                        subtitle: T.s('cathedrals_subtitle'),
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const PagCatedralesIglesias())),
                      ),
                      const SizedBox(height: 12),
                      _CategoryCard(
                        color: const Color(0xFFEEF8F3),
                        iconBgColor: const Color(0xFFD4EDE3),
                        icon: Icons.museum_outlined,
                        iconColor: const Color(0xFF3A8C63),
                        title: T.s('museums'),
                        subtitle: T.s('museums_subtitle'),
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const PagMuseos())),
                      ),
                      const SizedBox(height: 12),
                      _CategoryCard(
                        color: const Color(0xFFF3EEF8),
                        iconBgColor: const Color(0xFFE3D8F0),
                        icon: Icons.calendar_month_outlined,
                        iconColor: const Color(0xFF7A5AA6),
                        title: T.s('events'),
                        subtitle: T.s('events_subtitle'),
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const PagHechosHistoricos())),
                      ),
                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const PagConectar())),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 17),
                          decoration: BoxDecoration(
                            color: const Color(0xFFCFE8E0),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            '${T.s('connect')} Liquid Galaxy',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final Color color, iconBgColor, iconColor;
  final IconData icon;
  final String title, subtitle;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.color, required this.iconBgColor, required this.icon,
    required this.iconColor, required this.title, required this.subtitle,
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
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            Container(
              width: 50, height: 50,
              decoration: BoxDecoration(color: iconBgColor, borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: Colors.black87)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 13, color: Colors.black54, height: 1.4)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}
