import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'balloon_narration.dart';
import '../models/poi_model.dart';

class NarrationService {
  final FlutterTts _tts = FlutterTts();
  bool _isSpeaking = false;
  VoidCallback? _onSpeakingChanged;

  bool get isSpeaking => _isSpeaking;

  Future<void> init({VoidCallback? onSpeakingChanged}) async {
    _onSpeakingChanged = onSpeakingChanged;
    await _tts.awaitSpeakCompletion(true);
    _tts.setCompletionHandler(_handleComplete);
    _tts.setCancelHandler(_handleComplete);
    _tts.setErrorHandler((_) => _handleComplete());
  }

  void _handleComplete() {
    if (!_isSpeaking) return;
    _isSpeaking = false;
    _onSpeakingChanged?.call();
  }

  void _setSpeaking(bool value) {
    if (_isSpeaking == value) return;
    _isSpeaking = value;
    _onSpeakingChanged?.call();
  }

  Future<void> speakPoi(POI poi, String appLang) async {
    if (_isSpeaking) {
      await stop();
      return;
    }

    final text = BalloonNarration.scriptFor(poi, langCode: appLang);
    if (text.isEmpty) return;

    final ttsLang = BalloonNarration.ttsLanguageCode(appLang);
    await _tts.setLanguage(ttsLang);
    await _tts.setSpeechRate(0.48);
    await _tts.setPitch(1.0);

    _setSpeaking(true);
    final result = await _tts.speak(text);
    if (result != 1) {
      _setSpeaking(false);
    }
  }

  Future<void> stop() async {
    await _tts.stop();
    _setSpeaking(false);
  }

  Future<void> dispose() async {
    await stop();
    _onSpeakingChanged = null;
  }
}
