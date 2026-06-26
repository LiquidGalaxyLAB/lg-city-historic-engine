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
  });
}
