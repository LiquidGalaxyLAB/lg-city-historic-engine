import 'package:flutter/material.dart';
import '../widgets/app_top_bar.dart';
import '../main.dart';

class PagSettings extends StatefulWidget {
  const PagSettings({super.key});

  @override
  State<PagSettings> createState() => _PagSettingsState();
}

class _PagSettingsState extends State<PagSettings> {
  final List<Map<String, String>> _languages = [
    {'code': 'en', 'flag': 'GB', 'name': 'English'},
    {'code': 'es', 'flag': 'ES', 'name': 'Español'},
    {'code': 'ca', 'flag': '🏴', 'name': 'Català'},
    {'code': 'tr', 'flag': 'TR', 'name': 'Türkçe'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, currentLang, _) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                // ── TOP BAR ──
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: AppTopBar(currentTitle: T.s('settings')),
                ),

                // ── BACK + TITLE ──
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back, size: 28, color: isDark ? Colors.white : Colors.black87),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  T.s('settings'),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: isDark ? Colors.white : Colors.black87),
                ),

                const SizedBox(height: 24),

                // ── CONTENT ──
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        // ── THEME CARD ──
                        _SectionCard(
                          icon: Icons.wb_sunny_outlined,
                          iconBg: const Color(0xFFE8EFFF),
                          iconColor: const Color(0xFFD4913A),
                          title: T.s('theme'),
                          child: Row(
                            children: [
                              Expanded(
                                child: _ThemeOption(
                                  label: T.s('light'),
                                  icon: Icons.wb_sunny_outlined,
                                  selected: themeNotifier.value == ThemeMode.light,
                                  onTap: () {
                                    themeNotifier.value = ThemeMode.light;
                                    setState(() {});
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _ThemeOption(
                                  label: T.s('dark'),
                                  icon: Icons.dark_mode_outlined,
                                  selected: themeNotifier.value == ThemeMode.dark,
                                  onTap: () {
                                    themeNotifier.value = ThemeMode.dark;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ── LANGUAGE CARD ──
                        _SectionCard(
                          icon: Icons.language,
                          iconBg: const Color(0xFFE8F9F1),
                          iconColor: const Color(0xFF1CB17F),
                          title: T.s('language'),
                          child: Column(
                            children: _languages.map((l) {
                              final isSelected = currentLang == l['code'];
                              return _LanguageOption(
                                code: l['flag']!,
                                name: l['name']!,
                                selected: isSelected,
                                onTap: () {
                                  languageNotifier.value = l['code']!;
                                },
                              );
                            }).toList(),
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
      }
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final Widget child;

  const _SectionCard({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF26221A) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(isDark ? 0.2 : 0.06), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: iconBg.withOpacity(isDark ? 0.1 : 1.0), shape: BoxShape.circle),
                child: Icon(icon, size: 20, color: iconColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.w600, 
                  fontFamily: 'serif',
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: selected 
              ? (isDark ? const Color(0xFF352E25) : const Color(0xFFFEF7EE)) 
              : (isDark ? const Color(0xFF1B1811) : Colors.white),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? const Color(0xFF8B7355) : (isDark ? Colors.grey.shade800 : Colors.grey.shade200),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: selected 
                    ? (isDark ? const Color(0xFF4A3421).withOpacity(0.3) : const Color(0xFFFEF7EE))
                    : (isDark ? Colors.black26 : Colors.grey.shade100),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 24, color: selected ? const Color(0xFFD4913A) : (isDark ? Colors.white38 : Colors.black38)),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600, 
                fontSize: 15, 
                fontFamily: 'serif',
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String code;
  final String name;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.code,
    required this.name,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: selected 
                ? (isDark ? const Color(0xFF352E25) : const Color(0xFFFEF7EE))
                : (isDark ? const Color(0xFF1B1811) : Colors.white),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? const Color(0xFF8B7355) : (isDark ? Colors.grey.shade800 : Colors.grey.shade200),
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Text(
                code, 
                style: TextStyle(
                  fontSize: 15, 
                  fontWeight: FontWeight.bold, 
                  fontFamily: 'serif',
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.w500, 
                    fontFamily: 'serif',
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              if (selected)
                Container(
                  width: 8, height: 8,
                  decoration: const BoxDecoration(color: Color(0xFFD4913A), shape: BoxShape.circle),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
