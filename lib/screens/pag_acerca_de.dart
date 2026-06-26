import 'package:flutter/material.dart';
import '../widgets/app_top_bar.dart';
import '../main.dart';

class PagAcercaDe extends StatelessWidget {
  const PagAcercaDe({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, _, __) {
        return Scaffold(
          backgroundColor: const Color(0xFFF0EBE0),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 22,
                  ),
                  child: AppTopBar(menuKey: 'about'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back, size: 28),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  T.s('menu_about'),
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        Text(
                          '${T.s('about_author')}\n'
                          '${T.s('about_mentor')}\n'
                          '${T.s('about_admin')}\n\n'
                          '${T.s('about_contact')}\n'
                          '${T.s('about_support')}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.6,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Image.asset('assets/images/lg.jpg', height: 80),
                        const SizedBox(height: 35),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('assets/images/tic.jpg', height: 70),
                            Image.asset('assets/images/verano.jpg', height: 60),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/images/Parc-Agrobiotech.jpg',
                              height: 60,
                            ),
                            Image.asset('assets/images/lglab.jpg', height: 50),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Image.asset('assets/images/LGEU.jpg', height: 50),
                        const SizedBox(height: 40),
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
}
