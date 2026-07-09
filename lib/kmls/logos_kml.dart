class LogoOverlayManager {
  static String screenOverlayImage(
    String imageUrl,
    double top,
    double left,
    double width,
    double height,
  ) {
    final double y = 1.0 - top;
    return '''
    <ScreenOverlay>
      <name>Logo</name>
      <Icon>
        <href>$imageUrl</href>
      </Icon>
      <overlayXY x="0" y="1" xunits="fraction" yunits="fraction"/>
      <screenXY x="$left" y="$y" xunits="fraction" yunits="fraction"/>
      <rotationXY x="0" y="0" xunits="fraction" yunits="fraction"/>
      <!-- When using y=0, Google Earth automatically keeps the image's original aspect ratio based on the width (x) -->
      <size x="$width" y="0" xunits="fraction" yunits="fraction"/>
    </ScreenOverlay>
    ''';
  }

  static String generate({bool wrapDocument = true}) {
    const String baseUrl = "http://lg1:81/logos";
    // Position and size adjusted: moved down slightly, shifted to the right, and wider.
    final String content = screenOverlayImage(
      '$baseUrl/logos.png',
      0.02,
      0.01,
      0.71,
      0.33,
    );

    final String folder = '''
    <Folder>
      <name>Images</name>
      $content
    </Folder>''';

    if (!wrapDocument) {
      return folder;
    }

    return '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
  <Document>
    <name>Logos Panel</name>
    $folder
  </Document>
</kml>''';
  }
}
