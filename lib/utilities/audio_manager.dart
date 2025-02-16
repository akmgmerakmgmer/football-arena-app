import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  final AudioPlayer buzzerSound = AudioPlayer();
  final AudioPlayer correctSound = AudioPlayer();
  final AudioPlayer countDownSound = AudioPlayer();
  Future<void> preloadAudios() async {
    await buzzerSound.setSource(AssetSource('audio/buzzer.mp3'));
    await correctSound.setSource(AssetSource('audio/correct.mp3'));
    await countDownSound.setSource(AssetSource('audio/countdown.mp3'));
  }

  void stopAll() {
    buzzerSound.stop();
    correctSound.stop();
    countDownSound.stop();
  }
}
