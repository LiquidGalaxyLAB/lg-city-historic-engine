import 'package:flutter/material.dart';
import 'package:prueba/screens/pag_acerca_de.dart';
import 'package:prueba/screens/pag_ayuda.dart';
import 'package:prueba/screens/pag_cat.ig.dart';
import 'package:prueba/screens/pag_conectar.dart';
import 'package:prueba/screens/pag_hechos_h.dart';
import 'package:prueba/screens/pag_inicio_categ.dart';
import 'package:prueba/screens/pag_museos.dart';
import 'package:prueba/screens/pag_tools.dart';
import 'package:prueba/screens/pag_ubi_interes.dart';
import 'package:prueba/widgets/m_superior.dart';
import '../screens/pag_principal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PagCategorias(),
    );
  }
}