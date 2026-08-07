import 'dart:math' as math;

import 'package:flutter/foundation.dart' show debugPrint;

import '../data/poi_outline_catalog.dart';
import '../models/poi_model.dart';
import 'kml_escape.dart';
import 'placemark_icon.dart';

/// KML 3D site footprint + placemark on the shared globe layer (all screens).
class PoiHighlightCircle {
  PoiHighlightCircle._();

  static const String kmlPath = '/var/www/html/kml/poi_highlight.kml';
  static const String kmlUrl = 'http://lg1:81/kml/poi_highlight.kml';

  static const double _minRadiusM = 40;
  static const double _maxRadiusM = 280;
  static const double _minWallHeightM = 18;
  static const double _maxWallHeightM = 60;
  static const double _groundLineWidth = 8;
  static const double _topLineWidth = 7;

  static const Map<String, double> _radiusByPoiName = {
    'Science Park': 150,
  };

  static double radiusForPoi(POI poi) {
    final named = _radiusByPoiName[poi.name];
    if (named != null) return named;

    final range = poi.range ?? 200.0;
    return (range * 0.38).clamp(_minRadiusM, _maxRadiusM);
  }

  static double wallHeightForPoi(POI poi) {
    final range = poi.range ?? 200.0;
    return (range * 0.06).clamp(_minWallHeightM, _maxWallHeightM);
  }

  static bool usesFootprintPolygon(POI poi) =>
      PoiOutlineCatalog.polygonFor(poi) != null;

  static String generateDocument(POI poi) {
    final safeName = escapeXml(poi.name);
    final footprint = usesFootprintPolygon(poi);
    debugPrint(
      'PoiHighlightCircle: ${poi.name} -> '
      '${footprint ? "OSM footprint" : "oriented fallback"}',
    );

    return '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2">
  <Document id="poi_highlight">
    <name>$safeName highlight</name>
    <open>1</open>
${markup(poi)}
  </Document>
</kml>''';
  }

  static String markup(POI poi) {
    final wallHeight = wallHeightForPoi(poi);
    final safeName = escapeXml(poi.name);

    final lineColor = PlacemarkIconManager.kmlAbgrHexForPoi(poi, alpha: 250);
    final groundColor = PlacemarkIconManager.kmlAbgrHexForPoi(poi, alpha: 230);

    final outline = _outlineRing(poi);
    final topRing = _coordinatesString(outline, wallHeight);
    final groundRing = _coordinatesString(outline, 0);
    final verticalWalls = _verticalWallsMarkup(poi, outline, wallHeight);

    return '''    <Style id="poi_top_ring">
      <LineStyle>
        <color>$lineColor</color>
        <width>$_topLineWidth</width>
      </LineStyle>
      <PolyStyle>
        <color>00000000</color>
        <fill>0</fill>
        <outline>0</outline>
      </PolyStyle>
    </Style>
    <Style id="poi_ground_ring">
      <LineStyle>
        <color>$groundColor</color>
        <width>$_groundLineWidth</width>
      </LineStyle>
      <PolyStyle>
        <color>00000000</color>
        <fill>0</fill>
        <outline>0</outline>
      </PolyStyle>
    </Style>
    <Style id="poi_wall_line">
      <LineStyle>
        <color>$lineColor</color>
        <width>4</width>
      </LineStyle>
      <PolyStyle>
        <color>00000000</color>
        <fill>0</fill>
        <outline>0</outline>
      </PolyStyle>
    </Style>
    <Placemark id="poi_ground_ring">
      <name>$safeName ground outline</name>
      <visibility>1</visibility>
      <styleUrl>#poi_ground_ring</styleUrl>
      <LineString>
        <tessellate>1</tessellate>
        <altitudeMode>clampToGround</altitudeMode>
        <coordinates>$groundRing</coordinates>
      </LineString>
    </Placemark>
    <Placemark id="poi_top_ring">
      <name>$safeName 3D outline</name>
      <visibility>1</visibility>
      <styleUrl>#poi_top_ring</styleUrl>
      <LineString>
        <tessellate>1</tessellate>
        <altitudeMode>relativeToGround</altitudeMode>
        <coordinates>$topRing</coordinates>
      </LineString>
    </Placemark>
$verticalWalls''';
  }

  static String _verticalWallsMarkup(
    POI poi,
    List<({double lat, double lng})> outline,
    double wallHeight,
  ) {
    if (outline.length < 2) return '';

    final safeName = escapeXml(poi.name);
    final height = wallHeight.toStringAsFixed(1);
    final buffer = StringBuffer();
    final vertexCount = outline.length - 1;

    for (var i = 0; i < vertexCount; i++) {
      final point = outline[i];
      buffer.writeln('''    <Placemark id="poi_wall_$i">
      <name>$safeName wall $i</name>
      <visibility>1</visibility>
      <styleUrl>#poi_wall_line</styleUrl>
      <LineString>
        <tessellate>1</tessellate>
        <altitudeMode>relativeToGround</altitudeMode>
        <coordinates>${point.lng},${point.lat},0 ${point.lng},${point.lat},$height</coordinates>
      </LineString>
    </Placemark>''');
    }

    return buffer.toString().trimRight();
  }

  static String blank() {
    return '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document id="poi_highlight"></Document>
</kml>''';
  }

  static List<({double lat, double lng})> _outlineRing(POI poi) {
    final custom = PoiOutlineCatalog.polygonFor(poi);
    if (custom != null && custom.length >= 3) {
      return _closeRing(custom);
    }
    return _orientedRectangle(poi);
  }

  static List<({double lat, double lng})> _orientedRectangle(POI poi) {
    final lat = poi.lat ?? 41.6147;
    final lng = poi.lng ?? 0.6268;
    final radius = radiusForPoi(poi);
    final headingRad = ((poi.heading ?? 0) - 90) * math.pi / 180;
    final halfLength = radius * 1.08;
    final halfWidth = radius * 0.72;

    final corners = <({double north, double east})>[
      (north: halfLength, east: -halfWidth),
      (north: halfLength, east: halfWidth),
      (north: -halfLength, east: halfWidth),
      (north: -halfLength, east: -halfWidth),
    ];

    final ring = corners.map((corner) {
      final north = corner.north * math.cos(headingRad) -
          corner.east * math.sin(headingRad);
      final east = corner.north * math.sin(headingRad) +
          corner.east * math.cos(headingRad);
      return _offsetMeters(lat, lng, north, east);
    }).toList(growable: false);

    return _closeRing(ring);
  }

  static List<({double lat, double lng})> _closeRing(
    List<({double lat, double lng})> ring,
  ) {
    if (ring.isEmpty) return ring;
    final first = ring.first;
    final last = ring.last;
    if (first.lat == last.lat && first.lng == last.lng) return ring;
    return [...ring, first];
  }

  static ({double lat, double lng}) _offsetMeters(
    double lat,
    double lng,
    double northM,
    double eastM,
  ) {
    const earthRadiusM = 6378137.0;
    final latRad = lat * math.pi / 180;
    final dLat = northM / earthRadiusM * 180 / math.pi;
    final dLng = eastM / (earthRadiusM * math.cos(latRad)) * 180 / math.pi;
    return (lat: lat + dLat, lng: lng + dLng);
  }

  static String _coordinatesString(
    List<({double lat, double lng})> ring,
    double altitudeMeters,
  ) {
    final buffer = StringBuffer();
    for (final point in ring) {
      buffer.write('${point.lng},${point.lat},$altitudeMeters ');
    }
    return buffer.toString().trim();
  }
}
