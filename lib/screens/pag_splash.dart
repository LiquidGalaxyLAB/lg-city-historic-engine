import 'dart:async';
import 'package:flutter/material.dart';
import 'pag_inicio_categ.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // 2-second timer for the transition to the main screen
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CategoriesHomePage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Image.asset(
            'assets/images/KMLs/logos.png',
            fit: BoxFit.contain,
            width: MediaQuery.of(context).size.width * 1.109,
            // If the image fails to load, show a loading indicator instead of nothing
            errorBuilder: (context, error, stackTrace) {
              return const CircularProgressIndicator(
                color: Color(0xFF8B7355),
              );
            },
          ),
        ),
      ),
    );
  }
}
