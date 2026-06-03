import 'package:flutter/material.dart';

import '../screens/pag_conectar.dart';
import '../screens/pag_acerca_de.dart';
import '../screens/pag_ayuda.dart';
import '../screens/pag_tools.dart';
import '../screens/pag_inicio_categ.dart';
import '../screens/pag_settings.dart';

class MenuFlotante extends StatelessWidget {
  final String? currentTitle;
  const MenuFlotante({super.key, this.currentTitle});

  static void mostrar(BuildContext context, {String? currentTitle}) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'menu',
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) =>
          MenuFlotante(currentTitle: currentTitle),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(opacity: anim1, child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F0E8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(4, 0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  'MENU',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[700],
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _item(
                      context,
                      icon: Icons.home_outlined,
                      title: 'Categories',
                      subtitle: 'Browse categories',
                      highlighted: currentTitle == 'Categories',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PagCategorias(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                    _item(
                      context,
                      icon: Icons.wifi,
                      title: 'Connection',
                      subtitle: 'Liquid Galaxy status',
                      highlighted: currentTitle == 'Connection',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PagConectar(),
                          ),
                        );
                      },
                    ),
                    _item(
                      context,
                      icon: Icons.build_outlined,
                      title: 'Tools',
                      subtitle: 'Utility tools',
                      highlighted: currentTitle == 'Tools',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PagTools()),
                        );
                      },
                    ),
                    _item(
                      context,
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      subtitle: 'App preferences',
                      highlighted: currentTitle == 'Settings',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PagSettings(),
                          ),
                        );
                      },
                    ),
                    _item(
                      context,
                      icon: Icons.info_outline,
                      title: 'About Us',
                      subtitle: 'Learn more',
                      highlighted: currentTitle == 'About Us',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PagAcercaDe(),
                          ),
                        );
                      },
                    ),
                    _item(
                      context,
                      icon: Icons.help_outline,
                      title: 'Help',
                      subtitle: 'Get assistance',
                      highlighted: currentTitle == 'Help',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PagAyuda()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool highlighted = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: highlighted ? const Color(0xFF6F4E37) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: highlighted ? Colors.white : Colors.black87,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: highlighted ? Colors.white : Colors.black87,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: highlighted
                          ? Colors.white.withOpacity(0.8)
                          : Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
