import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  final AudioPlayer buzzerSound = AudioPlayer();
  final AudioPlayer correctSound = AudioPlayer();
  final AudioPlayer countDownSound = AudioPlayer();
  final AudioPlayer mainGameSound = AudioPlayer();
  final AudioPlayer multiGameSound = AudioPlayer();
  Future<void> preloadAudios() async {
    await buzzerSound.setSource(AssetSource('audio/buzzer.mp3'));
    await correctSound.setSource(AssetSource('audio/correct.mp3'));
    await countDownSound.setSource(AssetSource('audio/countdown.mp3'));
    await mainGameSound.setSource(AssetSource('audio/main_game.mp3'));
    await multiGameSound.setSource(AssetSource('audio/multi_game.mp3'));
  }

  void stopAll() {
    buzzerSound.stop();
    correctSound.stop();
    countDownSound.stop();
    mainGameSound.stop();
    multiGameSound.stop();
  }

}
