import 'package:flutter/foundation.dart';
import '../models/connection_state.dart';
import '../models/lugares.dart';
import '../models/poi_model.dart';
import '../kmls/logos_kml.dart';

class LGService {
  final LGConnectionState _conn = LGConnectionState();
  bool _isOrbiting = false;

  Future<void> sendKML(String kml) async {
    await _conn.execute("cat <<'EOF' > /var/www/html/kmls.kml\n$kml\nEOF");
  }

  Future<void> flyTo(Lloc lloc) async {
    final String command =
        'echo "flytoview=<LookAt><longitude>${lloc.longitud}</longitude><latitude>${lloc.latitud}</latitude><range>${lloc.range}</range><tilt>${lloc.tilt}</tilt><heading>${lloc.heading}</heading><altitudeMode>${lloc.altitudeMode}</altitudeMode></LookAt>" > /tmp/query.txt';
    await _conn.execute(command);
  }

  Future<void> flyToPOI(POI poi) async {
    final String command =
        'echo "flytoview=<LookAt><longitude>${poi.lng ?? 0.6268}</longitude><latitude>${poi.lat ?? 41.6147}</latitude><range>${poi.range ?? 1000}</range><tilt>${poi.tilt ?? 45}</tilt><heading>${poi.heading ?? 0}</heading><altitudeMode>${poi.altitudeMode ?? 'relativeToGround'}</altitudeMode></LookAt>" > /tmp/query.txt';
    await _conn.execute(command);
  }

  Future<void> buildOrbit(Lloc lloc) async {
    _isOrbiting = true;
    for (int i = 0; _isOrbiting; i += 10) {
      final double heading = (lloc.heading + i) % 360;
      final String command =
          'echo "flytoview=<LookAt><longitude>${lloc.longitud}</longitude><latitude>${lloc.latitud}</latitude><range>${lloc.range}</range><tilt>${lloc.tilt}</tilt><heading>$heading</heading><altitudeMode>${lloc.altitudeMode}</altitudeMode></LookAt>" > /tmp/query.txt';
      await _conn.execute(command);
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  Future<void> startOrbitPOI(POI poi) async {
    _isOrbiting = true;
    double heading = poi.heading ?? 0;
    while (_isOrbiting) {
      heading = (heading + 10) % 360;
      final String command =
          'echo "flytoview=<LookAt><longitude>${poi.lng ?? 0.6268}</longitude><latitude>${poi.lat ?? 41.6147}</latitude><range>${poi.range ?? 1000}</range><tilt>${poi.tilt ?? 45}</tilt><heading>$heading</heading><altitudeMode>${poi.altitudeMode ?? 'relativeToGround'}</altitudeMode></LookAt>" > /tmp/query.txt';
      await _conn.execute(command);
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  void stopOrbit() {
    _isOrbiting = false;
  }

  /// Limpia el KML principal enviando uno vacío.
  Future<void> clearKMLs() async {
    const String blank = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document></Document>
</kml>''';
    await _conn.execute("cat <<'EOF' > /var/www/html/kmls.kml\n$blank\nEOF");
  }

  /// Limpia los logos enviando un KML vacío a todos los slots de esclavos en el Master.
  Future<void> clearLogos() async {
    const String blank = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document></Document>
</kml>''';
    final sudo = _conn.sudoPassword;
    final screens = _conn.screens;

    await _conn.execute("echo '$sudo' | sudo -S mkdir -p /var/www/html/kml");
    await _conn
        .execute("echo '$sudo' | sudo -S chmod -R 777 /var/www/html/kml");

    for (var i = 1; i <= screens; i++) {
      await _conn
          .execute("cat <<'EOF' > /var/www/html/kml/slave_$i.kml\n$blank\nEOF");
    }
  }

  Future<void> showLogos() async {
    await _conn.sendLogoKML(LogoOverlayManager.generate());
  }

  Future<void> relaunch() async {
    final password = _conn.password;
    final sudo = _conn.sudoPassword;
    final user = _conn.username;
    final screens = _conn.screens;

    if (password == null || user == null) return;

    await setRefresh();

    List<Future> ops = [];
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
        ops.add(_conn.execute(
            '"/home/$user/bin/lg-relaunch" > /home/$user/log.txt 2>&1'));
      }
      ops.add(_conn.execute(relaunchCommand));
    }
    await Future.wait(ops);
  }

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
}
