import 'package:audioplayers/audioplayers.dart';

class SoundManager {
  static final AudioPlayer _player = AudioPlayer();

  // Define sound paths
  static const String clickSound = 'audio/click.mp3';
  static const String correctSound = 'audio/correct.mp3';
  static const String wrongSound = 'audio/wrong.mp3';
  static const String gameOverSound = 'audio/game_over.mp3';

  static Future<void> playClick() async {
    // await _player.play(AssetSource(clickSound), mode: PlayerMode.lowLatency);
  }

  static Future<void> playCorrect() async {
    // await _player.play(AssetSource(correctSound), mode: PlayerMode.lowLatency);
  }

  static Future<void> playWrong() async {
    // await _player.play(AssetSource(wrongSound), mode: PlayerMode.lowLatency);
  }

  static Future<void> playGameOver() async {
    // await _player.play(AssetSource(gameOverSound));
  }
  
  // Note: Sounds are commented out to prevent crashes if assets are missing.
  // User should add files to assets/audio/ and uncomment lines.
}
