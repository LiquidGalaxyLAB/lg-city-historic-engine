import 'package:flutter/material.dart';
import 'pag_ubi_interes.dart';
import 'pag_cat.ig.dart';
import 'pag_museos.dart';
import 'pag_hechos_h.dart';
import 'pag_conectar.dart';
import '../theme/app_theme.dart';
import '../widgets/app_top_bar.dart';
import '../main.dart';

/// Home after splash. Four heritage categories plus a shortcut to Connect.
/// Labels come from [T.s] so the page follows the selected language.
class CategoriesHomePage extends StatelessWidget {
  const CategoriesHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, lang, _) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 8, 18, 0),
                  child: Column(
                    children: [
                      AppTopBar(currentTitle: T.s('home')),
                      const SizedBox(height: 4),
                      Image.asset('assets/images/logo.png', height: 142),
                      const SizedBox(height: 4),
                      Text(
                        T.s('db_status'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3,
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // ── CATEGORY CARDS ──
                Expanded(
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    children: [
                      _CategoryCard(
                        color: const Color(0xFFFFF8EE),
                        iconBgColor: const Color(0xFFFFF0D0),
                        icon: Icons.location_on_outlined,
                        iconColor: const Color(0xFFD4913A),
                        title: T.s('poi'),
                        subtitle: T.s('poi_subtitle'),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const POILocationsPage(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _CategoryCard(
                        color: const Color(0xFFEEF3FA),
                        iconBgColor: const Color(0xFFDCE8F5),
                        icon: Icons.account_balance_outlined,
                        iconColor: const Color(0xFF5B7FA6),
                        title: T.s('cathedrals'),
                        subtitle: T.s('cathedrals_subtitle'),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CathedralsChurchesPage(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _CategoryCard(
                        color: const Color(0xFFEEF8F3),
                        iconBgColor: const Color(0xFFD4EDE3),
                        icon: Icons.museum_outlined,
                        iconColor: const Color(0xFF3A8C63),
                        title: T.s('museums'),
                        subtitle: T.s('museums_subtitle'),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const MuseumsPage()),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _CategoryCard(
                        color: const Color(0xFFF3EEF8),
                        iconBgColor: const Color(0xFFE3D8F0),
                        icon: Icons.calendar_month_outlined,
                        iconColor: const Color(0xFF7A5AA6),
                        title: T.s('events'),
                        subtitle: T.s('events_subtitle'),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HistoricalEventsPage(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ConnectPage(),
                          ),
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 17),
                          decoration: BoxDecoration(
                            color: AppTheme.tintedCard(
                              context,
                              const Color(0xFFCFE8E0),
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            '${T.s('connect')} Liquid Galaxy',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final Color color, iconBgColor, iconColor;
  final IconData icon;
  final String title, subtitle;
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppTheme.categoryCardBackground(context, color),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: AppTheme.shadowAlpha(context),
              ),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppTheme.categoryIconBackground(context, iconBgColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 16 ,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
