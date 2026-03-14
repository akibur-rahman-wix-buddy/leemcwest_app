import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/app_theme.dart';
import 'package:leemcwest/client/presentation/ear_training_models.dart';
import 'package:leemcwest/client/presentation/ear_training_widgets.dart';


/// Level Select screen — shows overall progress and level cards.
class EarTrainingLevelSelectScreen extends StatelessWidget {
  final List<EarTrainingLevel> levels;
  final int totalExercises;
  final int completedExercises;
  final VoidCallback? onBack;
  final ValueChanged<EarTrainingLevel>? onSelectLevel;

  const EarTrainingLevelSelectScreen({
    super.key,
    required this.levels,
    required this.totalExercises,
    required this.completedExercises,
    this.onBack,
    this.onSelectLevel,
  });

  @override
  Widget build(BuildContext context) {
    final overallProgress = totalExercises > 0 ? (completedExercises / totalExercises * 100) : 0.0;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: onBack ?? () => Navigator.maybePop(context),
                    child: const Icon(Icons.arrow_back, color: AppColors.textMuted, size: 22),
                  ),
                  const Text('···', style: TextStyle(color: AppColors.textMuted, fontSize: 18, letterSpacing: 2)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Functional Ear Training', style: AppTypography.heading(size: 23).copyWith(letterSpacing: -0.4)),
                  const SizedBox(height: 6),
                  Text('Train your perception of motion',
                      style: AppTypography.body(size: 14.5, height: 1.5)),
                ],
              ),
            ),

            // Overall progress card
            Container(
              margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('OVERALL PROGRESS', style: TextStyle(
                        fontFamily: AppTypography.fontDisplay, fontSize: 12,
                        fontWeight: FontWeight.w600, color: AppColors.textSecondary,
                        letterSpacing: 1.0,
                      )),
                      Text('$completedExercises / $totalExercises exercises',
                          style: AppTypography.label(size: 12, color: AppColors.textMuted)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  EarTrainingProgressBar(value: overallProgress, color: AppColors.accent, height: 4),
                ],
              ),
            ),

            // Level cards
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
                itemCount: levels.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, i) {
                  return LevelCard(
                    level: levels[i],
                    onTap: () => onSelectLevel?.call(levels[i]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
