import 'package:flutter/foundation.dart';
import '../models/connection_state.dart';
import '../models/poi_model.dart';
import '../kmls/logos_kml.dart';
import '../main.dart';

class LGService {
  final LGConnectionState _conn = LGConnectionState();
  bool _isOrbiting = false;

  /// Envía un KML al Master
  Future<void> sendKML(String kml) async {
    await _conn.execute("cat <<'EOF' > /var/www/html/kmls.kml\n$kml\nEOF");
  }

  /// Mueve la cámara al punto de interés
  Future<void> flyToPOI(POI poi) async {
    final double lat = poi.lat ?? 41.6147;
    final double lng = poi.lng ?? 0.6268;
    final double range = poi.range ?? 1000;
    final double tilt = poi.tilt ?? 45;
    final double heading = poi.heading ?? 0;
    
    final String command =
        'echo "flytoview=<LookAt><longitude>$lng</longitude><latitude>$lat</latitude><range>$range</range><tilt>$tilt</tilt><heading>$heading</heading><altitudeMode>relativeToGround</altitudeMode></LookAt>" > /tmp/query.txt';
    await _conn.execute(command);
  }

  /// Inicia una órbita alrededor del punto
  Future<void> startOrbitPOI(POI poi) async {
    _isOrbiting = true;
    double heading = poi.heading ?? 0;
    while (_isOrbiting) {
      heading = (heading + 10) % 360;
      final double lat = poi.lat ?? 41.6147;
      final double lng = poi.lng ?? 0.6268;
      final double range = poi.range ?? 1000;
      final double tilt = poi.tilt ?? 45;

      final String command =
          'echo "flytoview=<LookAt><longitude>$lng</longitude><latitude>$lat</latitude><range>$range</range><tilt>$tilt</tilt><heading>$heading</heading><altitudeMode>relativeToGround</altitudeMode></LookAt>" > /tmp/query.txt';
      await _conn.execute(command);
      await Future.delayed(const Duration(milliseconds: 1000));
    }
  }

  void stopOrbit() {
    _isOrbiting = false;
  }

  /// Limpia los KMLs principales
  Future<void> clearKMLs() async {
    const String blank = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document></Document>
</kml>''';
    await _conn.execute("cat <<'EOF' > /var/www/html/kmls.kml\n$blank\nEOF");
    await _conn.execute("echo '' > /var/www/html/kmls.txt");
  }

  /// Limpia los logos en las pantallas esclavas
  Future<void> clearLogos() async {
    const String blank = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document></Document>
</kml>''';
    final sudo = _conn.sudoPassword;
    final screens = _conn.screens;

    await _conn.execute("echo '$sudo' | sudo -S mkdir -p /var/www/html/kml");
    await _conn.execute("echo '$sudo' | sudo -S chmod -R 777 /var/www/html/kml");

    for (var i = 1; i <= screens; i++) {
      await _conn.execute("cat <<'EOF' > /var/www/html/kml/slave_$i.kml\n$blank\nEOF");
    }
  }

  /// Muestra los logos corporativos
  Future<void> showLogos() async {
    await _conn.sendLogoKML(LogoOverlayManager.generate());
  }

  /// Relanza el sistema Liquid Galaxy
  Future<void> relaunch() async {
    final password = _conn.password;
    final sudo = _conn.sudoPassword;
    final user = _conn.username;
    final screens = _conn.screens;
    if (password == null || user == null) return;
    
    for (var i = screens; i >= 1; i--) {
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
        await _conn.execute('"/home/$user/bin/lg-relaunch" > /home/$user/log.txt 2>&1');
      }
      await _conn.execute(relaunchCommand);
    }
  }

  /// Apaga todas las máquinas del sistema
  Future<void> shutdown() async {
    final password = _conn.password;
    final sudo = _conn.sudoPassword;
    final user = _conn.username;
    final screens = _conn.screens;
    if (password == null) return;

    for (var i = screens; i >= 1; i--) {
      final String hostname = i == 1 ? 'localhost' : 'lg$i';
      await _conn.execute(
          'sshpass -p $password ssh -o StrictHostKeyChecking=no -t $user@$hostname "echo $sudo | sudo -S poweroff"');
    }
  }

  /// Reinicia todas las máquinas del sistema
  Future<void> reboot() async {
    final password = _conn.password;
    final sudo = _conn.sudoPassword;
    final user = _conn.username;
    final screens = _conn.screens;
    if (password == null) return;

    for (var i = screens; i >= 1; i--) {
      final String hostname = i == 1 ? 'localhost' : 'lg$i';
      await _conn.execute(
          'sshpass -p $password ssh -o StrictHostKeyChecking=no -t $user@$hostname "echo $sudo | sudo -S reboot"');
    }
  }

  /// Muestra el globo de información en la pantalla derecha en el idioma actual
  Future<void> sendBalloon(POI poi) async {
    final int slaveNo = _conn.screens == 5 ? 4 : 2;
    final String lang = languageNotifier.value;
    final String desc = poi.getDescription(lang);

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
            <p style="font-size:14px;line-height:1.75;color:#E0D8CC;margin:0;">$desc</p>
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

    await _conn.execute("cat <<'KMLEOF' > /var/www/html/kml/slave_$slaveNo.kml\n$kml\nKMLEOF");
  }

  Future<void> clearBalloon() async {
    final int slaveNo = _conn.screens == 5 ? 4 : 2;
    const String blank = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2"><Document></Document></kml>''';
    await _conn.execute("cat <<'KMLEOF' > /var/www/html/kml/slave_$slaveNo.kml\n$blank\nKMLEOF");
  }
}
