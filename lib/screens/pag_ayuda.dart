import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/app_top_bar.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, _, __) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: AppTopBar(currentTitle: T.s('help')),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          size: 28,
                          color: onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  T.s('help'),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: onSurface,
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
                          style: TextStyle(
                            fontSize: 14,
                            color: onSurface,
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
                          style: TextStyle(fontSize: 13.5, color: onSurface),
                        ),
                        const SizedBox(height: 6),
                        _BulletItem(T.s('help_settings_theme')),
                        _BulletItem(T.s('help_settings_lang')),
                        const SizedBox(height: 18),
                        _SectionTitle(T.s('help_more_title')),
                        Text(
                          T.s('help_more_text'),
                          style: TextStyle(
                            fontSize: 13.5,
                            color: onSurface,
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
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  const _BulletItem(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7, right: 10),
            child: Icon(Icons.circle, size: 6, color: onSurface),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 13.5, color: onSurface, height: 1.45),
            ),
          ),
        ],
      ),
    );
  }
}
