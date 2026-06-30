import 'dart:async';
import 'package:flutter/material.dart';
import 'pag_inicio_categ.dart';

class PagSplashScreen extends StatefulWidget {
  const PagSplashScreen({super.key});

  @override
  State<PagSplashScreen> createState() => _PagSplashScreenState();
}

class _PagSplashScreenState extends State<PagSplashScreen> {
  @override
  void initState() {
    super.initState();
    // Temporizador de 2 segundos para la transición a la pantalla principal
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PagCategorias()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usamos el mismo beige que el resto de la app para evitar el color negro
      backgroundColor: const Color(0xFFF0EBE0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Image.asset(
            'assets/images/KMLs/logos.png',
            fit: BoxFit.contain,
            width: MediaQuery.of(context).size.width * 0.7,
            // Si la imagen fallara, mostramos un indicador de carga en lugar de nada
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
