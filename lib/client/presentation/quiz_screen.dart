import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:leemcwest/client/presentation/app_theme.dart';
import 'package:leemcwest/client/presentation/fnh_color_resolver.dart';

// ─────────────────────────────────────────────
// Data models
// ─────────────────────────────────────────────

enum QuizQuestionType { multipleChoice, dragOrder }

class QuizQuestion {
  final QuizQuestionType type;
  final String question;
  final List<String>
      options; // For MC: answer options. For drag: items to order.
  final dynamic
      correctAnswer; // MC: int index. Drag: List<String> correct order.
  final Map<int, String>? explanations; // MC: wrong option index → explanation
  final String? explanation; // Drag: single explanation for wrong answer

  const QuizQuestion({
    required this.type,
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.explanations,
    this.explanation,
  });
}

// ─────────────────────────────────────────────
// QuizScreen
// ─────────────────────────────────────────────

class QuizScreen extends StatefulWidget {
  final List<QuizQuestion> questions;
  final VoidCallback onReviewAnswers;
  final VoidCallback onLessonSummary;
  final VoidCallback onRetry;
  final VoidCallback onNextLesson;

  const QuizScreen({
    super.key,
    required this.questions,
    required this.onReviewAnswers,
    required this.onLessonSummary,
    required this.onRetry,
    required this.onNextLesson,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final Map<int, int> _mcAnswers = {};
  final Map<int, List<String>> _dragAnswers = {};
  bool _submitted = false;
  bool _showResult = false;

  void _selectMC(int qi, int oi) {
    if (_submitted) return;
    setState(() => _mcAnswers[qi] = oi);
  }

  void _toggleDragItem(int qi, String item) {
    if (_submitted) return;
    setState(() {
      final current = _dragAnswers[qi] ?? [];
      if (current.contains(item)) {
        _dragAnswers[qi] = current.where((x) => x != item).toList();
      } else {
        _dragAnswers[qi] = [...current, item];
      }
    });
  }

  bool _isCorrect(int qi) {
    final q = widget.questions[qi];
    if (q.type == QuizQuestionType.multipleChoice) {
      return _mcAnswers[qi] == q.correctAnswer;
    }
    final userOrder = _dragAnswers[qi] ?? [];
    final correctOrder = q.correctAnswer as List<String>;
    if (userOrder.length != correctOrder.length) return false;
    for (var i = 0; i < userOrder.length; i++) {
      if (userOrder[i] != correctOrder[i]) return false;
    }
    return true;
  }

  int get _score =>
      List.generate(widget.questions.length, (i) => _isCorrect(i) ? 1 : 0)
          .fold(0, (a, b) => a + b);

  void _submit() {
    setState(() => _submitted = true);
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) setState(() => _showResult = true);
    });
  }

  void _reset() {
    setState(() {
      _mcAnswers.clear();
      _dragAnswers.clear();
      _submitted = false;
      _showResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.questions.length;
    final score = _score;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          Column(
            children: [
              // ── HEADER ──
              SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).maybePop(),
                            child: const Icon(Icons.arrow_back,
                                color: AppColors.textMuted, size: 22),
                          ),
                          Expanded(
                            child: Text('Quiz',
                                textAlign: TextAlign.center,
                                style: AppTypography.heading(size: 16)),
                          ),
                          const SizedBox(width: 22),
                        ],
                      ),
                    ),
                    // Progress dots
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(total, (i) {
                          Color bg = AppColors.border;
                          if (_submitted) {
                            bg = _isCorrect(i)
                                ? AppColors.success
                                : (_mcAnswers.containsKey(i) ||
                                        (_dragAnswers[i]?.isNotEmpty ?? false)
                                    ? AppColors.error
                                    : AppColors.border);
                          } else if (_mcAnswers.containsKey(i) ||
                              (_dragAnswers[i]?.isNotEmpty ?? false)) {
                            bg = AppColors.accent;
                          }
                          return Container(
                            width: 28,
                            height: 4,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              color: bg,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          );
                        }),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Divider(height: 1, color: AppColors.border),
                    ),
                  ],
                ),
              ),

              // ── QUESTIONS ──
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
                  child: Column(
                    children: widget.questions.asMap().entries.map((entry) {
                      final qi = entry.key;
                      final q = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.quizCard,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.quizBorder),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${qi + 1}. ${q.question}',
                                  style: AppTypography.label(
                                      size: 14, color: AppColors.textPrimary)),
                              const SizedBox(height: 16),
                              if (q.type == QuizQuestionType.multipleChoice)
                                _buildMC(qi, q),
                              if (q.type == QuizQuestionType.dragOrder)
                                _buildDragOrder(qi, q),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),

          // ── BOTTOM BAR ──
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
              decoration: const BoxDecoration(
                color: AppColors.bg,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _reset,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textSecondary,
                          side: const BorderSide(
                              color: AppColors.border, width: 1.5),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('↺ Reset'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: _submitted ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _submitted
                              ? AppColors.textMuted
                              : AppColors.accent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('Submit Answers'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── RESULT MODAL ──
          if (_showResult) _buildResultModal(score, total),
        ],
      ),
    );
  }

  // ─── Multiple Choice ───
  Widget _buildMC(int qi, QuizQuestion q) {
    return Column(
      children: q.options.asMap().entries.map((entry) {
        final oi = entry.key;
        final opt = entry.value;
        final selected = _mcAnswers[qi] == oi;
        Color borderColor = selected ? AppColors.accent : AppColors.border;
        Color bgColor = selected ? AppColors.quizSelected : Colors.transparent;
        String? icon;

        if (_submitted && selected) {
          final correct = oi == (q.correctAnswer as int);
          borderColor = correct ? AppColors.success : AppColors.error;
          bgColor = correct
              ? AppColors.success.withValues(alpha: .08)
              : AppColors.error.withValues(alpha: .08);
          icon = correct ? '✓' : '✗';
        } else if (_submitted && oi == (q.correctAnswer as int)) {
          borderColor = AppColors.success;
          bgColor = AppColors.success.withValues(alpha: .05);
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => _selectMC(qi, oi),
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: borderColor, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(opt,
                              style: AppTypography.label(
                                  size: 14, color: AppColors.textPrimary))),
                      if (icon != null)
                        Text(icon,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: borderColor)),
                    ],
                  ),
                ),
              ),
              // Explanation for wrong answer
              if (_submitted &&
                  selected &&
                  oi != (q.correctAnswer as int) &&
                  q.explanations != null &&
                  q.explanations!.containsKey(oi))
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: .06),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: AppColors.error.withValues(alpha: .15)),
                    ),
                    child: Text(q.explanations![oi]!,
                        style: AppTypography.body(size: 13, height: 1.55)),
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ─── Drag Order ───
  Widget _buildDragOrder(int qi, QuizQuestion q) {
    final placed = _dragAnswers[qi] ?? [];
    final correctOrder = q.correctAnswer as List<String>;
    final isCorrect = _isCorrect(qi);
    final itemCount = q.options.length;
  //  final crossAxisCount = itemCount > 6 ? 4 : itemCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Available items
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: q.options.asMap().entries.map((entry) {
            final item = entry.value;
           // final idx = entry.key;
            final isPlaced = placed.contains(item);
            return GestureDetector(
              onTap: () => _toggleDragItem(qi, item),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isPlaced ? 0.4 : 1.0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                  decoration: BoxDecoration(
                    color: isPlaced ? AppColors.surface : AppColors.accentSoft,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color:
                            isPlaced ? AppColors.textMuted : AppColors.accent,
                        width: 1.5),
                  ),
                  child: Text(item,
                      style: AppTypography.mono(
                          size: 14,
                          color: isPlaced
                              ? AppColors.textMuted
                              : AppColors.accent)),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),

        // Label
        Text('YOUR ORDER:',
            style: AppTypography.label(size: 11, color: AppColors.textMuted)
                .copyWith(letterSpacing: 0.8)),
        const SizedBox(height: 8),

        // Drop slots
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: List.generate(itemCount, (slot) {
            final item = slot < placed.length ? placed[slot] : null;
            Color borderColor = AppColors.border;
            Color bgColor = AppColors.surface;

            if (_submitted && item != null) {
              final ok = item == correctOrder[slot];
              borderColor = ok ? AppColors.success : AppColors.error;
              bgColor = ok
                  ? AppColors.success.withValues(alpha: .08)
                  : AppColors.error.withValues(alpha: .08);
            } else if (item != null) {
              borderColor = AppColors.accent;
              bgColor = AppColors.accentSoft;
            }

            final slotWidth = itemCount > 6
                ? (MediaQuery.of(context).size.width - 48 - 18) / 4
                : (MediaQuery.of(context).size.width -
                        48 -
                        (itemCount - 1) * 6) /
                    itemCount;

            return GestureDetector(
              onTap: () {
                if (item != null && !_submitted) _toggleDragItem(qi, item);
              },
              child: Container(
                width: slotWidth,
                height: 40,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: borderColor, width: 1.5),
                ),
                alignment: Alignment.center,
                child: item != null
                    ? Text(item,
                        style: AppTypography.mono(
                            size: itemCount > 8 ? 11 : 13,
                            color: FnhColorResolver.resolve(item)))
                    : Text('${slot + 1}',
                        style: AppTypography.mono(
                            size: 11, color: AppColors.textMuted)),
              ),
            );
          }),
        ),

        // Post-submit feedback
        if (_submitted) ...[
          const SizedBox(height: 10),
          Text(
            isCorrect
                ? '✓ Correct!'
                : '✗ Correct order: ${correctOrder.join(' → ')}',
            style: AppTypography.label(
                size: 12,
                color: isCorrect ? AppColors.success : AppColors.error),
          ),
          if (!isCorrect && q.explanation != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: .06),
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: AppColors.error.withValues(alpha: .15)),
                ),
                child: Text(q.explanation!,
                    style: AppTypography.body(size: 13, height: 1.55)),
              ),
            ),
        ],
      ],
    );
  }

  // ─── Result Modal ───
  Widget _buildResultModal(int score, int total) {
    final perfect = score == total;
    final color = perfect ? AppColors.success : AppColors.accent;

    return GestureDetector(
      onTap: () => setState(() => _showResult = false),
      child: Container(
        color: Colors.black.withValues(alpha: .7),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {}, // absorb taps
          child: Container(
            width: 280,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(perfect ? 'Perfect!' : 'Results',
                    style: AppTypography.heading(
                        size: 20, weight: FontWeight.w700, color: color)),
                const SizedBox(height: 20),

                // Score ring
                SizedBox(
                  width: 90,
                  height: 90,
                  child: CustomPaint(
                    painter: _ScoreRingPainter(
                        progress: score / total, color: color),
                    child: Center(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: '$score',
                              style: AppTypography.heading(
                                  size: 26, weight: FontWeight.w700)),
                          TextSpan(
                              text: '/$total',
                              style: AppTypography.label(
                                  size: 14, color: AppColors.textMuted)),
                        ]),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Text('You answered $score out of $total correctly',
                    textAlign: TextAlign.center,
                    style: AppTypography.body(size: 14)),
                const SizedBox(height: 24),

                // Buttons
                _modalButton('Review Answers', AppColors.accent, Colors.white,
                    () {
                  setState(() => _showResult = false);
                  widget.onReviewAnswers();
                }),
                const SizedBox(height: 8),
                _modalOutlineButton('Lesson Summary', () {
                  setState(() => _showResult = false);
                  widget.onLessonSummary();
                }),
                const SizedBox(height: 8),
                _modalOutlineButton('Retry Quiz', () {
                  _reset();
                }),
                const SizedBox(height: 8),
                _modalOutlineButton('Next Lesson →', () {
                  setState(() => _showResult = false);
                  widget.onNextLesson();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _modalButton(String label, Color bg, Color fg, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(label, style: AppTypography.button(size: 14)),
      ),
    );
  }

  Widget _modalOutlineButton(String label, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textSecondary,
          side: const BorderSide(color: AppColors.border, width: 1.5),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(label),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Score ring painter
// ─────────────────────────────────────────────

class _ScoreRingPainter extends CustomPainter {
  final double progress;
  final Color color;
  _ScoreRingPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;

    // Background ring
    canvas.drawCircle(
        center,
        radius,
        Paint()
          ..color = AppColors.border
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5);

    // Progress arc
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ScoreRingPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
