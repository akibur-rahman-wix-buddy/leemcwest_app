import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/app_theme.dart';
import 'package:leemcwest/client/presentation/case_study_elements.dart';
import 'package:leemcwest/client/presentation/case_study_models.dart';
import 'package:leemcwest/client/presentation/key_map_overlay.dart';

/// Study View screen — page-by-page reader for a case study.
/// Three-level header: study title → group → page title.
/// Persistent KEY MAP button in top-right opens the FNH Key Map overlay.
class StudyViewScreen extends StatefulWidget {
  final String studyTitle;
  final List<StudyPage> pages;
  final FnhKeyMapData keyMapData;
  final VoidCallback onBack;

  const StudyViewScreen({
    super.key,
    required this.studyTitle,
    required this.pages,
    required this.keyMapData,
    required this.onBack,
  });

  @override
  State<StudyViewScreen> createState() => _StudyViewScreenState();
}

class _StudyViewScreenState extends State<StudyViewScreen> {
  int _currentPage = 0;
  bool _showKeyMap = false;
  final ScrollController _scrollController = ScrollController();

  int get _total => widget.pages.length;
  StudyPage get _current => widget.pages[_currentPage];
  StudyPage? get _prev =>
      _currentPage > 0 ? widget.pages[_currentPage - 1] : null;
  StudyPage? get _next =>
      _currentPage < _total - 1 ? widget.pages[_currentPage + 1] : null;

  void _goTo(int page) {
    setState(() => _currentPage = page.clamp(0, _total - 1));
    _scrollController.jumpTo(0);
  }

  /// Build group-separated dot indicators.
  List<Widget> _buildDots() {
    final dots = <Widget>[];
    for (var i = 0; i < _total; i++) {
      final isNewGroup =
          i > 0 && widget.pages[i].group != widget.pages[i - 1].group;
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
          foregroundDecoration: isPast && !isCurrent
              ? BoxDecoration(
                  color: Colors.black.withOpacity(0.55),
                  borderRadius: BorderRadius.circular(3))
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
      body: Stack(
        children: [
          Column(
            children: [
              // ── HEADER ──
              SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    // Row 1: Back + study title + Key Map button
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 12, 0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: widget.onBack,
                            child: const Icon(Icons.arrow_back,
                                color: AppColors.textMuted, size: 22),
                          ),
                          Expanded(
                            child: Text(
                              widget.studyTitle,
                              textAlign: TextAlign.center,
                              style: AppTypography.label(
                                  size: 12,
                                  weight: FontWeight.w500,
                                  color: AppColors.textMuted),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => setState(() => _showKeyMap = true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.accentSoft,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color: AppColors.accent.withOpacity(0.3)),
                              ),
                              child: Text('KEY MAP',
                                  style: AppTypography.mono(
                                      size: 9,
                                      weight: FontWeight.w700,
                                      color: AppColors.accent)),
                            ),
                          ),
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
                                weight: FontWeight.w400)
                            .copyWith(letterSpacing: 1.0),
                      ),
                    ),

                    // Row 3: Page title
                    Text(_current.title,
                        style: AppTypography.heading(
                            size: 16, weight: FontWeight.w600)),

                    // Row 4: Page counter
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'Page ${_currentPage + 1} of $_total',
                        style: AppTypography.mono(
                            size: 10,
                            color: AppColors.textMuted,
                            weight: FontWeight.w400),
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
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.accent),
                        ),
                      ),
                    ),

                    // Page dots
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: _buildDots(),
                      ),
                    ),

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
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ..._current.elements
                          .map((el) => StudyElementRenderer(element: el)),
                      const SizedBox(height: 8),

                      // Previous button
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
                                side: const BorderSide(
                                    color: AppColors.border, width: 1.5),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 20),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppSpacing.buttonRadius)),
                              ),
                            ),
                          ),
                        ),

                      // Next button or completion
                      if (_next != null)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _goTo(_currentPage + 1),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppSpacing.buttonRadius)),
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
                        Column(
                          children: [
                            const SizedBox(height: 8),
                            Text('Study Complete',
                                style: AppTypography.heading(
                                    size: 16, weight: FontWeight.w600)),
                            const SizedBox(height: 8),
                            Text('Return to the study list to explore more.',
                                style: AppTypography.body(size: 14)),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: widget.onBack,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.accent,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppSpacing.buttonRadius)),
                                ),
                                child: const Text('Back to Studies'),
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

          // Key Map overlay
          if (_showKeyMap)
            KeyMapOverlay(
              data: widget.keyMapData,
              onClose: () => setState(() => _showKeyMap = false),
            ),
        ],
      ),
    );
  }
}
