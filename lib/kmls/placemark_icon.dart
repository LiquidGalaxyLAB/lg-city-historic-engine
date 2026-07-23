import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:image/image.dart' as img;

import '../models/poi_model.dart';

class _PoiColor {
  const _PoiColor(this.r, this.g, this.b);
  final int r;
  final int g;
  final int b;
}

/// Genera iconos de placemark (forma de pin) con color distinto por sitio.
class PlacemarkIconManager {
  static const _assetPath = 'assets/images/KMLs/placemark_base.png';
  static const _iconScale = 2.2;

  static Uint8List? _baseBytes;

  static const List<_PoiColor> _palette = [
    _PoiColor(76, 175, 80), // verde
    _PoiColor(33, 150, 243), // azul
    _PoiColor(156, 39, 176), // morado
    _PoiColor(0, 150, 136), // teal
    _PoiColor(255, 152, 0), // naranja
    _PoiColor(63, 81, 181), // índigo
    _PoiColor(0, 188, 212), // cian
    _PoiColor(205, 220, 57), // lima
    _PoiColor(121, 85, 72), // marrón
    _PoiColor(103, 58, 183), // violeta
    _PoiColor(233, 30, 99), // rosa
    _PoiColor(255, 193, 7), // ámbar
  ];

  static int _colorSeed(POI poi) =>
      Object.hash(poi.name, poi.lat ?? 0, poi.lng ?? 0).abs();

  static _PoiColor colorForPoi(POI poi) {
    return _palette[_colorSeed(poi) % _palette.length];
  }

  static String remoteFileNameFor(POI poi) {
    final color = colorForPoi(poi);
    final id = _colorSeed(poi);
    return 'placemark_${id}_${color.r}_${color.g}_${color.b}.png';
  }

  /// LG1 (master) debe cargar el icono vía localhost (misma máquina que Apache).
  static String iconUrlFor(POI poi) =>
      'http://localhost:81/kml/${remoteFileNameFor(poi)}';

  static Future<Uint8List> buildColoredIcon(POI poi) async {
    _baseBytes ??= (await rootBundle.load(_assetPath)).buffer.asUint8List();
    final base = img.decodeImage(_baseBytes!);
    if (base == null) {
      throw StateError('No se pudo decodificar $_assetPath');
    }

    final color = colorForPoi(poi);
    final tinted = img.Image.from(base);
    final w = tinted.width;
    final h = tinted.height;

    for (var y = 0; y < h; y++) {
      for (var x = 0; x < w; x++) {
        final pixel = tinted.getPixel(x, y);
        if (pixel.a == 0) continue;

        final pr = pixel.r.toInt();
        final pg = pixel.g.toInt();
        final pb = pixel.b.toInt();
        final isDark = pr < 48 && pg < 48 && pb < 48;
        if (isDark) {
          if (_isCenterHole(x, y, w, h)) continue;
          tinted.setPixelRgba(x, y, 0, 0, 0, 0);
          continue;
        }

        tinted.setPixelRgba(x, y, color.r, color.g, color.b, pixel.a.toInt());
      }
    }

    return Uint8List.fromList(img.encodePng(tinted));
  }

  static String kmlPlacemark({
    required POI poi,
    required double lat,
    required double lng,
    required String documentId,
  }) {
    final iconUrl = iconUrlFor(poi);
    return '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
  <Document id="$documentId">
    <Placemark>
      <name>${poi.name}</name>
      <visibility>1</visibility>
      <Style>
        <IconStyle>
          <scale>$_iconScale</scale>
          <Icon>
            <href>$iconUrl</href>
          </Icon>
          <hotSpot x="0.5" y="1.0" xunits="fraction" yunits="fraction"/>
        </IconStyle>
        <LabelStyle>
          <scale>0</scale>
        </LabelStyle>
      </Style>
      <Point>
        <coordinates>$lng,$lat,0</coordinates>
      </Point>
    </Placemark>
  </Document>
</kml>''';
  }

  static bool _isCenterHole(int x, int y, int w, int h) {
    final cx = w * 0.5;
    final cy = h * 0.34;
    final dx = (x - cx) / (w * 0.11);
    final dy = (y - cy) / (h * 0.11);
    return (dx * dx + dy * dy) <= 1;
  }
}
