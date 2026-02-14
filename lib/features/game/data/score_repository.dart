import 'package:shared_preferences/shared_preferences.dart';

class ScoreRepository {
  static const String _highScoreKey = 'neon_pulse_high_score';

  Future<int> getHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_highScoreKey) ?? 0;
  }

  Future<void> saveHighScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    final currentHigh = prefs.getInt(_highScoreKey) ?? 0;
    if (score > currentHigh) {
      await prefs.setInt(_highScoreKey, score);
    }
  }
}
