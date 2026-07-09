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

  /// Optional path to a still image (e.g. 'assets/3d_points_of_interest/xxx.png')
  /// that, when set, gets sent centered and intact to the three middle
  /// Liquid Galaxy screens (LG1, LG2, LG4) when this POI is sent to LG.
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
    this.era,
    this.startDate,
    this.endDate,
    this.panoramaImage,
  });

  String getDescription(String langCode) {
    if (descriptions != null && descriptions!.containsKey(langCode)) {
      return descriptions![langCode]!;
    }
    return description ?? '';
  }
}
