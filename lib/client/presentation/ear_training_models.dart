import 'package:flutter/material.dart';

/// Status of an ear training level.
enum LevelStatus { locked, inProgress, completed }

/// An ear training level in the level select screen.
class EarTrainingLevel {
  final String id;
  final String title;
  final String subtitle;
  final String patterns;
  final String description;
  final int accuracy;
  final int progress; // 0–100
  final LevelStatus status;
  final Color accentColor;
  final int exercises;
  final int completed;

  const EarTrainingLevel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.patterns,
    required this.description,
    required this.accuracy,
    required this.progress,
    required this.status,
    required this.accentColor,
    required this.exercises,
    required this.completed,
  });
}

/// An answer option in an exercise.
class ExerciseOption {
  final String id;
  final String pattern; // e.g. "T → S → T"

  const ExerciseOption({required this.id, required this.pattern});
}

/// State of an answer option.
enum OptionState { defaultState, selected, correct, incorrect }

/// Exercise data for a single ear training question.
class ExerciseData {
  final String question;
  final String level;
  final int questionNumber;
  final int totalQuestions;
  final int score;
  final List<ExerciseOption> options;
  final String correctAnswer; // option id
  final String explanation;

  const ExerciseData({
    required this.question,
    required this.level,
    required this.questionNumber,
    required this.totalQuestions,
    required this.score,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });
}

/// Exercise phase.
enum ExercisePhase { ready, playing, answeredCorrect, answeredIncorrect }

/// Level completion data.
class LevelCompletionData {
  final String title;
  final int accuracy;
  final int exercisesCompleted;
  final int totalExercises;
  final int correctAnswers;
  final int hintsUsed;
  final String? nextLevel;
  final bool nextLevelUnlocked;

  const LevelCompletionData({
    required this.title,
    required this.accuracy,
    required this.exercisesCompleted,
    required this.totalExercises,
    required this.correctAnswers,
    required this.hintsUsed,
    this.nextLevel,
    this.nextLevelUnlocked = false,
  });
}
