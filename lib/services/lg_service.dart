import 'package:flutter/foundation.dart';
import '../models/connection_state.dart';
import '../kmls/logos_kml.dart';

class LGService {
  final LGConnectionState _conn = LGConnectionState();

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

    // Aseguramos directorios en el Master (donde corre el servidor web Apache)
    await _conn.execute("echo '$sudo' | sudo -S mkdir -p /var/www/html/kml");
    await _conn
        .execute("echo '$sudo' | sudo -S chmod -R 777 /var/www/html/kml");

    // Escribimos KMLs vacíos para cada pantalla en el Master
    for (var i = 1; i <= screens; i++) {
      await _conn
          .execute("cat <<'EOF' > /var/www/html/kml/slave_$i.kml\n$blank\nEOF");
    }
  }

  /// Muestra los logos enviando el KML de LogoOverlayManager.
  Future<void> showLogos() async {
    await _conn.sendLogoKML(LogoOverlayManager.generate());
  }

  /// Ejecuta el script de relanzamiento en el Master y reinicia el entorno en esclavos.
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

  /// Apaga todas las máquinas del sistema.
  Future<void> shutdown() async {
    final password = _conn.password;
    final sudo = _conn.sudoPassword;
    final user = _conn.username;
    final screens = _conn.screens;
    if (password == null) return;

    for (var i = screens; i >= 1; i--) {
      final String hostname = i == 1 ? 'localhost' : 'lg$i';
      await _conn.execute(
        'sshpass -p $password ssh -o StrictHostKeyChecking=no -t $user@$hostname "echo $sudo | sudo -S poweroff"',
      );
    }
  }

  /// Reinicia todas las máquinas del sistema.
  Future<void> reboot() async {
    final password = _conn.password;
    final sudo = _conn.sudoPassword;
    final user = _conn.username;
    final screens = _conn.screens;
    if (password == null) return;

    for (var i = screens; i >= 1; i--) {
      final String hostname = i == 1 ? 'localhost' : 'lg$i';
      await _conn.execute(
        'sshpass -p $password ssh -o StrictHostKeyChecking=no -t $user@$hostname "echo $sudo | sudo -S reboot"',
      );
    }
  }

  /// Configura el refresco automático de KMLs en todas las pantallas.
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

  /// Elimina la configuración de refresco automático.
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
