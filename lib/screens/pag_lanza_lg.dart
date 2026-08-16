import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../main.dart';
import '../models/connection_state.dart';
import '../models/poi_model.dart';
import '../services/lg_service.dart';
import '../services/narration_service.dart';
import '../services/poi_localization.dart';
import '../screens/pag_conectar.dart';
import '../navigation/app_navigation.dart';
import '../widgets/m_superior.dart';
import '../widgets/section_back_button.dart';

/// Detail screen for one place. If the rig is already connected, it sends
/// the POI immediately. Orbit and narration are toggled from this page.
class LaunchLGPage extends StatefulWidget {
  final POI poi;

  const LaunchLGPage({super.key, required this.poi});

  @override
  State<LaunchLGPage> createState() => _LaunchLGPageState();
}

class _LaunchLGPageState extends State<LaunchLGPage> {
  final LGConnectionState _conn = LGConnectionState();
  final LGService _lgService = LGService();
  final NarrationService _narration = NarrationService();
  bool _isOrbiting = false;
  bool _isNarrating = false;
  late POI _poi;
  String? _lastPresentedLang;

  @override
  void initState() {
    super.initState();
    _poi = PoiLocalization.instance.enrich(widget.poi);
    languageNotifier.addListener(_onLanguageChanged);
    _narration.init(
      onSpeakingChanged: () {
        if (mounted) {
          setState(() => _isNarrating = _narration.isSpeaking);
        }
      },
    );
    _conn.addListener(_onConnectionChanged);
    // Send to Liquid Galaxy as soon as this page opens (no-op if offline).
    _initLG();
  }

  void _onConnectionChanged() {
    if (mounted) setState(() {});
  }

  void _onLanguageChanged() {
    if (!mounted) return;
    setState(() {});
    if (_conn.isConnected && _lastPresentedLang != languageNotifier.value) {
      _lgService.presentPoi(_poi);
      _lastPresentedLang = languageNotifier.value;
    }
    if (_narration.isSpeaking) {
      _narration.speakPoi(_poi, languageNotifier.value);
    }
  }

  Future<void> _initLG() async {
    if (!_conn.isConnected) {
      debugPrint('LaunchLGPage: not connected — skipping LG send');
      return;
    }

    await _lgService.presentPoi(_poi);
    _lastPresentedLang = languageNotifier.value;
  }

  void _toggleNarration() {
    _narration.speakPoi(_poi, languageNotifier.value);
  }

  void _toggleOrbit() {
    setState(() {
      _isOrbiting = !_isOrbiting;
    });

    if (_isOrbiting) {
      _lgService.startOrbitPOI(widget.poi);
    } else {
      _lgService.stopOrbit();
    }
  }

  void _leavePage() {
    _lgService.stopOrbit();
    if (_narration.isSpeaking) {
      _narration.stop();
    }
    AppNavigation.popOrHome(context);
    _lgService.closeChromiumQuick();
  }

  @override
  void dispose() {
    languageNotifier.removeListener(_onLanguageChanged);
    _conn.removeListener(_onConnectionChanged);
    _narration.dispose();
    _lgService.stopOrbit();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, lang, _) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => FloatingMenu.show(context,
                            currentTitle: _poi.getName(lang)),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(
                                  alpha: AppTheme.shadowAlpha(context),
                                ),
                                blurRadius: 10,
                              )
                            ],
                          ),
                          child: Icon(
                            Icons.menu,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ConnectPage()),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF2A3D2A)
                                : const Color(0xFFD7F5E9),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            _conn.isConnected ? Icons.wifi : Icons.wifi_off,
                            color: isDark
                                ? const Color(0xFF80E8C0)
                                : (_conn.isConnected
                                    ? const Color(0xFF4CAF50)
                                    : const Color(0xFF6B5B45)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Back Arrow
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: SectionBackButton(
                      icon: Icons.arrow_back,
                      iconSize: 30,
                      onPressed: _leavePage,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Main Card
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius:
                            BorderRadius.circular(40), // Very rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(
                              alpha: AppTheme.shadowAlpha(context),
                            ),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          // Image
                          Expanded(
                            flex: 5,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(40)),
                              child: Image.asset(
                                widget.poi.image,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.image_not_supported,
                                      size: 80),
                                ),
                              ),
                            ),
                          ),

                          // Title
                          Padding(
                            padding: const EdgeInsets.only(top: 25, bottom: 10),
                            child: Text(
                              _poi.getName(lang),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'serif',
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Divider(
                              color: Theme.of(context).dividerColor,
                              thickness: 1.5,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                            child: Text(
                              T.s('launch_lg_select_hint'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                            ),
                          ),

                          const Spacer(),

                          // Action Buttons
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 30, left: 20, right: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildActionCard(
                                    icon: _isNarrating
                                        ? Icons.stop_circle_outlined
                                        : Icons.volume_up_outlined,
                                    label: T.s('ai_narration'),
                                    isActive: _isNarrating,
                                    onTap: _toggleNarration,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: _buildActionCard(
                                    icon: Icons.near_me_outlined,
                                    label: T.s('orbit'),
                                    isActive: _isOrbiting,
                                    onTap: _toggleOrbit,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bgColor = isActive
        ? const Color(0xFF4E342E)
        : (isDark ? const Color(0xFF26221A) : const Color(0xFFFBF9F6));
    final Color iconColor = isActive ? Colors.white : const Color(0xFF6B5B45);
    final Color textColor =
        isActive ? Colors.white : Theme.of(context).colorScheme.onSurface;
    final Color circleColor = isActive
        ? const Color(0xFF3E2723)
        : (isDark ? const Color(0xFF352E25) : const Color(0xFFF5F1E9));

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
              color: isActive ? Colors.transparent : const Color(0xFFF2F2F7)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
