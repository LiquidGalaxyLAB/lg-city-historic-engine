import 'package:flutter/material.dart';

import '../main.dart';

import '../widgets/app_top_bar.dart';



class AboutPage extends StatelessWidget {

  const AboutPage({super.key});



  @override

  Widget build(BuildContext context) {

    return ValueListenableBuilder<String>(

      valueListenable: languageNotifier,

      builder: (context, _, __) {

        return Scaffold(

          backgroundColor: Theme.of(context).scaffoldBackgroundColor,

          body: SafeArea(

            child: Column(

              children: [

                Padding(

                  padding:

                      const EdgeInsets.symmetric(horizontal: 18, vertical: 22),

                  child: AppTopBar(

                    showBack: true,

                    currentTitle: T.s('menu_about'),

                  ),

                ),

                const SizedBox(height: 8),

                Text(

                  T.s('menu_about'),

                  style: const TextStyle(

                      fontSize: 25, fontWeight: FontWeight.w600),

                ),

                const SizedBox(height: 10),

                const Expanded(

                  child: SingleChildScrollView(

                    padding: EdgeInsets.symmetric(horizontal: 25),

                    child: Column(

                      children: [

                        _AboutInfoList(),

                        SizedBox(height: 30),

                        _AboutLogosLayout(),

                        SizedBox(height: 40),

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



class _AboutLogosLayout extends StatelessWidget {

  const _AboutLogosLayout();



  @override

  Widget build(BuildContext context) {

    return Padding(

      padding: const EdgeInsets.symmetric(horizontal: 8),

      child: Image.asset(

        'assets/images/KMLs/logos.png',

        fit: BoxFit.contain,

        width: MediaQuery.of(context).size.width * 0.85,

        errorBuilder: (context, error, stackTrace) {

          return const Icon(

            Icons.image_not_supported_outlined,

            size: 48,

            color: Color(0xFF8B7355),

          );

        },

      ),

    );

  }

}



class _AboutInfoList extends StatelessWidget {

  const _AboutInfoList();



  @override

  Widget build(BuildContext context) {

    final items = [

      (label: T.s('about_author_label'), value: T.s('about_author_value')),

      (label: T.s('about_mentor_label'), value: T.s('about_mentor_value')),

      (label: T.s('about_admin_label'), value: T.s('about_admin_value')),

      (label: T.s('about_contact_label'), value: T.s('about_contact_value')),

      (label: T.s('about_support_label'), value: T.s('about_support_value')),

      (label: T.s('about_logo_designer_label'), value: T.s('about_logo_designer_value')),

      (label: T.s('about_history_label'), value: T.s('about_history_value')),

      (

        label: T.s('about_coordinates_label'),

        value: T.s('about_coordinates_value')

      ),

    ];



    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        for (var i = 0; i < items.length; i++) ...[

          _AboutBulletItem(

            label: items[i].label,

            value: items[i].value,

          ),

          if (i < items.length - 1) const SizedBox(height: 14),

        ],

      ],

    );

  }

}



class _AboutBulletItem extends StatelessWidget {

  const _AboutBulletItem({

    required this.label,

    required this.value,

  });



  final String label;

  final String value;



  @override

  Widget build(BuildContext context) {

    return Row(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        const Padding(

          padding: EdgeInsets.only(top: 6, right: 12),

          child: Icon(

            Icons.circle,

            size: 7,

            color: Color(0xFF6B5B45),

          ),

        ),

        Expanded(

          child: RichText(

            text: TextSpan(

              style: TextStyle(

                fontSize: 15,

                height: 1.5,

                color: Theme.of(context).colorScheme.onSurface,

              ),

              children: [

                TextSpan(

                  text: '$label: ',

                  style: TextStyle(

                    fontWeight: FontWeight.w600,

                    color: Theme.of(context).colorScheme.onSurface,

                  ),

                ),

                TextSpan(text: value),

              ],

            ),

          ),

        ),

      ],

    );

  }

}


