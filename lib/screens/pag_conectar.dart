import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/connection_state.dart';
import '../widgets/app_top_bar.dart';
import '../main.dart';

class PagConectar extends StatefulWidget {
  const PagConectar({super.key});

  @override
  State<PagConectar> createState() => _PagConectarState();
}

class _PagConectarState extends State<PagConectar> {
  final _conn = LGConnectionState();
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  final _ipController = TextEditingController();
  final _portController = TextEditingController();
  final _passAdminController = TextEditingController();
  final _screensController = TextEditingController();

  bool _isLoading = false;

  bool get _conectado => _conn.conectado;

  @override
  void initState() {
    super.initState();
    _conn.addListener(_refresh);
    _loadSettings();
  }

  @override
  void dispose() {
    _conn.removeListener(_refresh);
    _userController.dispose();
    _passController.dispose();
    _ipController.dispose();
    _portController.dispose();
    _passAdminController.dispose();
    _screensController.dispose();
    super.dispose();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userController.text = prefs.getString('lg_user') ?? 'lg';
      _passController.text = prefs.getString('lg_pass') ?? 'lg';
      _ipController.text = prefs.getString('lg_ip') ?? '192.168.1.229';
      _portController.text = prefs.getString('lg_port') ?? '22';
      _passAdminController.text = prefs.getString('lg_pass_admin') ?? '';
      _screensController.text = prefs.getString('lg_screens') ?? '5';
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lg_user', _userController.text);
    await prefs.setString('lg_pass', _passController.text);
    await prefs.setString('lg_ip', _ipController.text);
    await prefs.setString('lg_port', _portController.text);
    await prefs.setString('lg_pass_admin', _passAdminController.text);
    await prefs.setString('lg_screens', _screensController.text);
  }

  Future<void> _conectar() async {
    setState(() => _isLoading = true);

    bool success = await _conn.conectar(
      ip: _ipController.text,
      user: _userController.text,
      password: _passController.text,
      sudoPassword:
          _passAdminController.text.isEmpty ? null : _passAdminController.text,
      port: int.tryParse(_portController.text) ?? 22,
      screens: int.tryParse(_screensController.text) ?? 5,
    );

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (success) {
      await _saveSettings();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(T.s('connect_success')),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(T.s('connect_failed')),
          backgroundColor: Colors.red,
        ),
      );
    }
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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: AppTopBar(currentTitle: T.s('connect')),
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
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  T.s('connect'),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                if (_conectado) ...[
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD8F0D8),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${T.s('connected_to')} ${_conn.ip}',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _conn.desconectar(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                T.s('disconnect'),
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 13,
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
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _campo(T.s('user_lg'), _userController),
                        _campo(T.s('password_lg'), _passController, obscure: true),
                        _campo(T.s('ip_label'), _ipController),
                        _campo(T.s('port_lg'), _portController),
                        _campo(
                          T.s('password_admin'),
                          _passAdminController,
                          obscure: true,
                        ),
                        _campo(
                          T.s('screens'),
                          _screensController,
                          suffix: const Icon(
                            Icons.monitor,
                            size: 18,
                            color: Colors.black45,
                          ),
                        ),
                        const SizedBox(height: 24),
                        GestureDetector(
                          onTap: _isLoading ? null : _conectar,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: _isLoading
                                  ? Colors.grey
                                  : const Color(0xFF8B7355),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: _isLoading
                                ? const Center(
                                    child: SizedBox(
                                      height: 22,
                                      width: 22,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  )
                                : Text(
                                    T.s('connect_lg_button'),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
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
      },
    );
  }

  Widget _campo(
    String label,
    TextEditingController controller, {
    bool obscure = false,
    Widget? suffix,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.5,
              color: isDark ? Colors.white70 : Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF26221A) : const Color(0xFFEAE4D8),
              borderRadius: BorderRadius.circular(10),
              border: isDark ? Border.all(color: Colors.white10) : null,
            ),
            child: TextField(
              controller: controller,
              obscureText: obscure,
              style: TextStyle(
                fontSize: 15,
                color: isDark ? Colors.white : Colors.black87,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                suffixIcon: suffix,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
