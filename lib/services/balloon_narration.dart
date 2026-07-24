import '../main.dart';
import '../models/poi_model.dart';

/// Texto hablado = mismo contenido que el balloon del Liquid Galaxy.
class BalloonNarration {
  static String scriptFor(POI poi, {String? langCode}) {
    final lang = langCode ?? languageNotifier.value;
    final parts = <String>[poi.getName(lang)];

    final era = poi.getEra(lang);
    if (era.isNotEmpty) {
      parts.add(era);
    }

    if (poi.startDate != null && poi.startDate!.trim().isNotEmpty) {
      var dates = poi.startDate!.trim();
      if (poi.endDate != null &&
          poi.endDate!.trim().isNotEmpty &&
          poi.endDate != poi.startDate) {
        dates = '$dates – ${poi.endDate!.trim()}';
      }
      parts.add(dates);
    }

    final description = poi.getDescription(lang).trim();
    if (description.isNotEmpty) {
      parts.add(description);
    }

    return parts.join('. ');
  }

  static String ttsLanguageCode(String appLang) {
    switch (appLang) {
      case 'es':
        return 'es-ES';
      case 'ca':
        return 'ca-ES';
      case 'tr':
        return 'tr-TR';
      default:
        return 'en-US';
    }
  }
}
