import 'package:flutter/material.dart';

import 'app_top_bar.dart';
import 'section_back_button.dart';

/// Cabecera de secciones con imagen: controles siempre encima y clicables.
class SectionHeroHeader extends StatelessWidget {
  const SectionHeroHeader({
    super.key,
    required this.imageAsset,
    required this.menuTitle,
    required this.title,
    required this.subtitle,
    required this.filterBar,
    required this.onMenuTap,
    this.badge,
  });

  final String imageAsset;
  final String menuTitle;
  final String title;
  final String subtitle;
  final Widget filterBar;
  final VoidCallback onMenuTap;
  final Widget? badge;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          IgnorePointer(
            child: Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageAsset),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          IgnorePointer(
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.55),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.45),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 70,
            child: IgnorePointer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                      fontFamily: 'serif',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (badge != null)
            Positioned(
              left: 20,
              bottom: 35,
              child: IgnorePointer(child: badge!),
            ),
          Positioned(
            bottom: -28,
            left: 16,
            right: 16,
            child: filterBar,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Material(
              color: Colors.transparent,
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Row(
                    children: [
                      const SectionBackButton(onDarkBackground: true),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: onMenuTap,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const AppTopBar(onDarkBackground: true, wifiOnly: true),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
