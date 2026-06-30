import 'package:flutter/services.dart';
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

<<<<<<< HEAD
=======
  /// Mueve la cámara al punto de interés
>>>>>>> parent of 8c98f4c (mal1)
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

<<<<<<< HEAD
=======
  /// Inicia una órbita alrededor del punto
>>>>>>> parent of 8c98f4c (mal1)
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

<<<<<<< HEAD
=======
  /// Limpia los KMLs principales
>>>>>>> parent of 8c98f4c (mal1)
  Future<void> clearKMLs() async {
    const String blank = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document></Document>
</kml>''';
    await _conn.execute("cat <<'EOF' > /var/www/html/kmls.kml\n$blank\nEOF");
    await _conn.execute("echo '' > /var/www/html/kmls.txt");
  }

<<<<<<< HEAD
=======
  /// Limpia los logos en las pantallas esclavas
>>>>>>> parent of 8c98f4c (mal1)
  Future<void> clearLogos() async {
    const String blank = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document></Document>
</kml>''';
    final sudo = _conn.sudoPassword;
    final screens = _conn.screens;
<<<<<<< HEAD
=======

    await _conn.execute("echo '$sudo' | sudo -S mkdir -p /var/www/html/kml");
    await _conn.execute("echo '$sudo' | sudo -S chmod -R 777 /var/www/html/kml");

>>>>>>> parent of 8c98f4c (mal1)
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
<<<<<<< HEAD
    for (int i = 1; i <= _conn.screens; i++) {
      final String hostname = i == 1 ? 'localhost' : 'lg$i';
      final cmd = "sshpass -p '${_conn.password}' ssh -o StrictHostKeyChecking=no -x -t ${_conn.username}@$hostname \"export DISPLAY=:0; pkill -9 googleearth; sleep 2; /usr/bin/googleearth > /dev/null 2>&1 &\"";
      await _conn.execute(cmd);
=======
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
>>>>>>> parent of 8c98f4c (mal1)
    }
  }

  /// Apaga todas las máquinas del sistema
  Future<void> shutdown() async {
    for (int i = _conn.screens; i >= 1; i--) {
      final String hostname = i == 1 ? 'localhost' : 'lg$i';
      await _conn.execute("sshpass -p '${_conn.password}' ssh -o StrictHostKeyChecking=no -t ${_conn.username}@$hostname \"echo ${_conn.sudoPassword} | sudo -S poweroff\"");
    }
  }

  /// Reinicia todas las máquinas del sistema
  Future<void> reboot() async {
    for (int i = _conn.screens; i >= 1; i--) {
      final String hostname = i == 1 ? 'localhost' : 'lg$i';
      await _conn.execute("sshpass -p '${_conn.password}' ssh -o StrictHostKeyChecking=no -t ${_conn.username}@$hostname \"echo ${_conn.sudoPassword} | sudo -S reboot\"");
    }
  }

