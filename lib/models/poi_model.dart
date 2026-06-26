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
  final String? description; // Mantener por compatibilidad si es necesario
  final Map<String, String>? descriptions; // Mapa de idiomas: {'en': '...', 'es': '...', ...}
  final String? epoca;
  final String? fechaInici;
  final String? fechaFi;

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
    this.epoca,
    this.fechaInici,
    this.fechaFi,
  });
<<<<<<< HEAD

  String getDescription(String langCode) {
    if (descriptions != null && descriptions!.containsKey(langCode)) {
      return descriptions![langCode]!;
    }
    return description ?? '';
  }
=======
>>>>>>> parent of fdca477 (17/06/2026)
}
