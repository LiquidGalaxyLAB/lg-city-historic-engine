import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _languageKey = 'app_language';

/// Global UI state. Screens listen to these notifiers instead of a large
/// state-management package. Language codes: en, es, ca, tr.
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
final ValueNotifier<String> languageNotifier = ValueNotifier('en');

Future<void> initAppState() async {
  final prefs = await SharedPreferences.getInstance();
  final savedLang = prefs.getString(_languageKey);
  if (savedLang != null && savedLang.isNotEmpty) {
    languageNotifier.value = savedLang;
  }
}

Future<void> setAppLanguage(String code) async {
  languageNotifier.value = code;
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_languageKey, code);
}
