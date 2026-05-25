import 'package:flutter/material.dart';
import '../models/connection_state.dart';
import '../widgets/app_top_bar.dart';

class PagConectar extends StatefulWidget {
  const PagConectar({super.key});

  @override
  State<PagConectar> createState() => _PagConectarState();
}

class _PagConectarState extends State<PagConectar> {
  final _conn = LGConnectionState();
  final _userController = TextEditingController(text: 'lg');
  final _passController = TextEditingController(text: '••••••••••');
  final _ipController = TextEditingController(text: '192.168.1.229');
  final _portController = TextEditingController(text: '22');
  final _passAdminController = TextEditingController(text: '••');
  final _screensController = TextEditingController(text: '5');

  bool get _conectado => _conn.conectado;

  @override
  void initState() {
    super.initState();
    _conn.addListener(_refresh);
  }

  @override
  void dispose() {
    _conn.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() => setState(() {});

  void _conectar() => _conn.conectar(_ipController.text.isNotEmpty ? _ipController.text : '192.168.1.229');
  void _desconectar() => _conn.desconectar();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EBE0),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: const AppTopBar(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(children: [
                GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, size: 22)),
              ]),
            ),
            const SizedBox(height: 6),
            const Text('Connection', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
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
                  child: Row(children: [
                    const Icon(Icons.check_circle, color: Colors.green, size: 18),
                    const SizedBox(width: 8),
                    Expanded(child: Text('Connected to ${_conn.ip}',
                        style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 13))),
                    GestureDetector(
                      onTap: _desconectar,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(8)),
                        child: const Text('Disconnect', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ]),
                ),
              ),
            ],
            const SizedBox(height: 14),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  _campo('User LG', _userController),
                  _campo('Password LG', _passController, obscure: true),
                  _campo('IP', _ipController),
                  _campo('Port LG', _portController),
                  _campo('Password Admin', _passAdminController, obscure: true),
                  _campo('Screens', _screensController,
                      suffix: const Icon(Icons.monitor, size: 18, color: Colors.black45)),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: _conectar,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(color: const Color(0xFF8B7355), borderRadius: BorderRadius.circular(14)),
                      child: const Text('Connect to Liquid Galaxy', textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 30),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _campo(String label, TextEditingController controller,
      {bool obscure = false, Widget? suffix}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontSize: 12.5, color: Colors.black54, fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(color: const Color(0xFFEAE4D8), borderRadius: BorderRadius.circular(10)),
          child: TextField(
            controller: controller, obscureText: obscure,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              suffixIcon: suffix,
            ),
          ),
        ),
      ]),
    );
  }
}
