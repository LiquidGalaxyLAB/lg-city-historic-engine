import 'package:flutter/material.dart';
import '../widgets/app_top_bar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EBE0),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 22),
              child: AppTopBar(currentTitle: 'About Us'),
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
            const Text(
              'About Us',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    const Text(
                      'Author name - Yasmina Ramadan\n'
                      'Mentor name - Claudia \n'
                      'Organization administrator name - Andreu Ibáñez\n\n'
                      'Author contact information - \n'
                      'yasiramadan@gmail.com\n'
                      'Support - Lleida Liquid Galaxy LAB',
                      textAlign: TextAlign.center,
                      style: TextStyle(
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
  }
}
