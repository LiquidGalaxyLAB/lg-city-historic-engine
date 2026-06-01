import 'package:flutter/material.dart';
import '../widgets/m_superior.dart';

class PagSettings extends StatefulWidget {
  const PagSettings({super.key});

  @override
  State<PagSettings> createState() => _PagSettingsState();
}

class _PagSettingsState extends State<PagSettings> {
  bool _isDark = false;
  String _lang = 'en';

  final List<Map<String, String>> _languages = [
    {'code': 'en', 'flag': 'GB', 'name': 'English'},
    {'code': 'es', 'flag': 'ES', 'name': 'Español'},
    {'code': 'ca', 'flag': '🏴', 'name': 'Català'},
    {'code': 'tr', 'flag': 'TR', 'name': 'Türkçe'},
  ];

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

            // ── BACK + TITLE ──
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
            const Text(
              'Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 24),

            // ── CONTENT ──
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // THEME
                    Row(
                      children: [
                        const Icon(Icons.wb_sunny_outlined, size: 20),
                        const SizedBox(width: 8),
                        const Text(
                          'Theme',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        _ThemeButton(
                          icon: Icons.wb_sunny,
                          label: 'Light',
                          selected: !_isDark,
                          onTap: () => setState(() => _isDark = false),
                        ),
                        const SizedBox(width: 12),
                        _ThemeButton(
                          icon: Icons.dark_mode_outlined,
                          label: 'Dark',
                          selected: _isDark,
                          onTap: () => setState(() => _isDark = true),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // LANGUAGE
                    Row(
                      children: [
                        const Icon(Icons.language, size: 20),
                        const SizedBox(width: 8),
                        const Text(
                          'Language',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        children: _languages.map((lang) {
                          final isSelected = _lang == lang['code'];
                          return GestureDetector(
                            onTap: () => setState(() => _lang = lang['code']!),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 16),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: lang != _languages.last
                                      ? BorderSide(color: Colors.grey.shade100)
                                      : BorderSide.none,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    lang['flag']!,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Text(
                                      lang['name']!,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF8B7355),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                ],
                              ),
                            ),
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
}

class _ThemeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ThemeButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFF5EFE0) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? const Color(0xFF8B7355) : Colors.grey.shade200,
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 24, color: selected ? const Color(0xFF8B7355) : Colors.black45),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                color: selected ? const Color(0xFF8B7355) : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