<<<<<<< HEAD
  Future<void> sendBalloon(POI poi) async {
=======
<<<<<<< HEAD
  /// Muestra el globo de información en la pantalla derecha en el idioma actual
  Future<void> sendBalloon(POI poi) async {
    final int slaveNo = _conn.screens == 5 ? 4 : 2;
    final String lang = languageNotifier.value;
    final String desc = poi.getDescription(lang);
=======
  Future<void> setRefresh() async {
    final password = _conn.password;
    final sudo = _conn.sudoPassword;
    final host = _conn.ip;
    final screens = _conn.screens;
    final user = _conn.username;

    if (password == null || host.isEmpty) return;
    try {
      List<Future> ops = [];
      for (var i = 1; i <= screens; i++) {
        final paths = [
          '/home/$user/earth/kml/myplaces.kml',
          '/home/$user/earth/kml/slave/myplaces.kml',
          '/home/$user/.googleearth/instance-1/myplaces.kml',
        ];

        final String effectiveHost = (i == 1) ? 'localhost' : host;
        final globalUrl = 'http://$effectiveHost:81/kmls.txt';
        final slaveUrl = 'http://$effectiveHost:81/kml/slave_$i.kml';

        for (var path in paths) {
          String script = """
            if [ -f $path ]; then
              sed -i '/kmls.txt/d' $path
              sed -i '/slave_.*.kml/d' $path
              sed -i '/<\\/Document>/i <NetworkLink><name>global_$i</name><Link><href>$globalUrl</href><refreshMode>onInterval</refreshMode><refreshInterval>2</refreshInterval></Link></NetworkLink>' $path
              sed -i '/<\\/Document>/i <NetworkLink><name>slave_$i</name><Link><href>$slaveUrl</href><refreshMode>onInterval</refreshMode><refreshInterval>2</refreshInterval></Link></NetworkLink>' $path
            fi
          """;

          String execCmd = "echo '$sudo' | sudo -S bash -c \"$script\"";
          if (i == 1) {
            ops.add(_conn.execute(execCmd));
          } else {
            ops.add(_conn.execute(
                'sshpass -p $password ssh -o StrictHostKeyChecking=no -t $user@lg$i "$execCmd"'));
          }
        }
      }
      await Future.wait(ops);
      debugPrint('LGService: Refresco configurado e inyectado correctamente.');
    } catch (e) {
      debugPrint('LGService: Error crítico en setRefresh: $e');
    }
  }

  Future<void> resetRefresh() async {
    final password = _conn.password;
    final sudo = _conn.sudoPassword;
    final user = _conn.username;
    final screens = _conn.screens;
    if (password == null) return;

    try {
      for (var i = 1; i <= screens; i++) {
        String path = i == 1
            ? '~/earth/kml/myplaces.kml'
            : '~/earth/kml/slave/myplaces.kml';
        final cmd =
            "echo '$sudo' | sudo -S sed -i '/kmls.txt/d; /slave_.*.kml/d' $path";
        if (i == 1) {
          await _conn.execute(cmd);
        } else {
          await _conn.execute(
              'sshpass -p $password ssh -o StrictHostKeyChecking=no -t $user@lg$i "$cmd"');
        }
      }
    } catch (e) {
      debugPrint('LGService: Error al resetear refresco: $e');
    }
  }
  Future<void> sendBalloon(POI poi, String description) async {
>>>>>>> parent of 8c98f4c (mal1)
    final int slaveNo = _conn.screens == 5 ? 4 : 2;
>>>>>>> parent of fdca477 (17/06/2026)

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
<<<<<<< HEAD
        <body style="margin:0;padding:0;background:#1C1C1E;font-family:Georgia,serif;color:#F5F1E9;width:100%;height:100%;">
          <div style="padding:28px 28px 24px 28px;">
            <h2 style="font-size:24px;font-weight:400;margin:0 0 10px 0;color:#F5F1E9;line-height:1.3;">
              ${poi.name}
            </h2>
            <div style="width:40px;height:2px;background:#C8A96E;margin-bottom:14px;"></div>
            $epocaLine
            $fechaLine
            $descLine
=======
<<<<<<< HEAD
        <body style="margin:0;padding:0;background:#1C1C1E;font-family:Georgia,serif;color:#F5F1E9;width:100%;height:100%;">
          <div style="padding:28px 28px 24px 28px;">
            <h2 style="font-size:24px;font-weight:400;margin:0 0 10px 0;color:#F5F1E9;line-height:1.3;">
              ${poi.name}
            </h2>
            <div style="width:40px;height:2px;background:#C8A96E;margin-bottom:14px;"></div>
            <p style="font-size:14px;line-height:1.75;color:#E0D8CC;margin:0;">$desc</p>
=======
        <body style="margin:0;padding:0;background:#1C1C1E;font-family:Georgia,serif;color:#F5F1E9;">
          <div style="padding:24px;">
            <h2 style="font-size:22px;font-weight:400;margin:0 0 8px 0;color:#F5F1E9;">
              ${poi.name}
            </h2>
            <div style="width:40px;height:2px;background:#C8A96E;margin-bottom:16px;"></div>
            <p style="font-size:13px;color:#C8A96E;margin:0 0 16px 0;">
              ${poi.location}
            </p>
            <p style="font-size:14px;line-height:1.7;color:#E0D8CC;margin:0;">
              $description
            </p>
>>>>>>> parent of fdca477 (17/06/2026)
>>>>>>> parent of 8c98f4c (mal1)
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

<<<<<<< HEAD
    await _conn.execute("cat <<'KMLEOF' > /var/www/html/kml/slave_$slaveNo.kml\n$kml\nKMLEOF");
=======
    await _conn.execute(
        "cat <<'KMLEOF' > /var/www/html/kml/slave_$slaveNo.kml\n$kml\nKMLEOF");
>>>>>>> parent of fdca477 (17/06/2026)
  }

  Future<void> clearBalloon() async {
    final int slaveNo = _conn.screens == 5 ? 4 : 2;
    const String blank = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2"><Document></Document></kml>''';
    await _conn.execute("cat <<'KMLEOF' > /var/www/html/kml/slave_$slaveNo.kml\n$blank\nKMLEOF");
  }
}
