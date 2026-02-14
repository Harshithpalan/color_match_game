import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neon_pulse/core/theme/app_colors.dart';
import 'package:neon_pulse/core/utils/sound_manager.dart';
import 'package:neon_pulse/features/game/data/score_repository.dart';

// --- State Class ---
class GameState {
  final int score;
  final int highScore;
  final int timeLeft;
  final bool isPlaying;
  final bool isGameOver;
  
  // The word displayed (e.g., "RED")
  final String targetWord; 
  // The color of the word text
  final Color targetColor;
  // The options shown on buttons
  final List<Color> options;

  const GameState({
    this.score = 0,
    this.highScore = 0,
    this.timeLeft = 30, // 30 seconds
    this.isPlaying = false,
    this.isGameOver = false,
    this.targetWord = '',
    this.targetColor = Colors.white,
    this.options = const [],
  });

  GameState copyWith({
    int? score,
    int? highScore,
    int? timeLeft,
    bool? isPlaying,
    bool? isGameOver,
    String? targetWord,
    Color? targetColor,
    List<Color>? options,
  }) {
    return GameState(
      score: score ?? this.score,
      highScore: highScore ?? this.highScore,
      timeLeft: timeLeft ?? this.timeLeft,
      isPlaying: isPlaying ?? this.isPlaying,
      isGameOver: isGameOver ?? this.isGameOver,
      targetWord: targetWord ?? this.targetWord,
      targetColor: targetColor ?? this.targetColor,
      options: options ?? this.options,
    );
  }
}

// --- Logic / Notifier ---
class GameNotifier extends StateNotifier<GameState> {
  final ScoreRepository _repository;
  Timer? _timer;
  final Random _random = Random();

  GameNotifier(this._repository) : super(const GameState()) {
    _loadHighScore();
  }

  Future<void> _loadHighScore() async {
    final highScore = await _repository.getHighScore();
    state = state.copyWith(highScore: highScore);
  }

  void startGame() {
    _loadHighScore(); // ensure fresh high score
    state = state.copyWith(
      score: 0,
      timeLeft: 30,
      isPlaying: true,
      isGameOver: false,
    );
    _nextRound();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timeLeft > 0) {
        state = state.copyWith(timeLeft: state.timeLeft - 1);
      } else {
        endGame();
      }
    });
  }

  void _nextRound() {
    // Logic: 
    // 1. Pick a random color for the TEXT (targetColor)
    // 2. Pick a random NAME for the TEXT (targetWord) - stroop effect
    // 3. Ensure we have 4 options, one MUST be the targetColor
    
    final List<Color> allColors = AppColors.gameColors;
    final List<String> colorNames = ['BLUE', 'PINK', 'PURPLE', 'GREEN', 'ORANGE'];
    
     // Pick correct answer color
    final Color correctColor = allColors[_random.nextInt(allColors.length)];
    
    // Pick displayed word (can be misleading)
    String displayedWord = colorNames[_random.nextInt(colorNames.length)];
    
    // Generate 4 options
    List<Color> options = List.from(allColors)..shuffle();
    options = options.take(4).toList();
    
    // Ensure the correct answer is in the options
    if (!options.contains(correctColor)) {
      options[0] = correctColor;
      options.shuffle();
    }

    state = state.copyWith(
      targetWord: displayedWord,
      targetColor: correctColor, // Player must match this!
      options: options,
    );
  }

  void checkAnswer(Color selectedColor) {
    if (!state.isPlaying) return;

    if (selectedColor == state.targetColor) {
      // Correct
      SoundManager.playCorrect();
      state = state.copyWith(score: state.score + 1);
      _nextRound();
    } else {
      // Wrong
      SoundManager.playWrong();
      final newTime = state.timeLeft - 3;
      if (newTime <= 0) {
         state = state.copyWith(timeLeft: 0);
         endGame();
      } else {
        state = state.copyWith(timeLeft: newTime);
        HapticFeedback.heavyImpact(); // Add strong feedback on error
         _nextRound(); 
      }
    }
  }

  void endGame() {
    _timer?.cancel();
    SoundManager.playGameOver();
    if (state.score > state.highScore) {
      _repository.saveHighScore(state.score);
      state = state.copyWith(highScore: state.score);
    }
    state = state.copyWith(isPlaying: false, isGameOver: true);
  }
}

// --- Providers ---
final scoreRepositoryProvider = Provider<ScoreRepository>((ref) => ScoreRepository());

final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  return GameNotifier(ref.watch(scoreRepositoryProvider));
});
