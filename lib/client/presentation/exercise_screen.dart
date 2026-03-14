import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/app_theme.dart';
import 'package:leemcwest/client/presentation/ear_training_models.dart';
import 'package:leemcwest/client/presentation/ear_training_widgets.dart';


/// Exercise screen — a single ear training question.
/// Play a phrase, select an answer, get feedback with explanation.
class EarTrainingExerciseScreen extends StatefulWidget {
  final ExerciseData exercise;
  final VoidCallback? onBack;
  final VoidCallback? onNextPhrase;

  const EarTrainingExerciseScreen({
    super.key,
    required this.exercise,
    this.onBack,
    this.onNextPhrase,
  });

  @override
  State<EarTrainingExerciseScreen> createState() => _EarTrainingExerciseScreenState();
}

class _EarTrainingExerciseScreenState extends State<EarTrainingExerciseScreen> {
  ExercisePhase _phase = ExercisePhase.ready;
  String? _selectedAnswer;
  bool _hintVisible = false;
  bool _showAnswer = false;

  bool get _isAnswered => _phase == ExercisePhase.answeredCorrect || _phase == ExercisePhase.answeredIncorrect;
  bool get _isCorrect => _phase == ExercisePhase.answeredCorrect;

  OptionState _getOptionState(ExerciseOption option) {
    if (!_isAnswered) {
      return _selectedAnswer == option.id ? OptionState.selected : OptionState.defaultState;
    }
    if (option.id == widget.exercise.correctAnswer) return OptionState.correct;
    if (option.id == _selectedAnswer && _selectedAnswer != widget.exercise.correctAnswer) return OptionState.incorrect;
    return OptionState.defaultState;
  }

  void _selectOption(ExerciseOption option) {
    if (_isAnswered) return;
    setState(() {
      _selectedAnswer = option.id;
      if (option.id == widget.exercise.correctAnswer) {
        _phase = ExercisePhase.answeredCorrect;
      } else {
        _phase = ExercisePhase.answeredIncorrect;
      }
      _showAnswer = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ex = widget.exercise;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: widget.onBack ?? () => Navigator.maybePop(context),
                    child: const Icon(Icons.arrow_back, color: AppColors.textMuted, size: 22),
                  ),
                  Text(ex.level.toUpperCase(), style: TextStyle(
                    fontFamily: AppTypography.fontDisplay, fontSize: 12,
                    color: AppColors.textMuted, fontWeight: FontWeight.w500, letterSpacing: 1.0,
                  )),
                  const Text('···', style: TextStyle(color: AppColors.textMuted, fontSize: 18, letterSpacing: 2)),
                ],
              ),
            ),

            // ── Question counter ──
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Question ${ex.questionNumber}', style: AppTypography.heading(size: 13, weight: FontWeight.w600)),
                  Text(' of ${ex.totalQuestions}', style: AppTypography.label(size: 13, color: AppColors.textMuted)),
                ],
              ),
            ),

            // ── Progress dots ──
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: Row(
                children: List.generate(ex.totalQuestions, (i) {
                  Color dotColor = AppColors.border;
                  if (i < ex.score) dotColor = AppColors.success;
                  else if (i < ex.questionNumber - 1) dotColor = AppColors.error;
                  else if (i == ex.questionNumber - 1) dotColor = AppColors.accent;
                  return Expanded(
                    child: Container(
                      height: 3,
                      margin: EdgeInsets.only(right: i < ex.totalQuestions - 1 ? 3 : 0),
                      decoration: BoxDecoration(
                        color: dotColor,
                        borderRadius: BorderRadius.circular(1.5),
                        boxShadow: i == ex.questionNumber - 1
                            ? [BoxShadow(color: AppColors.accentGlow, blurRadius: 6)]
                            : null,
                      ),
                    ),
                  );
                }),
              ),
            ),

            // ── Content ──
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 60),
                child: Column(
                  children: [
                    // Question
                    Text(ex.question, textAlign: TextAlign.center,
                        style: AppTypography.heading(size: 17).copyWith(letterSpacing: -0.2)),
                    const SizedBox(height: 18),

                    // Play button
                    PlayButton(
                      isPlaying: _phase == ExercisePhase.playing,
                      onTap: () {
                        if (_phase == ExercisePhase.ready) setState(() => _phase = ExercisePhase.playing);
                        else if (_phase == ExercisePhase.playing) setState(() => _phase = ExercisePhase.ready);
                      },
                    ),

                    // Score
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: RichText(text: TextSpan(
                        style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                        children: [
                          const TextSpan(text: 'Score: '),
                          TextSpan(text: '${ex.score}', style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                          TextSpan(text: '/${ex.totalQuestions}', style: const TextStyle(color: AppColors.textMuted)),
                        ],
                      )),
                    ),

                    // Feedback label
                    if (_isAnswered)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          _isCorrect ? 'CORRECT' : 'INCORRECT',
                          style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700,
                            color: _isCorrect ? AppColors.success : AppColors.error,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),

                    // 2×2 answer grid
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: ex.options.map((opt) {
                        return SizedBox(
                          width: (MediaQuery.of(context).size.width - 58) / 2,
                          child: AnswerOption(
                            option: opt,
                            state: _getOptionState(opt),
                            onTap: () => _selectOption(opt),
                          ),
                        );
                      }).toList(),
                    ),

                    // Explanation card
                    if (_isAnswered && _showAnswer)
                      Container(
                        margin: const EdgeInsets.only(top: 18),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.success.withOpacity(0.2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              const Text('Correct answer: ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.success)),
                              FlowLabel(pattern: ex.options.firstWhere((o) => o.id == ex.correctAnswer).pattern),
                            ]),
                            const SizedBox(height: 8),
                            Text(ex.explanation, style: AppTypography.body(size: 14, height: 1.65)),
                          ],
                        ),
                      ),

                    // Action buttons
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          // Hint button
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _hintVisible = !_hintVisible),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: _hintVisible ? AppColors.accentSoft : AppColors.card,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppColors.border),
                                ),
                                alignment: Alignment.center,
                                child: Text('Tonic Root Hint', style: TextStyle(
                                  fontFamily: AppTypography.fontDisplay, fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: _hintVisible ? AppColors.accent : AppColors.textSecondary,
                                )),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Show answer button
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _showAnswer = !_showAnswer),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [AppColors.accent, Color(0xFF5A4BD6)]),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppColors.accent),
                                ),
                                alignment: Alignment.center,
                                child: Text('Show Answer', style: AppTypography.button(size: 13)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Hint display
                    if (_hintVisible)
                      Container(
                        margin: const EdgeInsets.only(top: 14),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.accentSoft,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.accent.withOpacity(0.2)),
                        ),
                        child: Column(
                          children: [
                            Text('TONIC ROOT', style: TextStyle(
                              fontSize: 12, color: AppColors.textMuted,
                              fontWeight: FontWeight.w600, letterSpacing: 1.0,
                            )),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.volume_up, size: 18, color: AppColors.fnT),
                                const SizedBox(width: 10),
                                Text('1 (Tonic)', style: AppTypography.mono(size: 16, color: AppColors.fnT)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text('Listen for the resting point — where does the phrase want to resolve?',
                                textAlign: TextAlign.center,
                                style: AppTypography.body(size: 12.5, color: AppColors.textMuted)),
                          ],
                        ),
                      ),

                    // Next phrase button
                    GestureDetector(
                      onTap: widget.onNextPhrase,
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 18),
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.border),
                        ),
                        alignment: Alignment.center,
                        child: Text('Next Phrase', style: AppTypography.button(size: 14, color: AppColors.textPrimary)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
