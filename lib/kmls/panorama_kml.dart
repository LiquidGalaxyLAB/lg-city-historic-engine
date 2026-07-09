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

  /// Blank KML used to remove the panorama image from a screen.
  static String blank() {
    return '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2"><Document></Document></kml>''';
  }
}
