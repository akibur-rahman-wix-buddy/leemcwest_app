import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/app_theme.dart';
import 'package:leemcwest/client/presentation/ear_training_models.dart';
import 'package:leemcwest/client/presentation/ear_training_widgets.dart';


/// Level Complete screen — shown after finishing all exercises in a level.
/// Displays stats, next level unlocked card, and repeat/next buttons.
class EarTrainingLevelCompleteScreen extends StatelessWidget {
  final LevelCompletionData data;
  final VoidCallback? onRepeatLevel;
  final VoidCallback? onNextLevel;

  const EarTrainingLevelCompleteScreen({
    super.key,
    required this.data,
    this.onRepeatLevel,
    this.onNextLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 50),

              // ── Trefoil Icon ──
              _TrefoilIcon(),
              const SizedBox(height: 24),

              // ── Level Badge ──
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.accentSoft,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.accent.withValues(alpha: .25)),
                ),
                child: Text(
                  '${data.title} Complete'.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: AppTypography.fontDisplay, fontSize: 12,
                    fontWeight: FontWeight.w600, color: AppColors.accent, letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ── Heading ──
              Text('Level complete', style: AppTypography.heading(size: 24).copyWith(letterSpacing: -0.4)),
              const SizedBox(height: 14),

              // ── Body text ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Text(
                      'You\'ve worked through every exercise at this stage. Your ear is building its vocabulary of functional motion — T, S, and D are becoming sounds you recognise, not just labels you read.',
                      textAlign: TextAlign.center,
                      style: AppTypography.body(size: 15, height: 1.7),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'This kind of hearing deepens with repetition. Come back and run these exercises again — each pass strengthens the instinct.',
                      textAlign: TextAlign.center,
                      style: AppTypography.body(size: 15, height: 1.7),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ── Stats ──
              Row(
                children: [
                  StatPill(
                    label: 'Accuracy',
                    value: '${data.accuracy}%',
                    color: data.accuracy >= 70 ? AppColors.success : AppColors.textPrimary,
                  ),
                  const SizedBox(width: 10),
                  StatPill(
                    label: 'Correct',
                    value: '${data.correctAnswers}/${data.totalExercises}',
                  ),
                  const SizedBox(width: 10),
                  StatPill(
                    label: 'Hints',
                    value: '${data.hintsUsed}',
                    color: AppColors.textMuted,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ── Next Level Unlocked Card ──
              if (data.nextLevelUnlocked && data.nextLevel != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: .08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.success.withValues(alpha: .2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.lock_open, size: 20, color: AppColors.success),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${data.nextLevel} unlocked', style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.success,
                            )),
                            const SizedBox(height: 2),
                            Text('New patterns and longer functional chains are ready',
                                style: AppTypography.label(size: 12, color: AppColors.textMuted)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              // ── Action Buttons ──
              Row(
                children: [
                  // Repeat
                  Expanded(
                    child: GestureDetector(
                      onTap: onRepeatLevel,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.refresh, size: 16, color: AppColors.textSecondary),
                            SizedBox(width: 8),
                            Text('Repeat Level', style: TextStyle(
                              fontFamily: AppTypography.fontDisplay, fontSize: 14,
                              fontWeight: FontWeight.w600, color: AppColors.textSecondary,
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Next Level
                  Expanded(
                    child: GestureDetector(
                      onTap: onNextLevel,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [AppColors.accent, Color(0xFF5A4BD6)]),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.accent),
                          boxShadow: const [BoxShadow(color: AppColors.accentGlow, blurRadius: 20, offset: Offset(0, 4))],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Next Level', style: AppTypography.button(size: 14)),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ── Footer message ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Accuracy measures answers. Awareness measures growth. Both matter — one you can track, the other you\'ll feel.',
                  textAlign: TextAlign.center,
                  style: AppTypography.body(size: 12.5, color: AppColors.textMuted, height: 1.6)
                      .copyWith(fontStyle: FontStyle.italic),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Trefoil knot icon (geometric decoration)
// ─────────────────────────────────────────────

class _TrefoilIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(120, 120),
      painter: _TrefoilPainter(),
    );
  }
}

class _TrefoilPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Outer glow
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [AppColors.accent.withValues(alpha: .15), AppColors.accent.withValues(alpha: 0)],
      ).createShader(Rect.fromCircle(center: center, radius: 58));
    canvas.drawCircle(center, 58, glowPaint);

    // Decorative rings
    canvas.drawCircle(center, 48, Paint()..color = AppColors.accent.withValues(alpha: .12)..style = PaintingStyle.stroke..strokeWidth = 0.5);
    canvas.drawCircle(center, 55, Paint()..color = AppColors.accent.withValues(alpha: .08)..style = PaintingStyle.stroke..strokeWidth = 0.3);

    // Three interlocking ellipses
    final knotPaint = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    // Top ellipse
    canvas.save();
    canvas.translate(center.dx, center.dy - 18);
    canvas.drawOval(Rect.fromCenter(center: Offset.zero, width: 44, height: 36), knotPaint..color = AppColors.accent.withValues(alpha: .9));
    canvas.restore();

    // Bottom-left ellipse
    canvas.save();
    canvas.translate(center.dx - 18, center.dy + 10);
    canvas.rotate(-0.52);
    canvas.drawOval(Rect.fromCenter(center: Offset.zero, width: 44, height: 36), knotPaint..color = AppColors.accent.withValues(alpha: .7));
    canvas.restore();

    // Bottom-right ellipse
    canvas.save();
    canvas.translate(center.dx + 18, center.dy + 10);
    canvas.rotate(0.52);
    canvas.drawOval(Rect.fromCenter(center: Offset.zero, width: 44, height: 36), knotPaint..color = AppColors.accent.withValues(alpha: .7));
    canvas.restore();

    // Centre dot
    canvas.drawCircle(Offset(center.dx, center.dy - 2), 4, Paint()..color = AppColors.accent.withValues(alpha: .6));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
