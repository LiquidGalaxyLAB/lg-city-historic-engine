import 'package:flutter/material.dart';
import '../widgets/m_superior.dart';

class PagConectar extends StatefulWidget {
  const PagConectar({super.key});

  @override
  State<PagConectar> createState() => _PagConectarState();
}

class _PagConectarState extends State<PagConectar> {
  bool _conectado = false;
  String _ip = '';

  final _userController = TextEditingController();
  final _passController = TextEditingController();
  final _ipController = TextEditingController();
  final _portController = TextEditingController();
  final _passAdminController = TextEditingController();
  final _screensController = TextEditingController();

  void _conectar() {
    setState(() {
      _conectado = true;
      _ip = _ipController.text.isNotEmpty ? _ipController.text : '192.168.1.229';
    });
  }

  void _desconectar() {
    setState(() {
      _conectado = false;
    });
  }

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
                      color: _conectado
                          ? const Color(0xFFD4EDD4)
                          : const Color(0xFFD4C9B0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.wifi,
                      size: 22,
                      color: _conectado ? Colors.green : Colors.brown,
                    ),
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
              'Connection',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),

            // ── STATUS BANNER (solo si conectado) ──
            if (_conectado) ...[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD8F0D8),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.green, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Connected to $_ip',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _desconectar,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Disconnect',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            const SizedBox(height: 14),

            // ── FIELDS ──
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _campo('User LG', _userController),
                    _campo('Password LG', _passController, obscure: true),
                    _campo('IP', _ipController, hint: '192.168.1.229'),
                    _campo('Port LG', _portController, hint: '22'),
                    _campo('Password Admin', _passAdminController, obscure: true),
                    _campo('Screens', _screensController, hint: '5',
                        suffix: const Icon(Icons.monitor, size: 18, color: Colors.black45)),
                    if (_conectado)
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 8),
                        child: Text(
                          'Number of display screens',
                          style: TextStyle(fontSize: 11.5, color: Colors.black45),
                        ),
                      ),
                    const SizedBox(height: 24),
                    // ── CONNECT BUTTON ──
                    GestureDetector(
                      onTap: _conectar,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8B7355),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Text(
                          'Connect to Liquid Galaxy',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _campo(String label, TextEditingController controller,
      {bool obscure = false, String? hint, Widget? suffix}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12.5,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFEAE4D8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: controller,
              obscureText: obscure,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.black26, fontSize: 14),
                suffixIcon: suffix,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
