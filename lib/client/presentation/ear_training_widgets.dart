import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/app_theme.dart';
import 'package:leemcwest/client/presentation/ear_training_models.dart';


// ─────────────────────────────────────────────
// Function colour helper for flow labels
// ─────────────────────────────────────────────

Color _fnColor(String fn) {
  switch (fn.trim()) {
    case 'T': return AppColors.fnT;
    case 'S': return AppColors.fnS;
    case 'D': return AppColors.fnD;
    case 'D#': return AppColors.fnDsharp;
    case 'Db': return AppColors.fnDb;
    default: return AppColors.textSecondary;
  }
}

// ─────────────────────────────────────────────
// FlowLabel — renders "T → S → T" with coloured functions
// ─────────────────────────────────────────────

class FlowLabel extends StatelessWidget {
  final String pattern;
  const FlowLabel({super.key, required this.pattern});

  @override
  Widget build(BuildContext context) {
    final parts = pattern.split(RegExp(r'\s*(→)\s*'));
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: parts.map((part) {
        if (part == '→') {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text('→', style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
          );
        }
        return Text(
          part,
          style: TextStyle(
            fontFamily: AppTypography.fontDisplay,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _fnColor(part),
          ),
        );
      }).toList(),
    );
  }
}

// ─────────────────────────────────────────────
// PlayButton — accent gradient, play/pause icon
// ─────────────────────────────────────────────

class PlayButton extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback? onTap;
  const PlayButton({super.key, this.isPlaying = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.accent, Color(0xFF5A4BD6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.accent),
          boxShadow: [BoxShadow(color: AppColors.accentGlow, blurRadius: 20, offset: const Offset(0, 4))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPlaying ? Icons.pause : Icons.volume_up,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 10),
            Text(
              isPlaying ? 'Playing…' : 'Play Phrase',
              style: AppTypography.button(size: 15),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// AnswerOption — selectable option with state feedback
// ─────────────────────────────────────────────

class AnswerOption extends StatelessWidget {
  final ExerciseOption option;
  final OptionState state;
  final VoidCallback? onTap;
  const AnswerOption({super.key, required this.option, this.state = OptionState.defaultState, this.onTap});

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    Color bgColor;

    switch (state) {
      case OptionState.selected:
        borderColor = AppColors.accent;
        bgColor = AppColors.accentSoft;
      case OptionState.correct:
        borderColor = AppColors.success.withOpacity(0.25);
        bgColor = AppColors.success.withOpacity(0.1);
      case OptionState.incorrect:
        borderColor = AppColors.error.withOpacity(0.25);
        bgColor = AppColors.error.withOpacity(0.1);
      default:
        borderColor = AppColors.border;
        bgColor = AppColors.card;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            FlowLabel(pattern: option.pattern),
            if (state == OptionState.correct)
              const Positioned(
                right: 4,
                child: Icon(Icons.check, size: 16, color: AppColors.success),
              ),
            if (state == OptionState.incorrect)
              const Positioned(
                right: 4,
                child: Icon(Icons.close, size: 16, color: AppColors.error),
              ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// EarTrainingProgressBar — reusable progress bar
// ─────────────────────────────────────────────

class EarTrainingProgressBar extends StatelessWidget {
  final double value; // 0–100
  final Color color;
  final double height;
  const EarTrainingProgressBar({super.key, required this.value, required this.color, this.height = 3});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(height / 2),
      ),
      clipBehavior: Clip.antiAlias,
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: (value / 100).clamp(0, 1),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(height / 2),
            boxShadow: value > 0 ? [BoxShadow(color: color.withOpacity(0.27), blurRadius: 8)] : null,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// StatusBadge — Continue / Complete / Locked
// ─────────────────────────────────────────────

class StatusBadge extends StatelessWidget {
  final LevelStatus status;
  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    String label;
    Color color;
    Color bg;
    Color border;

    switch (status) {
      case LevelStatus.inProgress:
        label = 'Continue'; color = AppColors.success;
        bg = AppColors.success.withOpacity(0.15); border = AppColors.success.withOpacity(0.3);
      case LevelStatus.completed:
        label = 'Complete'; color = AppColors.accent;
        bg = AppColors.accent.withOpacity(0.15); border = AppColors.accent.withOpacity(0.3);
      case LevelStatus.locked:
        label = 'Locked'; color = AppColors.textMuted;
        bg = const Color(0xFF3A3A4A).withOpacity(0.3); border = AppColors.border;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border),
      ),
      child: Text(label, style: TextStyle(
        fontFamily: AppTypography.fontDisplay, fontSize: 12,
        fontWeight: FontWeight.w600, color: color, letterSpacing: 0.4,
      )),
    );
  }
}

// ─────────────────────────────────────────────
// StatPill — for level complete screen
// ─────────────────────────────────────────────

class StatPill extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;
  const StatPill({super.key, required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(
              fontFamily: AppTypography.fontDisplay, fontSize: 22,
              fontWeight: FontWeight.w700, color: color ?? AppColors.textPrimary,
            )),
            const SizedBox(height: 4),
            Text(label.toUpperCase(), style: TextStyle(
              fontFamily: AppTypography.fontDisplay, fontSize: 11,
              color: AppColors.textMuted, fontWeight: FontWeight.w500, letterSpacing: 1.0,
            )),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// LevelCard — for level select screen
// ─────────────────────────────────────────────

class LevelCard extends StatelessWidget {
  final EarTrainingLevel level;
  final VoidCallback? onTap;
  const LevelCard({super.key, required this.level, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isLocked = level.status == LevelStatus.locked;
    return GestureDetector(
      onTap: isLocked ? null : onTap,
      child: Opacity(
        opacity: isLocked ? 0.55 : 1,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Stack(
            children: [
              // Left accent bar
              Positioned(
                left: -20, top: 0, bottom: 0,
                child: Container(
                  width: 3,
                  decoration: BoxDecoration(
                    color: level.accentColor.withOpacity(isLocked ? 0.3 : 0.8),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      bottomLeft: Radius.circular(14),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(level.title, style: AppTypography.heading(size: 19).copyWith(letterSpacing: -0.2)),
                            const SizedBox(height: 4),
                            Text(level.subtitle, style: AppTypography.label(size: 13.5, color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                      StatusBadge(status: level.status),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Patterns
                  Text(level.patterns, style: AppTypography.mono(size: 13, color: AppColors.textMuted)),
                  const SizedBox(height: 16),
                  // Description
                  Text(level.description, style: AppTypography.body(size: 14, height: 1.65)),
                  const SizedBox(height: 18),
                  // Progress
                  EarTrainingProgressBar(value: level.progress.toDouble(), color: level.accentColor),
                  const SizedBox(height: 12),
                  // Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('Accuracy: ', style: TextStyle(fontFamily: AppTypography.fontDisplay, fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                          Text('${level.accuracy}%', style: TextStyle(fontSize: 12.5, color: level.accuracy > 70 ? AppColors.success : level.accuracy > 0 ? const Color(0xFFFACC15) : AppColors.textMuted)),
                          const SizedBox(width: 20),
                          Text('Exercises: ', style: TextStyle(fontFamily: AppTypography.fontDisplay, fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                          Text('${level.completed}/${level.exercises}', style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
                        ],
                      ),
                      Text(
                        level.progress > 0 ? '${level.progress}%' : isLocked ? 'Locked' : 'Not started',
                        style: AppTypography.label(size: 12, color: AppColors.textMuted),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
