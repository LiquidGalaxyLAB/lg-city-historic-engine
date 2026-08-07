import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/services.dart' show rootBundle;
import '../models/poi_model.dart';
import 'poi_name_catalog.dart';

/// Maps canonical POI names to wide images shown briefly in Chromium on the LG wall.
/// Falls back to each POI's card image ([POI.image]) when no wide chromium asset exists.
class ChromiumImageCatalog {
  ChromiumImageCatalog._();

  static const String _base = 'assets/images_cromiums';

  /// Canonical English [POI.name] -> bundled asset under [assets/images_cromiums/].
  static const Map<String, String> _byPoiName = {
    'Science Park': '$_base/Science Park.png',
    'Sícoris Club': '$_base/sicorisclub.png',
    "Camp d'Esports": '$_base/campsport.png',
    'Castell Templer de Gardeny': '$_base/Gardeny Templar Castle.png',
    'Statue of Indíbil and Mandoni': '$_base/Indíbi and Mandoni.png',
    'Old Hospital of Santa Maria': '$_base/Old Hospital Of Santa Maria.png',
    'La Paeria': '$_base/La Paeria.png',
    "Governor's Fountain": '$_base/governor\'s_fountain.png',
    'Hospital Fountain': '$_base/hospital_fountain.png',
    'La Mitjana (natural heritage)': '$_base/Mitjana de Lleida.png',
    "General's Pillar": '$_base/Pillar of the General.png',
    'La Suda of Lleida': '$_base/Suda de Lleida.png',
    'Seu Vella': '$_base/La Seu Vella.png',
    'Sant Joan Square': '$_base/Sant Joan Square.png',
    'Sant Anastasi Mill': '$_base/Sant Anastasi Mill.png',
    'La Cuirassa': '$_base/The Cuirass.png',
    'Tanneries': '$_base/Curtidurías.png',
    'La Llotja': '$_base/la_llotja.png',
    'Lleida-Pirineus Train Station': '$_base/Lleida Pirineus Station.png',
    'Camps Elisis Park': '$_base/The Champs-Élysées.png',
    'Lleida Courthouse': '$_base/juzgados_lleida.png',
    'Museum of Modern and Contemporary Art of Lleida':
        '$_base/Museum of Modern and Contemporary Art of Lleida.png',
    'Diocesan Museum': '$_base/Diocesan Museum.png',
    'Water Museum': '$_base/Water Museum.png',
    'Automotive Museum': '$_base/Automobile Museum.png',
    'Seu Vella Cathedral': '$_base/La Seu Vella.png',
    'New Cathedral': '$_base/New Cathedral of Lleida.png',
    'Church of Sant Llorenç': '$_base/Church of Saint Lawrence.png',
    'Old Church of San Martí': '$_base/Old Church of San Martí.png',
    'Church of San Juan': '$_base/Church of Saint John.png',
    'Chapel of Sant Jaume': '$_base/Chapel of Saint James.png',
    'Chapel of la Sang': '$_base/Chapel of the Blood.png',
    'Church of Sant Pere': '$_base/Church of Sant Pere.png',
    'Hermitage of Granyena': '$_base/hermitage_of_granyena.png',
    'Academia Mariana': '$_base/Mariana Academy.png',
  };

  /// Eventos históricos usan la imagen de la tarjeta en Chromium (sin contorno ni placemark).
  static bool isHistoricalEvent(POI poi) =>
      poi.image.contains('images_historical_events');

  static bool launchesChromium(POI poi) {
    if (isHistoricalEvent(poi)) {
      return poi.image.trim().isNotEmpty;
    }
    return true;
  }

  /// Returns the chromium asset path for [poi], or null if none is bundled yet.
  static Future<String?> resolve(POI poi) async {
    if (isHistoricalEvent(poi)) {
      final path = poi.image.trim();
      if (path.isEmpty) return null;
      try {
        await rootBundle.load(path);
        debugPrint('ChromiumImageCatalog: historical event ${poi.name} -> $path');
        return path;
      } catch (_) {
        debugPrint('ChromiumImageCatalog: missing historical asset $path');
        return null;
      }
    }

    final canonical = _canonicalNameFor(poi);
    final mapped = _byPoiName[canonical];
    final candidates = <String>[
      if (mapped != null) mapped,
      '$_base/${poi.name}.png',
      '$_base/${poi.name}.jpg',
      '$_base/${_slug(poi.name)}.png',
      '$_base/${_slug(poi.name)}.jpg',
      if (canonical != poi.name) ...[
        '$_base/$canonical.png',
        '$_base/$canonical.jpg',
        '$_base/${_slug(canonical)}.png',
        '$_base/${_slug(canonical)}.jpg',
      ],
      if (mapped == null) ...[
        if (poi.image.trim().isNotEmpty) poi.image.trim(),
        if (poi.panoramaImage != null && poi.panoramaImage!.trim().isNotEmpty)
          poi.panoramaImage!.trim(),
      ],
    ];

    for (final path in candidates) {
      try {
        await rootBundle.load(path);
        debugPrint('ChromiumImageCatalog: resolved ${poi.name} -> $path');
        return path;
      } catch (_) {
        // Try next candidate.
      }
    }

    debugPrint(
      'ChromiumImageCatalog: no asset for ${poi.name} '
      '(canonical=$canonical, tried ${candidates.length} paths)',
    );
    return null;
  }

  /// Lists POIs that have a chromium asset bundled in the app.
  static Future<Map<String, String>> listAvailable() async {
    final available = <String, String>{};
    for (final entry in _byPoiName.entries) {
      try {
        await rootBundle.load(entry.value);
        available[entry.key] = entry.value;
      } catch (_) {
        // Missing asset.
      }
    }
    return available;
  }

  static String _canonicalNameFor(POI poi) {
    final candidates = <String>{poi.name};
    if (poi.names != null) {
      candidates.addAll(poi.names!.values);
    }

    for (final candidate in candidates) {
      final canonical = canonicalEnglishNameFor(candidate);
      if (canonical != null) {
        return canonical;
      }
    }
    return poi.name;
  }

  static String _slug(String name) {
    return name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '').trim();
  }
}
