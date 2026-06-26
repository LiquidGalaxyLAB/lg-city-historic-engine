import 'package:flutter/material.dart';
import '../models/poi_model.dart';
import '../main.dart';

class PagDetallesPOI extends StatelessWidget {
  final POI poi;

  const PagDetallesPOI({super.key, required this.poi});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, _, __) {
        return Scaffold(
          appBar: AppBar(
            title: Text(poi.name),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  poi.image,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 300,
                    color: Colors.grey,
                    child: const Icon(Icons.image_not_supported, size: 100),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        poi.name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        poi.location,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Logic to send to LG
                        },
                        child: Text(T.s('send_lg')),
                      ),
                    ],
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
