/// SQLite row for a Lleida place (used to enrich POI translations).
class Place {
  final int? id;
  final String category; // 'locations', 'cathedrals', 'museums', 'events'
  final String name;
  final double latitude;
  final double longitude;
  final double altitude;
  final double heading;
  final double tilt;
  final double range;
  final String altitudeMode;
  final String era;
  final String? startDate;
  final String? endDate;
  final String descriptionCa; // Catalan
  final String descriptionEs; // Spanish
  final String descriptionEn; // English

  Place({
    this.id,
    required this.category,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.heading,
    required this.tilt,
    required this.range,
    required this.altitudeMode,
    required this.era,
    this.startDate,
    this.endDate,
    required this.descriptionCa,
    required this.descriptionEs,
    required this.descriptionEn,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'category': category,
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
        'altitude': altitude,
        'heading': heading,
        'tilt': tilt,
        'range': range,
        'altitude_mode': altitudeMode,
        'era': era,
        'start_date': startDate,
        'end_date': endDate,
        'description_ca': descriptionCa,
        'description_es': descriptionEs,
        'description_en': descriptionEn,
      };

  factory Place.fromMap(Map<String, dynamic> m) => Place(
        id: m['id'] as int?,
        category: m['category'] as String,
        name: m['name'] as String,
        latitude: (m['latitude'] as num).toDouble(),
        longitude: (m['longitude'] as num).toDouble(),
        altitude: (m['altitude'] as num).toDouble(),
        heading: (m['heading'] as num).toDouble(),
        tilt: (m['tilt'] as num).toDouble(),
        range: (m['range'] as num).toDouble(),
        altitudeMode: m['altitude_mode'] as String,
        era: m['era'] as String,
        startDate: m['start_date'] as String?,
        endDate: m['end_date'] as String?,
        descriptionCa: m['description_ca'] as String,
        descriptionEs: m['description_es'] as String,
        descriptionEn: m['description_en'] as String,
      );
}
