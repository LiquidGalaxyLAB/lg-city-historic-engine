/// Builds the KML used to show slices of ONE image across several
/// physical screens, positioned and sized exactly (smaller than the full
/// screen if desired, and anchored anywhere vertically), without ever
/// distorting the image. Because it's a ScreenOverlay, it's fixed in
/// screen space and never moves when the camera/globe moves.
class PanoramaOverlayManager {
  /// Places [imageUrl] at an exact position/size on the screen.
  /// All values are fractions (0.0 - 1.0) of the screen's own width/height.
  /// - [left]: distance from the screen's left edge to the image's left edge.
  /// - [bottom]: distance from the screen's bottom edge to the image's bottom edge.
  /// - [width] / [height]: size of the image slice on this screen.
  static String generatePositioned(
      String imageUrl, {
        required double left,
        required double bottom,
        required double width,
        required double height,
      }) {
    return '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2">
  <Document>
    <name>POI Panorama Slice</name>
    <ScreenOverlay>
      <name>POI Image Slice</name>
      <Icon>
        <href>$imageUrl</href>
      </Icon>
      <!-- Anchor the BOTTOM-LEFT of the image to a specific screen position -->
      <overlayXY x="0" y="0" xunits="fraction" yunits="fraction"/>
      <screenXY x="$left" y="$bottom" xunits="fraction" yunits="fraction"/>
      <rotationXY x="0" y="0" xunits="fraction" yunits="fraction"/>
      <size x="$width" y="$height" xunits="fraction" yunits="fraction"/>
    </ScreenOverlay>
  </Document>
</kml>''';
  }

  /// Places [imageUrl] filling the ENTIRE width of the screen, anchored to
  /// the bottom edge. Used for sites where the panorama slices were already
  /// pre-cut server-side to match each screen exactly (e.g. `<site>_L.png`,
  /// `<site>_C.png`, `<site>_R.png`), so no client-side slicing/positioning
  /// math is needed — just point each screen at its own slice.
  static String generateFullWidth(String imageUrl) {
    return '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2">
  <Document>
    <name>Site Panorama Slice</name>
    <ScreenOverlay>
      <name>Site Image Slice</name>
      <Icon>
        <href>$imageUrl</href>
      </Icon>
      <overlayXY x="0" y="0" xunits="fraction" yunits="fraction"/>
      <screenXY x="0.0" y="0" xunits="fraction" yunits="fraction"/>
      <rotationXY x="0" y="0" xunits="fraction" yunits="fraction"/>
      <size x="1.0" y="0" xunits="fraction" yunits="fraction"/>
    </ScreenOverlay>
  </Document>
</kml>''';
  }

  /// Blank KML used to remove the panorama image from a screen.
  static String blank() {
    return '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2"><Document></Document></kml>''';
  }

  static String blankSlave(int slaveNo) {
    return '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
  <Document id="slave_$slaveNo"></Document>
</kml>''';
  }

  static String blankMaster() {
    return '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
  <Document id="master_1"></Document>
</kml>''';
  }
}