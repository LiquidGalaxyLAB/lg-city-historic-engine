import '../app_state.dart';
import '../i18n/translations.dart';

class POI {
  final String name;
  final String location;
  final String image;
  final double? lat;
  final double? lng;
  final double? range;
  final double? tilt;
  final double? heading;
  final String? altitudeMode;
  final String? description;
  final Map<String, String>? descriptions;
  final Map<String, String>? names;
  final String? era;
  final String? startDate;
  final String? endDate;
  final String? panoramaImage;

  POI({
    required this.name,
    required this.location,
    required this.image,
    this.lat,
    this.lng,
    this.range,
    this.tilt,
    this.heading,
    this.altitudeMode,
    this.description,
    this.descriptions,
    this.names,
    this.era,
    this.startDate,
    this.endDate,
    this.panoramaImage,
  });

  POI copyWith({
    String? name,
    String? location,
    String? image,
    double? lat,
    double? lng,
    double? range,
    double? tilt,
    double? heading,
    String? altitudeMode,
    String? description,
    Map<String, String>? descriptions,
    Map<String, String>? names,
    String? era,
    String? startDate,
    String? endDate,
    String? panoramaImage,
  }) {
    return POI(
      name: name ?? this.name,
      location: location ?? this.location,
      image: image ?? this.image,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      range: range ?? this.range,
      tilt: tilt ?? this.tilt,
      heading: heading ?? this.heading,
      altitudeMode: altitudeMode ?? this.altitudeMode,
      description: description ?? this.description,
      descriptions: descriptions ?? this.descriptions,
      names: names ?? this.names,
      era: era ?? this.era,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      panoramaImage: panoramaImage ?? this.panoramaImage,
    );
  }

  String getName([String? langCode]) {
    final lang = langCode ?? languageNotifier.value;
    if (names != null) {
      final direct = names![lang];
      if (direct != null && direct.trim().isNotEmpty) {
        return direct.trim();
      }

      const fallbackOrder = {
        'es': ['ca', 'en'],
        'ca': ['es', 'en'],
        'tr': ['en'],
        'en': <String>[],
      };

      for (final code in fallbackOrder[lang] ?? ['en']) {
        final value = names![code];
        if (value != null && value.trim().isNotEmpty) {
          return value.trim();
        }
      }
    }
    return name;
  }

  String getDescription([String? langCode]) {
    final lang = langCode ?? languageNotifier.value;
    if (descriptions != null) {
      final direct = descriptions![lang];
      if (direct != null && direct.trim().isNotEmpty) {
        return direct.trim();
      }
      if (lang == 'tr') {
        final english = descriptions!['en'];
        if (english != null && english.trim().isNotEmpty) {
          return english.trim();
        }
      }
      if (lang == 'es') {
        final spanish = descriptions!['es'];
        if (spanish != null && spanish.trim().isNotEmpty) {
          return spanish.trim();
        }
      }
      if (lang == 'ca') {
        final catalan = descriptions!['ca'];
        if (catalan != null && catalan.trim().isNotEmpty) {
          return catalan.trim();
        }
      }
      final english = descriptions!['en'];
      if (english != null && english.trim().isNotEmpty) {
        return english.trim();
      }
    }
    return description ?? '';
  }

  String getEra([String? langCode]) {
    if (era == null || era!.trim().isEmpty) return '';
    return T.era(era!);
  }

  bool matchesSearch(String query, [String? langCode]) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    if (getName(langCode).toLowerCase().contains(q)) return true;
    if (name.toLowerCase().contains(q)) return true;
    if (getDescription(langCode).toLowerCase().contains(q)) return true;
    return false;
  }
}
