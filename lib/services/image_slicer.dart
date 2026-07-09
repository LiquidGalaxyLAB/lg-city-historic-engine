import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;

/// Loads an image once and lets you cut arbitrary horizontal pixel ranges
/// out of it, so several screens can each show a different slice of the
/// SAME single image (instead of the whole image repeated on each screen).
class ImageSlicer {
  static Future<ui.Image> loadImage(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final ui.Codec codec =
        await ui.instantiateImageCodec(data.buffer.asUint8List());
    final ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image;
  }

  /// Crops the horizontal strip [x, x+width) x [0, image.height) out of
  /// [image] and returns it encoded as PNG bytes.
  static Future<Uint8List> cropHorizontal(
    ui.Image image,
    int x,
    int width,
  ) async {
    final int height = image.height;
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final ui.Canvas canvas = ui.Canvas(recorder);
    final ui.Rect src =
        ui.Rect.fromLTWH(x.toDouble(), 0, width.toDouble(), height.toDouble());
    final ui.Rect dst = ui.Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble());
    canvas.drawImageRect(image, src, dst, ui.Paint());
    final ui.Picture picture = recorder.endRecording();
    final ui.Image cropped = await picture.toImage(width, height);
    final ByteData? pngData =
        await cropped.toByteData(format: ui.ImageByteFormat.png);
    return pngData!.buffer.asUint8List();
  }
}
