import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/app_theme.dart';
import 'package:leemcwest/client/presentation/lesson_elements.dart';


// ─────────────────────────────────────────────
// Data model for a lesson page
// ─────────────────────────────────────────────

class LessonPage {
  final String group;
  final String title;
  final List<LessonElement> elements;
  const LessonPage({required this.group, required this.title, required this.elements});
}

// ─────────────────────────────────────────────
// LessonScreen
// ─────────────────────────────────────────────

class LessonScreen extends StatefulWidget {
  final String lessonTitle;
  final List<LessonPage> pages;
  final VoidCallback onQuiz;
  final VoidCallback? onExit;

  const LessonScreen({
    super.key,
    required this.lessonTitle,
    required this.pages,
    required this.onQuiz,
    this.onExit,
  });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int _currentPage = 0;
  final ScrollController _scrollController = ScrollController();

  int get _total => widget.pages.length;
  LessonPage get _current => widget.pages[_currentPage];
  LessonPage? get _prev => _currentPage > 0 ? widget.pages[_currentPage - 1] : null;
  LessonPage? get _next =>
      _currentPage < _total - 1 ? widget.pages[_currentPage + 1] : null;

  void _goTo(int page) {
    setState(() => _currentPage = page.clamp(0, _total - 1));
    _scrollController.jumpTo(0);
  }

  /// Build the group-separated dot indicators.
  List<Widget> _buildDots() {
    final dots = <Widget>[];
    for (var i = 0; i < _total; i++) {
      // Add separator between groups
      final isNewGroup = i > 0 && widget.pages[i].group != widget.pages[i - 1].group;
      if (isNewGroup) {
        dots.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Container(width: 1, height: 8, color: AppColors.border),
        ));
      }

      final isCurrent = i == _currentPage;
      final isPast = i < _currentPage;

      dots.add(GestureDetector(
        onTap: () => _goTo(i),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: isCurrent ? 16 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isCurrent || isPast ? AppColors.accent : AppColors.border,
            borderRadius: BorderRadius.circular(3),
          ),
          // Dim completed dots
          foregroundDecoration: isPast && !isCurrent
              ? BoxDecoration(
                  color: Colors.black.withOpacity(0.55),
                  borderRadius: BorderRadius.circular(3),
                )
              : null,
        ),
      ));

      if (i < _total - 1 &&
          !(i + 1 < _total &&
              widget.pages[i + 1].group != widget.pages[i].group)) {
        dots.add(const SizedBox(width: 4));
      }
    }
    return dots;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
                // Row 1: Exit arrow + lesson title
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: widget.onExit ?? () => Navigator.of(context).maybePop(),
                        child: const Icon(Icons.arrow_back,
                            color: AppColors.textMuted, size: 22),
                      ),
                      Expanded(
                        child: Text(
                          widget.lessonTitle,
                          textAlign: TextAlign.center,
                          style: AppTypography.label(
                              size: 13,
                              weight: FontWeight.w500,
                              color: AppColors.textMuted),
                        ),
                      ),
                      const SizedBox(width: 22),
                    ],
                  ),
                ),

                // Row 2: Group label
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    _current.group.toUpperCase(),
                    style: AppTypography.mono(
                      size: 10,
                      color: AppColors.accent,
                      weight: FontWeight.w400,
                    ).copyWith(letterSpacing: 1.0),
                  ),
                ),

                // Row 3: Page title
                Text(_current.title,
                    style: AppTypography.heading(size: 16, weight: FontWeight.w600)),

                // Row 4: Page counter
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'Page ${_currentPage + 1} of $_total',
                    style: AppTypography.mono(
                        size: 10, color: AppColors.textMuted, weight: FontWeight.w400),
                  ),
                ),

                // Progress bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1.5),
                    child: LinearProgressIndicator(
                      value: (_currentPage + 1) / _total,
                      minHeight: 3,
                      backgroundColor: AppColors.border,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(AppColors.accent),
                    ),
                  ),
                ),

                // Page dots
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 0,
                    runSpacing: 4,
                    children: _buildDots(),
                  ),
                ),

                // Divider
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Divider(height: 1, color: AppColors.border),
                ),
              ],
            ),
          ),

          // ── CONTENT ──
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Render all elements for current page
                  ..._current.elements
                      .map((el) => ElementRenderer(element: el)),

                  const SizedBox(height: 8),

                  // ── NAVIGATION BUTTONS ──
                  if (_prev != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => _goTo(_currentPage - 1),
                          icon: const Icon(Icons.arrow_back, size: 16),
                          label: Text(_prev!.title),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textSecondary,
                            side: const BorderSide(color: AppColors.border, width: 1.5),
                            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
                            ),
                            textStyle: AppTypography.label(
                                size: 13, weight: FontWeight.w500,
                                color: AppColors.textSecondary),
                          ),
                        ),
                      ),
                    ),

                  if (_next != null)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _goTo(_currentPage + 1),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
                          ),
                          textStyle: AppTypography.button(size: 14),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Next: ${_next!.title}'),
                            const SizedBox(width: 8),
                            const Text('→', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    )
                  else
                    // Last page — quiz only
                    Column(
                      children: [
                        const SizedBox(height: 8),
                        Text('Lesson Complete',
                            style: AppTypography.heading(size: 16, weight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Text('Take the quiz to test your understanding.',
                            style: AppTypography.body(size: 14)),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: widget.onQuiz,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(AppSpacing.buttonRadius),
                              ),
                              textStyle: AppTypography.button(size: 15),
                            ),
                            child: const Text('Start Quiz'),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
