import 'package:flutter/services.dart' show rootBundle;
import '../models/poi_model.dart';

/// Maps canonical POI names to wide images shown briefly in Chromium on the LG wall.
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
  };

  /// Returns the chromium asset path for [poi], or null if none is bundled yet.
  static Future<String?> resolve(POI poi) async {
    final extra = _extraCandidates(poi.name);
    final candidates = <String>[
      if (_byPoiName.containsKey(poi.name)) _byPoiName[poi.name]!,
      ...extra,
      '$_base/${poi.name}.png',
      '$_base/${poi.name}.jpg',
      '$_base/${_slug(poi.name)}.png',
      '$_base/${_slug(poi.name)}.jpg',
    ];

    for (final path in candidates) {
      try {
        await rootBundle.load(path);
        return path;
      } catch (_) {
        // Try next candidate.
      }
    }
    return null;
  }

  static List<String> _extraCandidates(String poiName) {
    if (poiName == 'Science Park') {
      return [
        '$_base/sciencepark.png',
        '$_base/parc_cientific.png',
        '$_base/Parc cientific.png',
      ];
    }
    return const [];
  }

  static String _slug(String name) {
    return name.toLowerCase().replaceAll(RegExp(r"[^a-z0-9]+"), '').trim();
  }
}
