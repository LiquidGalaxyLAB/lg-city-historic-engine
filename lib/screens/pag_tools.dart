import 'package:flutter/material.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/m_superior.dart';

class PagTools extends StatelessWidget {
  const PagTools({super.key});

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
              child: const AppTopBar(),
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
              'Tools',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              'Liquid Galaxy system management tools',
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),

            const SizedBox(height: 14),

            // ── WARNING BANNER ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE0D5B0)),
                ),
                child: const Text(
                  'These actions affect the entire Liquid Galaxy system.\nMake sure you\'re connected before proceeding.',
                  style: TextStyle(fontSize: 12.5, color: Colors.black87, height: 1.4),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // ── TOOL GRID ──
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.0,
                  children: [
                    _ToolCard(
                      title: 'Relaunch LG',
                      description: 'Restart the Liquid Galaxy, rebooting the system',
                      buttonLabel: 'Execute\nRelaunch LG',
                      buttonColor: const Color(0xFF4CAF72),
                      onConfirm: () => _ejecutar(context, 'Relaunch LG'),
                    ),
                    _ToolCard(
                      title: 'Shutdown LG',
                      description: 'Safely power off the Liquid Galaxy system',
                      buttonLabel: 'Execute\nShutdown LG',
                      buttonColor: const Color(0xFFD94F4F),
                      onConfirm: () => _ejecutar(context, 'Shutdown LG'),
                    ),
                    _ToolCard(
                      title: 'Import POIs',
                      description: 'Upload and import Points of interest to the system',
                      buttonLabel: 'Execute\nImport POIs',
                      buttonColor: const Color(0xFF4CAF72),
                      onConfirm: () => _ejecutar(context, 'Import POIs'),
                    ),
                    _ToolCard(
                      title: 'Reboot LG',
                      description: 'Perform a complete system reboot',
                      buttonLabel: 'Execute\nReboot LG',
                      buttonColor: const Color(0xFFD4913A),
                      onConfirm: () => _ejecutar(context, 'Reboot LG'),
                    ),
                  ],
                ),
              ),
            ),

            // ── BOTTOM TOOLS ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _BottomTool(
                    label: 'Clean KMLs',
                    buttonLabel: 'Execute Clean KMLs',
                    buttonColor: const Color(0xFF5C5C5C),
                    onConfirm: () => _ejecutar(context, 'Clean KMLs'),
                  ),
                  const SizedBox(height: 10),
                  _BottomTool(
                    label: 'Show/Hide Logos',
                    buttonLabel: 'Execute Show/Hide',
                    buttonColor: const Color(0xFFB04FC8),
                    onConfirm: () => _ejecutar(context, 'Show/Hide Logos'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
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

// ── TARJETA TOOL ──
class _ToolCard extends StatelessWidget {
  final String title;
  final String description;
  final String buttonLabel;
  final Color buttonColor;
  final VoidCallback onConfirm;

  const _ToolCard({
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.buttonColor,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 12, 10, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 11, color: Colors.black54),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onConfirm,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                buttonLabel,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── TOOL INFERIOR (fila completa) ──
class _BottomTool extends StatelessWidget {
  final String label;
  final String buttonLabel;
  final Color buttonColor;
  final VoidCallback onConfirm;

  const _BottomTool({
    required this.label,
    required this.buttonLabel,
    required this.buttonColor,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5),
            ),
          ),
          GestureDetector(
            onTap: onConfirm,
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                buttonLabel,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── DIÁLOGO DE CONFIRMACIÓN ──
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
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icono advertencia
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
                    onTap: () {
                      Navigator.pop(context);
                      // Aquí iría la lógica de ejecución real
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
