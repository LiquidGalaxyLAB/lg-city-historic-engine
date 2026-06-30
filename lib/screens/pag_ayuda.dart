import 'package:flutter/material.dart';
import '../widgets/app_top_bar.dart';
import '../main.dart';

class PagAyuda extends StatelessWidget {
  const PagAyuda({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, _, __) {
        return Scaffold(
          backgroundColor: const Color(0xFFF0EBE0),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: AppTopBar(menuKey: 'help'),
                ),
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
                Text(
                  T.s('help'),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          T.s('help_welcome'),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 22),
                        _SectionTitle(T.s('help_nav_title')),
                        _BulletItem(T.s('help_nav_1')),
                        _BulletItem(T.s('help_nav_2')),
                        _BulletItem(T.s('help_nav_3')),
                        const SizedBox(height: 18),
                        _SectionTitle(T.s('help_lg_title')),
                        _BulletItem(T.s('help_lg_1')),
                        const SizedBox(height: 18),
                        _SectionTitle(T.s('help_settings_title')),
                        Text(
                          T.s('help_settings_intro'),
                          style: const TextStyle(
                            fontSize: 13.5,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        _BulletItem(T.s('help_settings_theme')),
                        _BulletItem(T.s('help_settings_lang')),
                        const SizedBox(height: 18),
                        _SectionTitle(T.s('help_more_title')),
                        Text(
                          T.s('help_more_text'),
                          style: const TextStyle(
                            fontSize: 13.5,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
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
