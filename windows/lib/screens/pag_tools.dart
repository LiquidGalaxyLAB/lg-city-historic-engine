import 'package:flutter/material.dart';
import '../widgets/app_top_bar.dart';
import '../models/connection_state.dart';

class PagTools extends StatelessWidget {
  const PagTools({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // ── TOP BAR ──
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: AppTopBar(currentTitle: 'Tools'),
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

            const SizedBox(height: 5),

            Text(
              'Tools',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),

            Text(
              'Liquid Galaxy system management tools',
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
                      title: 'Relaunch LG',
                      description: 'Restart the Liquid Galaxy visual system',
                      buttonLabel: 'Execute Relaunch LG',
                      backgroundColor: const Color(0xFFEEF3FA),
                      buttonColor: const Color(0xFF1D61E7),
                      isFullWidth: true,
                      onConfirm: () => _confirmarEjecucion(context, 'Relaunch LG', () => LGConnectionState().relaunchLG()),
                    ),
                    const SizedBox(height: 8),
                    _ToolCard(
                      title: 'Shutdown LG',
                      description: 'Turn off all screens in the cluster',
                      buttonLabel: 'Execute Shutdown LG',
                      backgroundColor: const Color(0xFFFEEEEE),
                      buttonColor: const Color(0xFFE21111),
                      isFullWidth: true,
                      onConfirm: () => _confirmarEjecucion(context, 'Shutdown LG', () => LGConnectionState().shutdownLG()),
                    ),
                    const SizedBox(height: 8),
                    _ToolCard(
                      title: 'Reboot LG',
                      description: 'Reboot all computers in the cluster',
                      buttonLabel: 'Execute Reboot LG',
                      backgroundColor: const Color(0xFFFEF7EE),
                      buttonColor: const Color(0xFFD4730A),
                      isFullWidth: true,
                      onConfirm: () => _confirmarEjecucion(context, 'Reboot LG', () => LGConnectionState().rebootLG()),
                    ),
                    const SizedBox(height: 8),
                    _ToolCard(
                      title: 'Clean KMLs',
                      description: 'Remove all active visualizations and KML files',
                      buttonLabel: 'Execute Clean KMLs',
                      backgroundColor: const Color(0xFFE5E5E5),
                      buttonColor: const Color(0xFF454545),
                      isFullWidth: true,
                      onConfirm: () => _confirmarEjecucion(context, 'Clean KMLs', () => LGConnectionState().cleanKMLs()),
                    ),
                    const SizedBox(height: 8),
                    _ToolCard(
                      title: 'Show Logos',
                      description: 'Display the application logo on the left screen',
                      buttonLabel: 'Execute Show',
                      backgroundColor: const Color(0xFFFDE7FF),
                      buttonColor: const Color(0xFFA50DBA),
                      isFullWidth: true,
                      onConfirm: () => _confirmarEjecucion(context, 'Show Logos', () => LGConnectionState().showLogo()),
                    ),
                    const SizedBox(height: 8),
                    _ToolCard(
                      title: 'Hide Logos',
                      description: 'Remove logos from the side screens',
                      buttonLabel: 'Execute Hide',
                      backgroundColor: const Color(0xFFFDE7FF),
                      buttonColor: const Color(0xFF7B0A8A),
                      isFullWidth: true,
                      onConfirm: () => _confirmarEjecucion(context, 'Hide Logos', () => LGConnectionState().cleanLogos()),
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
  }

  void _confirmarEjecucion(BuildContext context, String accion, Future<void> Function() funcion) {
    if (!LGConnectionState().conectado) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please connect to Liquid Galaxy first'), backgroundColor: Colors.red),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => _ConfirmDialog(
        accion: accion,
        onConfirm: () async {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Executing: $accion...')),
          );
          try {
            await funcion();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$accion executed successfully'), backgroundColor: Colors.green),
              );
            }
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error executing $accion: $e'), backgroundColor: Colors.red),
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
        border: isDark ? Border.all(color: backgroundColor.withOpacity(0.3), width: 1) : null,
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
              style: TextStyle(
                fontSize: 13,
                color: isDark ? Colors.white70 : Colors.black87,
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
  final String accion;
  final VoidCallback onConfirm;

  const _ConfirmDialog({
    required this.accion,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF3A3A3A),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFD4913A).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.warning_amber_rounded,
                color: Color(0xFFD4913A),
                size: 34,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Confirm Action',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Are you sure you want to execute\n$accion?',
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
                      child: const Text(
                        'Cancel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
                    onTap: onConfirm,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B7355),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Confirm',
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
  }
}
