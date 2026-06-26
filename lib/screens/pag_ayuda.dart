import 'package:flutter/material.dart';
import '../widgets/app_top_bar.dart';

class PagAyuda extends StatelessWidget {
  const PagAyuda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EBE0),
      body: SafeArea(
        child: Column(
          children: [
            // ── TOP BAR ──
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: AppTopBar(currentTitle: 'Help'),
            ),

            // ── BACK + TITLE ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, size: 28),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Help',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 24),

            // ── CONTENT ──
            const Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to the help section. Here you will find guidance on how to use the application.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 22),
                    _SectionTitle('How to navigate'),
                    _BulletItem(
                      'Use the main menu to explore different sections.',
                    ),
                    _BulletItem(
                      'Select a category to view available locations or historical events.',
                    ),
                    _BulletItem('Click on any item to display it on the map.'),
                    SizedBox(height: 18),
                    _SectionTitle('Send to Liquid Galaxy'),
                    _BulletItem(
                      'Press "Send to LG →" to display the selected location on the screens.',
                    ),
                    SizedBox(height: 18),
                    _SectionTitle('Settings'),
                    Text(
                      'You can change:',
                      style: TextStyle(fontSize: 13.5, color: Colors.black87),
                    ),
                    SizedBox(height: 6),
                    _BulletItem('Theme (Light/Dark)'),
                    _BulletItem(
                      'Language (English, Spanish, Catalan, Turkish)',
                    ),
                    SizedBox(height: 18),
                    _SectionTitle('Need more help?'),
                    Text(
                      ' If you experience any issues, please restart the application or check your connection.',
                      style: TextStyle(
                        fontSize: 13.5,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 40),
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

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  final String text;
  const _BulletItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 13.5)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13.5,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
