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
  final Map<String, String>?
      descriptions; // Language map: {'en': '...', 'es': '...', ...}
  final String? era;
  final String? startDate;
  final String? endDate;

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
    this.era,
    this.startDate,
    this.endDate,
  });

  String getDescription(String langCode) {
    if (descriptions != null && descriptions!.containsKey(langCode)) {
      return descriptions![langCode]!;
    }
    return description ?? '';
  }
}
