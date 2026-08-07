import 'package:flutter/material.dart';
import '../models/connection_state.dart';
import '../widgets/app_top_bar.dart';
import '../services/lg_service.dart';
import '../main.dart';

class ToolsPage extends StatefulWidget {
  const ToolsPage({super.key});

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  final LGConnectionState _conn = LGConnectionState();
  final LGService _lgService = LGService();
  bool _isLogosVisible = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, _, __) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: AppTopBar(showBack: true, currentTitle: T.s('tools')),
                ),
                const SizedBox(height: 5),
                Text(
                  T.s('tools'),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                Text(
                  T.s('tools_subtitle'),
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      children: [
                        _ToolCard(
                          title: T.s('relaunch_lg'),
                          description: '',
                          buttonLabel: T.s('execute_relaunch_lg'),
                          backgroundColor: const Color(0xFFEEF3FA),
                          buttonColor: const Color(0xFF1D61E7),
                          isFullWidth: true,
                          onConfirm: () => _execute(
                              context, T.s('relaunch_lg'), _lgService.relaunch),
                        ),
                        const SizedBox(height: 8),
                        _ToolCard(
                          title: T.s('shutdown_lg'),
                          description: '',
                          buttonLabel: T.s('execute_shutdown_lg'),
                          backgroundColor: const Color(0xFFFEEEEE),
                          buttonColor: const Color(0xFFE21111),
                          isFullWidth: true,
                          onConfirm: () => _execute(
                              context, T.s('shutdown_lg'), _lgService.shutdown),
                        ),
                        const SizedBox(height: 8),
                        _ToolCard(
                          title: T.s('reboot_lg'),
                          description: '',
                          buttonLabel: T.s('execute_reboot_lg'),
                          backgroundColor: const Color(0xFFFEF7EE),
                          buttonColor: const Color(0xFFD4730A),
                          isFullWidth: true,
                          onConfirm: () => _execute(
                              context, T.s('reboot_lg'), _lgService.reboot),
                        ),
                        const SizedBox(height: 8),
                        _ToolCard(
                          title: T.s('clean_kmls'),
                          description: '',
                          buttonLabel: T.s('execute_clean_kmls'),
                          backgroundColor: const Color(0xFFE5E5E5),
                          buttonColor: const Color(0xFF454545),
                          isFullWidth: true,
                          onConfirm: () => _execute(
                              context, T.s('clean_kmls'), _lgService.clearKMLs),
                        ),
                        const SizedBox(height: 8),
                        _ToolCard(
                          title: T.s('clean_logos'),
                          description: '',
                          buttonLabel: T.s('execute_clean_logos'),
                          backgroundColor: const Color(0xFFE5E5E5),
                          buttonColor: const Color(0xFF454545),
                          isFullWidth: true,
                          onConfirm: () => _execute(context, T.s('clean_logos'),
                              _lgService.clearLogos),
                        ),
                        const SizedBox(height: 8),
                        _ToolCard(
                          title: T.s('show_hide_logos'),
                          description: '',
                          buttonLabel: T.s('execute_show_hide'),
                          backgroundColor: const Color(0xFFFDE7FF),
                          buttonColor: const Color(0xFFA50DBA),
                          isFullWidth: true,
                          onConfirm: () => _execute(
                              context, T.s('show_hide_logos'), () async {
                            if (_isLogosVisible) {
                              await _lgService.clearLogos();
                            } else {
                              await _lgService.showLogos();
                            }
                            setState(() {
                              _isLogosVisible = !_isLogosVisible;
                            });
                          }),
                        ),
                        const SizedBox(height: 20),
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

  void _execute(
      BuildContext context, String action, Future<void> Function() callback) {
    if (!_conn.isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(T.s('connect_first'))),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => _ConfirmDialog(
        action: action,
        onConfirm: () async {
          try {
            await callback();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('$action ${T.s('executed_successfully')}')),
              );
            }
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('${T.s('error_executing')} $action: $e')),
              );
            }
          }
        },
      ),
    );
  }
}

class _ToolCard extends StatelessWidget {
  final String title;
  final String description;
  final String buttonLabel;
  final Color backgroundColor;
  final Color buttonColor;
  final VoidCallback onConfirm;
  final bool isFullWidth;

  const _ToolCard({
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.backgroundColor,
    required this.buttonColor,
    required this.onConfirm,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: isFullWidth ? 10 : 14,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF26221A) : backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: isDark
            ? Border.all(
                color: backgroundColor.withValues(alpha: 0.3), width: 1)
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: isFullWidth ? 15 : 19,
              fontFamily: 'serif',
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          if (description.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
                height: 1.2,
              ),
            ),
          ],
          const SizedBox(height: 10),
          GestureDetector(
            onTap: onConfirm,
            child: SizedBox(
              width: double.infinity,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Text(
                  buttonLabel,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.1,
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

class _ConfirmDialog extends StatelessWidget {
  final String action;
  final VoidCallback onConfirm;

  const _ConfirmDialog({required this.action, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, _, __) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF3A3A3A),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4913A).withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.warning_amber_rounded,
                    color: Color(0xFFD4913A),
                    size: 34,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  T.s('confirm_action'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${T.s('confirm_execute')}\n$action?',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF5A5A5A),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            T.s('cancel'),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          onConfirm();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B7355),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            T.s('confirm'),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
