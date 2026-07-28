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
    'Science Park': '$_base/sience_parc.png',
    'Sícoris Club': '$_base/sicorisclub.png',
    "Camp d'Esports": '$_base/campsport.png',
    'Castell Templer de Gardeny': '$_base/Gardeny Templar Castle.png',
    'Statue of Indíbil and Mandoni': '$_base/Indíbi and Mandoni.png',
    'Old Hospital of Santa Maria': '$_base/Old Hospital Of Santa Maria.png',
    'La Paeria': '$_base/La Paeria.png',
  };

  /// Extra filename candidates when the canonical asset path is missing.
  static const Map<String, List<String>> _extraByCanonical = {
    'Science Park': [
      '$_base/sience_parc.png',
      '$_base/science_park.png',
      '$_base/sciencepark.png',
    ],
  };

  /// Returns the chromium asset path for [poi], or null if none is bundled yet.
  static Future<String?> resolve(POI poi) async {
    final canonical = _canonicalNameFor(poi);
    final extra = _extraByCanonical[canonical] ?? const <String>[];
    final candidates = <String>[
      if (_byPoiName.containsKey(canonical)) _byPoiName[canonical]!,
      ...extra,
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
      // Card image only when no wide chromium asset exists for this POI.
      if (!_byPoiName.containsKey(canonical)) ...[
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
