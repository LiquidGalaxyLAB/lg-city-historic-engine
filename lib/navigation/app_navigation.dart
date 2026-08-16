import 'package:flutter/material.dart';

import '../screens/pag_conectar.dart' deferred as connect;

/// Small navigation helpers used from the launch / connect screens.
class AppNavigation {
  AppNavigation._();

  static void popOrHome(BuildContext context) {
    final navigator = Navigator.of(context, rootNavigator: true);
    if (navigator.canPop()) {
      navigator.pop();
      return;
    }

    navigator.popUntil((route) => route.isFirst);
  }

  static Future<void> openConnect(BuildContext context) async {
    await connect.loadLibrary();
    if (!context.mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => connect.ConnectPage()),
    );
  }
}
