class POI {
  final String name;
  final String location;
  final String image;
  final double? lat;
  final double? lng;
  final double? range;

  POI({
    required this.name,
    required this.location,
    required this.image,
    this.lat,
    this.lng,
    this.range,
  });
}
