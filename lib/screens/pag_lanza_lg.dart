// ─────────────────────────────────────────────────────────────────────────────
// PEGA ESTOS DOS MÉTODOS AL FINAL DE LA CLASE LGService, justo antes del } final
// ─────────────────────────────────────────────────────────────────────────────

Future<void> sendBalloon(POI poi) async {
  final int slaveNo = _conn.screens == 5 ? 4 : 2;

  // Construye las líneas opcionales de época y fechas
  final String epocaLine = (poi.epoca != null && poi.epoca!.isNotEmpty)
      ? '<p style="font-size:12px;color:#A0856A;margin:0 0 12px 0;text-transform:uppercase;letter-spacing:1px;">${poi.epoca}</p>'
      : '';

  final String fechaLine = (poi.fechaInici != null && poi.fechaInici!.isNotEmpty)
      ? '<p style="font-size:12px;color:#A0856A;margin:0 0 16px 0;">'
      '${poi.fechaInici}'
      '${poi.fechaFi != null && poi.fechaFi != poi.fechaInici ? " – ${poi.fechaFi}" : ""}'
      '</p>'
      : '';

  final String descLine = (poi.description != null && poi.description!.isNotEmpty)
      ? '<p style="font-size:14px;line-height:1.75;color:#E0D8CC;margin:0;">${poi.description}</p>'
      : '';

  
  final String kml = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document>
    <Placemark>   
      <name>${poi.name}</name>
      <description><![CDATA[
        <html>
        <body style="margin:0;padding:0;background:#1C1C1E;font-family:Georgia,serif;color:#F5F1E9;width:100%;height:100%;">
          <div style="padding:28px 28px 24px 28px;">
            <h2 style="font-size:24px;font-weight:400;margin:0 0 10px 0;color:#F5F1E9;line-height:1.3;">
              ${poi.name}
            </h2>
            <div style="width:40px;height:2px;background:#C8A96E;margin-bottom:14px;"></div>
            $epocaLine
            $fechaLine
            $descLine
          </div>
        </body>
        </html>
      ]]></description>
      <Point>
        <coordinates>${poi.lng ?? 0.6268},${poi.lat ?? 41.6147},0</coordinates>
      </Point>
    </Placemark>
  </Document>
</kml>''';

  await _conn.execute(
      "cat <<'KMLEOF' > /var/www/html/kml/slave_$slaveNo.kml\n$kml\nKMLEOF");
}

Future<void> clearBalloon() async {
  final int slaveNo = _conn.screens == 5 ? 4 : 2;
  const String blank = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2"><Document></Document></kml>''';
  await _conn.execute(
      "cat <<'KMLEOF' > /var/www/html/kml/slave_$slaveNo.kml\n$blank\nKMLEOF");
}