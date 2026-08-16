import 'dart:math' as math;

import '../data/poi_name_catalog.dart';
import '../models/lugares.dart';
import '../models/poi_model.dart';
import 'database_helper.dart';

/// Adds translated names and descriptions to a [POI] before it is shown or sent.
///
/// Sources, in order: the POI itself, [poiNameCatalog], then the nearest
/// SQLite [Place] (matched by GPS, max 0.8 km). The app still works if the
/// database is missing.
class PoiLocalization {
  PoiLocalization._();
  static final PoiLocalization instance = PoiLocalization._();

  final List<Place> _places = [];
  bool _ready = false;

  static const _maxMatchDistanceKm = 0.8;

  Future<void> init() async {
    if (_ready) return;
    try {
      _places.addAll(await DatabaseHelper.instance.getAllPlaces());
    } catch (_) {
      // Catalog-only mode: lists still work without SQLite.
    }
    _ready = true;
  }

  Place? _findNearestPlace(double lat, double lng) {
    Place? best;
    var bestDistance = double.infinity;

    for (final place in _places) {
      final distance = _distanceKm(lat, lng, place.latitude, place.longitude);
      if (distance < bestDistance) {
        bestDistance = distance;
        best = place;
      }
    }

    if (best != null && bestDistance <= _maxMatchDistanceKm) {
      return best;
    }
    return null;
  }

  double _distanceKm(double lat1, double lng1, double lat2, double lng2) {
    const earthRadiusKm = 6371.0;
    final dLat = _toRadians(lat2 - lat1);
    final dLng = _toRadians(lng2 - lng1);
    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRadians(lat1)) *
            math.cos(_toRadians(lat2)) *
            math.sin(dLng / 2) *
            math.sin(dLng / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadiusKm * c;
  }

  double _toRadians(double degrees) => degrees * 3.141592653589793 / 180.0;

  POI enrich(POI poi) {
    final descriptions = <String, String>{};
    if (poi.description != null && poi.description!.trim().isNotEmpty) {
      descriptions['en'] = poi.description!.trim();
    }
    if (poi.descriptions != null) {
      descriptions.addAll(poi.descriptions!);
    }

    final names = <String, String>{'en': poi.name};
    if (poi.names != null) {
      names.addAll(poi.names!);
    }

    final catalog = catalogNamesFor(poi.name);
    if (catalog != null) {
      names.addAll(catalog);
    }

    if (poi.lat != null && poi.lng != null) {
      final place = _findNearestPlace(poi.lat!, poi.lng!);
      if (place != null) {
        descriptions['ca'] = place.descriptionCa;
        descriptions['es'] = place.descriptionEs;
        descriptions['en'] = place.descriptionEn;
        names.putIfAbsent('ca', () => place.name);
      }
    }

    return poi.copyWith(
      descriptions: descriptions.isEmpty ? null : descriptions,
      names: names,
    );
  }

  List<POI> enrichAll(Iterable<POI> pois) =>
      pois.map(enrich).toList(growable: false);
}
