import 'dart:async';
import '../models/connection_state.dart';
import '../models/poi_model.dart';
import '../kmls/logos_kml.dart';

class LGService {
  final LGConnectionState _conn = LGConnectionState();
  bool _isOrbiting = false;

  Future<void> sendKML(String kml) async {
    await _conn.execute("cat <<'EOF' > /var/www/html/kmls.kml\n$kml\nEOF");
  }

  /// Mueve la cámara sin borrar el logo ni otros KMLs.
  Future<void> flyToPOI(POI poi) async {
    final lat = poi.lat ?? 41.6147;
    final lng = poi.lng ?? 0.6268;
    final range = poi.range ?? 1000.0;
    final tilt = poi.tilt ?? 45.0;
    final heading = poi.heading ?? 0.0;
    final altitudeMode = poi.altitudeMode ?? 'relativeToGround';

    final String command =
        'echo "flytoview=<LookAt><longitude>$lng</longitude><latitude>$lat</latitude><range>$range</range><tilt>$tilt</tilt><heading>$heading</heading><altitudeMode>$altitudeMode</altitudeMode></LookAt>" > /tmp/query.txt';
    await _conn.execute(command);
  }

  Future<void> startOrbitPOI(POI poi) async {
    _isOrbiting = true;
    double heading = poi.heading ?? 0;
    final lat = poi.lat ?? 41.6147;
    final lng = poi.lng ?? 0.6268;
    final range = poi.range ?? 1000.0;
    final tilt = poi.tilt ?? 45.0;
    final altitudeMode = poi.altitudeMode ?? 'relativeToGround';

    while (_isOrbiting) {
      heading = (heading + 10) % 360;
      final String command =
          'echo "flytoview=<LookAt><longitude>$lng</longitude><latitude>$lat</latitude><range>$range</range><tilt>$tilt</tilt><heading>$heading</heading><altitudeMode>$altitudeMode</altitudeMode></LookAt>" > /tmp/query.txt';
      await _conn.execute(command);
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  void stopOrbit() {
    _isOrbiting = false;
  }

  Future<void> clearKMLs() async {
    const String blank = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document></Document>
</kml>''';
    await _conn.execute("cat <<'EOF' > /var/www/html/kmls.kml\n$blank\nEOF");
  }

  /// Limpia todas las pantallas esclavas (incluyendo logos y balloons).
  Future<void> clearLogos() async {
    const String blank = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document></Document>
</kml>''';
    final sudo = _conn.sudoPassword;
    final screens = _conn.screens;
    for (var i = 1; i <= screens; i++) {
      await _conn.execute(
          "echo '$sudo' | sudo -S sh -c \"cat <<'EOF' > /var/www/html/kml/slave_$i.kml\n$blank\nEOF\"");
    }
  }

  /// Muestra los logos únicamente en la pantalla izquierda (LG4 / slave_4).
  Future<void> showLogos() async {
    await _conn.sendLogoKML(LogoOverlayManager.generate());
  }

  Future<void> relaunch() async {
    final password = _conn.password;
    final sudo = _conn.sudoPassword;
    final user = _conn.username;
    final screens = _conn.screens;

    for (int i = 1; i <= screens; i++) {
      final String hostname = i == 1 ? 'localhost' : 'lg$i';
      final relaunchCommand = """RELAUNCH_CMD="\\
if [ -f /etc/init/lxdm.conf ]; then
  export SERVICE=lxdm
elif [ -f /etc/init/lightdm.conf ]; then
  export SERVICE=lightdm
else
  exit 1
fi
if  [[ \\\$(service \\\$SERVICE status) =~ 'stop' ]]; then
  echo $sudo | sudo -S service \\\${SERVICE} start
else
  echo $sudo | sudo -S service \\\${SERVICE} restart
fi
" && sshpass -p $password ssh -o StrictHostKeyChecking=no -x -t $user@$hostname "\$RELAUNCH_CMD\"""";

      if (i == 1) {
        await _conn.execute(
            '"/home/$user/bin/lg-relaunch" > /home/$user/log.txt 2>&1');
      }
      await _conn.execute(relaunchCommand);
    }
  }

  Future<void> shutdown() async {
    final password = _conn.password;
    final user = _conn.username;
    final sudo = _conn.sudoPassword;
    final screens = _conn.screens;

    for (var i = screens; i >= 1; i--) {
      final String hostname = i == 1 ? 'localhost' : 'lg$i';
      await _conn.execute(
          'sshpass -p $password ssh -o StrictHostKeyChecking=no -t $user@$hostname "echo $sudo | sudo -S poweroff"');
    }
  }

  Future<void> reboot() async {
    final password = _conn.password;
    final user = _conn.username;
    final sudo = _conn.sudoPassword;
    final screens = _conn.screens;

    for (var i = screens; i >= 1; i--) {
      final String hostname = i == 1 ? 'localhost' : 'lg$i';
      await _conn.execute(
          'sshpass -p $password ssh -o StrictHostKeyChecking=no -t $user@$hostname "echo $sudo | sudo -S reboot"');
    }
  }

  /// Envía el balloon con la descripción únicamente a la pantalla derecha (LG3 / slave_3).
  Future<void> sendBalloon(POI poi) async {
    const int slaveNo = 3;

    final String localizedDescription = poi.getDescription('es');

    final String epocaLine = (poi.epoca != null && poi.epoca!.isNotEmpty)
        ? '<p style="font-size:18px;color:#C8A96E;margin:0 0 10px 0;text-transform:uppercase;font-weight:bold;">${poi.epoca}</p>'
        : '';

    final String fechaLine = (poi.fechaInici != null &&
            poi.fechaInici!.isNotEmpty)
        ? '<p style="font-size:16px;color:#A0856A;margin:0 0 20px 0;">'
            '${poi.fechaInici}'
            '${poi.fechaFi != null && poi.fechaFi != poi.fechaInici ? " – ${poi.fechaFi}" : ""}'
            '</p>'
        : '';

    final String descLine = localizedDescription.isNotEmpty
        ? '<p style="font-size:24px;line-height:1.6;color:#F5F1E9;margin:0;text-align:justify;">$localizedDescription</p>'
        : '';

    final String kml = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2">
  <Document>
    <Placemark>
      <name>${poi.name}</name>
      <gx:balloonVisibility>1</gx:balloonVisibility>
      <Style>
        <BalloonStyle>
          <text><![CDATA[
        <html>
        <body style="margin:0;padding:0;background-color:#1C1C1E;font-family:Georgia,serif;color:#F5F1E9;width:700px;min-height:500px;overflow-y:auto;">
          <div style="padding:45px;">
            <h1 style="font-size:40px;font-weight:bold;margin:0 0 18px 0;color:#FFFFFF;border-bottom:2px solid #C8A96E;padding-bottom:12px;">
              ${poi.name}
            </h1>
            $epocaLine
            $fechaLine
            $descLine
          </div>
        </body>
        </html>
          ]]></text>
        </BalloonStyle>
      </Style>
      <Point>
        <coordinates>${poi.lng ?? 0.6268},${poi.lat ?? 41.6147},0</coordinates>
      </Point>
    </Placemark>
  </Document>
</kml>''';

    await _conn.execute(
        "cat <<'KMLEOF' > /var/www/html/kml/slave_$slaveNo.kml\n$kml\nKMLEOF");
  }

  /// Limpia únicamente la pantalla derecha (LG3 / slave_3).
  Future<void> clearBalloon() async {
    const int slaveNo = 3;
    const String blank = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2"><Document></Document></kml>''';
    await _conn.execute(
        "cat <<'KMLEOF' > /var/www/html/kml/slave_$slaveNo.kml\n$blank\nKMLEOF");
  }
}
