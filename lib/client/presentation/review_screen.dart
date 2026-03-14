import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/app_theme.dart';
import 'quiz_screen.dart';

// ─────────────────────────────────────────────
// ReviewScreen — shows all questions with correct/incorrect,
// correct answers, and explanations for wrong ones.
// ─────────────────────────────────────────────

class ReviewScreen extends StatelessWidget {
  final List<QuizQuestion> questions;

  /// Map of question index → user's answer.
  /// For MC: the selected option index.
  /// For drag: the user's ordered list.
  final Map<int, dynamic> userAnswers;

  final VoidCallback onRetryQuiz;
  final VoidCallback onLessonSummary;

  const ReviewScreen({
    super.key,
    required this.questions,
    required this.userAnswers,
    required this.onRetryQuiz,
    required this.onLessonSummary,
  });

  bool _isCorrect(int qi) {
    final q = questions[qi];
    final answer = userAnswers[qi];
    if (q.type == QuizQuestionType.multipleChoice) {
      return answer == q.correctAnswer;
    }
    if (answer is List<String>) {
      final correct = q.correctAnswer as List<String>;
      if (answer.length != correct.length) return false;
      for (var i = 0; i < answer.length; i++) {
        if (answer[i] != correct[i]) return false;
      }
      return true;
    }
    return false;
  }

  String _correctAnswerText(QuizQuestion q) {
    if (q.type == QuizQuestionType.multipleChoice) {
      return q.options[q.correctAnswer as int];
    }
    return (q.correctAnswer as List<String>).join(' → ');
  }

  String? _getExplanation(int qi) {
    final q = questions[qi];
    if (_isCorrect(qi)) return null;

    if (q.type == QuizQuestionType.dragOrder) return q.explanation;

    // For MC, get the explanation for the user's wrong answer
    final userChoice = userAnswers[qi];
    if (userChoice is int && q.explanations != null && q.explanations!.containsKey(userChoice)) {
      return q.explanations![userChoice];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(
        children: [
          // ── HEADER ──
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).maybePop(),
                        child: const Icon(Icons.arrow_back,
                            color: AppColors.textMuted, size: 22),
                      ),
                      Expanded(
                        child: Text('Review Answers',
                            textAlign: TextAlign.center,
                            style: AppTypography.heading(size: 16)),
                      ),
                      const SizedBox(width: 22),
                    ],
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
                children: questions.asMap().entries.map((entry) {
                  final qi = entry.key;
                  final q = entry.value;
                  final correct = _isCorrect(qi);
                  final explanation = _getExplanation(qi);
                  final answerText = _correctAnswerText(q);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.quizCard,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: correct
                              ? AppColors.success.withOpacity(0.3)
                              : AppColors.error.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Question with icon
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: correct
                                      ? AppColors.success.withOpacity(0.15)
                                      : AppColors.error.withOpacity(0.15),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  correct ? '✓' : '✗',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: correct
                                        ? AppColors.success
                                        : AppColors.error,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text('${qi + 1}. ${q.question}',
                                    style: AppTypography.label(
                                        size: 14, color: AppColors.textPrimary)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Correct answer
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: correct
                                  ? AppColors.success.withOpacity(0.06)
                                  : AppColors.error.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Correct answer: ',
                                      style: AppTypography.label(
                                          size: 12, color: AppColors.textMuted)),
                                  TextSpan(
                                      text: answerText,
                                      style: AppTypography.label(
                                          size: 13,
                                          weight: FontWeight.w600,
                                          color: correct
                                              ? AppColors.success
                                              : AppColors.textPrimary)),
                                ],
                              ),
                            ),
                          ),

                          // Explanation
                          if (explanation != null) ...[
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: 'Why: ',
                                        style: AppTypography.label(
                                            size: 12,
                                            weight: FontWeight.w600,
                                            color: AppColors.calloutTitle)),
                                    TextSpan(
                                        text: explanation,
                                        style: AppTypography.body(
                                            size: 13, height: 1.55)),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
      bottomNavigationBar: Container(
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
                  onPressed: onRetryQuiz,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                    side: const BorderSide(color: AppColors.border, width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Retry Quiz'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: onLessonSummary,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Lesson Summary'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
