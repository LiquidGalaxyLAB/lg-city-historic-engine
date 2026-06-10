Future<void> clearLogos() async {
  String blank = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document></Document>
</kml>''';
  await execute("echo '$_password' | sudo -S mkdir -p /var/www/html/kml");
  await execute("echo '$_password' | sudo -S chmod -R 777 /var/www/html/kml");
  // Limpiamos desde slave_2 hasta slave_{screens}
  for (var i = 2; i <= _screens; i++) {
    await execute(
      "echo '$_password' | sudo -S tee /var/www/html/kml/slave_$i.kml <<'EOF'\n$blank\nEOF > /dev/null",
    );
  }
}

Future<void> relaunch() async {
  if (_password == null || _username == null) return;

  await setRefresh();

  List<Future> ops = [];
  for (var i = _screens; i >= 1; i--) {
    final relaunchCommand =
    """RELAUNCH_CMD="\\
if [ -f /etc/init/lxdm.conf ]; then
  export SERVICE=lxdm
elif [ -f /etc/init/lightdm.conf ]; then
  export SERVICE=lightdm
else
  exit 1
fi
if  [[ \\\$(service \\\$SERVICE status) =~ 'stop' ]]; then
  echo $_password | sudo -S service \\\${SERVICE} start
else
  echo $_password | sudo -S service \\\${SERVICE} restart
fi
" && sshpass -p $_password ssh -x -t lg@lg$i "\$RELAUNCH_CMD\"""";

    if (i == 1) {
      ops.add(execute('"/home/$_username/bin/lg-relaunch" > /home/$_username/log.txt'));
    }
    ops.add(execute(relaunchCommand));
  }
  await Future.wait(ops);
}

Future<void> shutdown() async {
  if (_password == null) return;
  for (var i = _screens; i >= 1; i--) {
    await execute(
      'sshpass -p $_password ssh -t lg$i "echo $_password | sudo -S poweroff"',
    );
  }
}

Future<void> reboot() async {
  if (_password == null) return;
  for (var i = _screens; i >= 1; i--) {
    await execute(
      'sshpass -p $_password ssh -t lg$i "echo $_password | sudo -S reboot"',
    );
  }
}

Future<void> setRefresh() async {
  if (_password == null || _host == null) return;
  try {
    List<Future> ops = [];
    for (var i = 1; i <= _screens; i++) {
      final paths = [
        '/home/lg/earth/kml/myplaces.kml',
        '/home/lg/earth/kml/slave/myplaces.kml',
        '/home/lg/.googleearth/instance-1/myplaces.kml',
      ];

      // Para el master usamos localhost, para esclavos la IP del master
      final String effectiveHost = (i == 1) ? 'localhost' : _host!;
      final globalUrl = 'http://$effectiveHost:81/kmls.txt';
      final slaveUrl = 'http://$effectiveHost:81/kml/slave_$i.kml';

      for (var path in paths) {
        String script = """
            if [ -f $path ]; then
              # Limpiar entradas antiguas para evitar duplicados
              sed -i '/kmls.txt/d' $path
              sed -i '/slave_.*.kml/d' $path
              # Insertar antes del cierre de Document
              sed -i '/<\\/Document>/i <NetworkLink><name>global_$i</name><Link><href>$globalUrl</href><refreshMode>onInterval</refreshMode><refreshInterval>2</refreshInterval></Link></NetworkLink>' $path
              sed -i '/<\\/Document>/i <NetworkLink><name>slave_$i</name><Link><href>$slaveUrl</href><refreshMode>onInterval</refreshMode><refreshInterval>2</refreshInterval></Link></NetworkLink>' $path
            fi
          """;

        String execCmd = "echo '$_password' | sudo -S bash -c \"$script\"";
        if (i == 1) {
          ops.add(execute(execCmd));
        } else {
          ops.add(execute('sshpass -p $_password ssh -t lg$i "$execCmd"'));
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
  if (_password == null) return;
  try {
    for (var i = 1; i <= _screens; i++) {
      String path = i == 1
          ? '~/earth/kml/myplaces.kml'
          : '~/earth/kml/slave/myplaces.kml';
      // Eliminamos las etiquetas de refresco
      final cmd =
          "echo '$_password' | sudo -S sed -i 's@<refreshMode>onInterval</refreshMode><refreshInterval>2</refreshInterval>@@g' $path";
      await execute('sshpass -p $_password ssh -t lg$i "$cmd"');
    }
  } catch (e) {
    debugPrint('LGService: Error al resetear refresco: $e');
  }
}
}