import 'package:flutter/material.dart';
import '../widgets/app_top_bar.dart';

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: const AppTopBar(currentTitle: 'Tools'),
            ),

            // ── BACK + TITLE ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      size: 28,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  _ToolCard(
                    title: 'Relaunch LG',
                    description: '',
                    buttonLabel: 'Execute Relaunch LG',
                    backgroundColor: const Color(0xFFEEF3FA),
                    buttonColor: const Color(0xFF1D61E7),
                    isFullWidth: true,
                    onConfirm: () => _ejecutar(context, 'Relaunch LG'),
                  ),
                  const SizedBox(height: 8),
                  _ToolCard(
                    title: 'Shutdown LG',
                    description: '',
                    buttonLabel: 'Execute Shutdown LG',
                    backgroundColor: const Color(0xFFFEEEEE),
                    buttonColor: const Color(0xFFE21111),
                    isFullWidth: true,
                    onConfirm: () => _ejecutar(context, 'Shutdown LG'),
                  ),
                  const SizedBox(height: 8),
                  _ToolCard(
                    title: 'Import POIs',
                    description: '',
                    buttonLabel: 'Execute Import POIs',
                    backgroundColor: const Color(0xFFEEF8F3),
                    buttonColor: const Color(0xFF0C8A4C),
                    isFullWidth: true,
                    onConfirm: () => _ejecutar(context, 'Import POIs'),
                  ),
                  const SizedBox(height: 8),
                  _ToolCard(
                    title: 'Reboot LG',
                    description: '',
                    buttonLabel: 'Execute Reboot LG',
                    backgroundColor: const Color(0xFFFEF7EE),
                    buttonColor: const Color(0xFFD4730A),
                    isFullWidth: true,
                    onConfirm: () => _ejecutar(context, 'Reboot LG'),
                  ),
                  const SizedBox(height: 8),
                  _ToolCard(
                    title: 'Clean KMLs',
                    description: '',
                    buttonLabel: 'Execute Clean KMLs',
                    backgroundColor: const Color(0xFFE5E5E5),
                    buttonColor: const Color(0xFF454545),
                    isFullWidth: true,
                    onConfirm: () => _ejecutar(context, 'Clean KMLs'),
                  ),
                  const SizedBox(height: 8),
                  _ToolCard(
                    title: 'Show/Hide Logos',
                    description: '',
                    buttonLabel: 'Execute Show/Hide',
                    backgroundColor: const Color(0xFFFDE7FF),
                    buttonColor: const Color(0xFFA50DBA),
                    isFullWidth: true,
                    onConfirm: () => _ejecutar(context, 'Show/Hide Logos'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _ejecutar(BuildContext context, String accion) {
    showDialog(
      context: context,
      builder: (_) => _ConfirmDialog(accion: accion),
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

      // ✅ MODIFICADO:
      // padding más equilibrado
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: isFullWidth ? 10 : 14,
      ),

      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF26221A) : backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: isDark
            ? Border.all(color: backgroundColor.withOpacity(0.3), width: 1)
            : null,
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── TITLE ──
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,

              // ✅ MODIFICADO:
              // tamaño aumentado
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

          // ── BOTÓN ──
          GestureDetector(
            onTap: onConfirm,

            // ✅ MODIFICADO:
            // SizedBox + width infinity
            // para que TODOS los botones
            // tengan exactamente el mismo ancho
            child: SizedBox(
              width: double.infinity,
              child: Container(
                // ✅ MODIFICADO:
                // centra perfectamente el contenido
                alignment: Alignment.center,

                // ✅ MODIFICADO:
                // padding uniforme
                padding: const EdgeInsets.symmetric(vertical: 12),

                decoration: BoxDecoration(
                  color: buttonColor,

                  // ✅ MODIFICADO:
                  // bordes más redondeados
                  borderRadius: BorderRadius.circular(22),
                ),

                child: Text(
                  buttonLabel,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,

                    // ✅ MODIFICADO:
                    // texto del botón más grande
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

  const _ConfirmDialog({required this.accion});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF3A3A3A),
          borderRadius: BorderRadius.circular(20),
        ),

        // ✅ MODIFICADO:
        // padding uniforme
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── ICON ──
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
                // ── CANCEL ──
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

                // ── CONFIRM ──
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
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
