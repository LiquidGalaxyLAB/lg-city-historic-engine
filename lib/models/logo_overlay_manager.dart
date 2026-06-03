import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';

class LogoOverlayManager {
  final SSHClient client;

  LogoOverlayManager(this.client);

  /// Generates the KML for the ScreenOverlay.
  /// Points to the local LG web server.
  static String _buildLogoKml(String imageUrl) {
    return '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2">
  <Document>
    <name>Logo Overlay</name>
    <ScreenOverlay>
      <name>Logo</name>
      <Icon>
        <href>$imageUrl</href>
      </Icon>
      <overlayXY x="0" y="1" xunits="fraction" yunits="fraction"/>
      <screenXY x="0.02" y="0.95" xunits="fraction" yunits="fraction"/>
      <rotationXY x="0" y="0" xunits="fraction" yunits="fraction"/>
      <size x="0.3" y="0.3" xunits="fraction" yunits="fraction"/>
    </ScreenOverlay>
  </Document>
</kml>''';
  }

  /// Uploads the logo and sends the KML to the left screen (slave_N).
  Future<void> showLogo({
    required int screens,
    required String masterIp,
    String assetPath = 'assets/images/logos.png',
  }) async {
    try {
      // 1. Upload logo image to the master node
      final sftp = await client.sftp();
      final ByteData data = await rootBundle.load(assetPath);
      final Uint8List bytes = data.buffer.asUint8List();

      final file = await sftp.open(
        '/var/www/html/logos.png',
        mode: SftpFileOpenMode.create | SftpFileOpenMode.write,
      );
      await file.writeBytes(bytes);
      await file.close();
      print('✅ Logo uploaded to LG web server');

      // 2. Ensure KML directory exists
      await client.run('mkdir -p /var/www/html/kml');

      // 3. Determine left screen (usually the highest slave number in typical 5-screen setups)
      int leftSlave = screens;

      // 4. Build KML using the internal LG address
      final kml = _buildLogoKml('http://lg1/logos.png');

      // 5. Write the KML to the specific slave file to trigger display
      final safeKml = kml.replaceAll("'", "'\\''");
      await client.run(
        "printf '%s' '$safeKml' > /var/www/html/kml/slave_$leftSlave.kml",
      );

      print('📺 Logo KML sent to slave_$leftSlave');
    } catch (e) {
      print('❌ Error showing logo: $e');
    }
  }

  /// Clears the logo from the screen.
  Future<void> removeLogo(int screens) async {
    try {
      int leftSlave = screens;
      await client.run("printf '' > /var/www/html/kml/slave_$leftSlave.kml");
      print('🧹 Logo removed');
    } catch (e) {
      print('Error removing logo: $e');
    }
  }
}
