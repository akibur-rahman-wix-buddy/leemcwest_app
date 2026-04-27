import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/app_theme.dart';
import 'package:leemcwest/client/presentation/core_theory_elements.dart';
import 'package:leemcwest/client/presentation/core_theory_models.dart';

/// Core Theory reader screen — continuous scroll with:
/// - Fixed header: back arrow, chapter title, read time, section tabs, progress bar
/// - Scroll-synced tab highlighting and per-section progress
/// - Next Chapter button at the bottom
class CoreTheoryScreen extends StatefulWidget {
  final int chapterNumber;
  final String chapterTitle;
  final List<TheorySection> sections;
  final NextChapterInfo? nextChapter;
  final VoidCallback? onBack;
  final VoidCallback? onNextChapter;

  const CoreTheoryScreen({
    super.key,
    required this.chapterNumber,
    required this.chapterTitle,
    required this.sections,
    this.nextChapter,
    this.onBack,
    this.onNextChapter,
  });

  @override
  State<CoreTheoryScreen> createState() => _CoreTheoryScreenState();
}

class _CoreTheoryScreenState extends State<CoreTheoryScreen> {
  int _activeTab = 0;
  final double _sectionProgress = 0;
  bool _isScrollingFromTap = false;

  final ScrollController _contentScroll = ScrollController();
  final ScrollController _tabScroll = ScrollController();
  final List<GlobalKey> _sectionKeys = [];

  // static const double _headerHeight = 148;
  static const int _totalReadMin = 15;

  @override
  void initState() {
    super.initState();
    _sectionKeys
        .addAll(List.generate(widget.sections.length, (_) => GlobalKey()));
    _contentScroll.addListener(_onContentScroll);
  }

  @override
  void dispose() {
    _contentScroll.dispose();
    _tabScroll.dispose();
    super.dispose();
  }

  double get _overallProgress =>
      ((_activeTab + _sectionProgress) / widget.sections.length).clamp(0, 1);

  int get _minsRemaining =>
      ((_totalReadMin * (1 - _overallProgress)).ceil()).clamp(1, _totalReadMin);

  void _onContentScroll() {
    if (_isScrollingFromTap) return;

    // final scrollTop = _contentScroll.offset + _headerHeight + 40;
    int current = 0;

    for (var i = 0; i < _sectionKeys.length; i++) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox?;
        if (box != null) {
          final pos = box.localToGlobal(Offset.zero,
              ancestor: context.findRenderObject());
          if (pos.dy <= 40) current = i;
        }
      }
    }

    if (current != _activeTab) {
      setState(() => _activeTab = current);
      _scrollTabIntoView(current);
    }
  }

  void _scrollTabIntoView(int index) {
    // In production, measure tab positions and scroll the tab bar
    // to keep the active tab visible.
  }

  void _onTabTap(int index) {
    setState(() {
      _activeTab = index;
      _isScrollingFromTap = true;
    });

    final ctx = _sectionKeys[index].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
        alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
      ).then((_) {
        _isScrollingFromTap = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(
        children: [
          // ── FIXED HEADER ──
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Title row
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap:
                            widget.onBack ?? () => Navigator.maybePop(context),
                        child: const Icon(Icons.arrow_back,
                            color: AppColors.textMuted, size: 22),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: AppTypography.heading(
                                size: 15, weight: FontWeight.w500),
                            children: [
                              TextSpan(
                                  text: 'Chapter ${widget.chapterNumber}: '),
                              TextSpan(
                                text: widget.chapterTitle,
                                style: AppTypography.heading(
                                    size: 15,
                                    weight: FontWeight.w400,
                                    color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Read time
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 10),
                  child: Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.textMuted, width: 1.5),
                        ),
                        child: const Icon(Icons.play_arrow,
                            size: 8, color: AppColors.textMuted),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '$_minsRemaining min remaining',
                        style: AppTypography.mono(
                            size: 11, color: AppColors.textMuted),
                      ),
                    ],
                  ),
                ),

                // Section tabs
                SizedBox(
                  height: 40,
                  child: Stack(
                    children: [
                      ListView.separated(
                        controller: _tabScroll,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        itemCount: widget.sections.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 6),
                        itemBuilder: (context, i) {
                          final isActive = i == _activeTab;
                          final isDone = i < _activeTab;
                          return GestureDetector(
                            onTap: () => _onTabTap(i),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 7),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isActive
                                      ? AppColors.accent
                                      : isDone
                                          ? AppColors.accent
                                              .withValues(alpha: 0.4)
                                          : AppColors.border,
                                  width: 1.5,
                                ),
                                color: isActive
                                    ? AppColors.accentSoft
                                    : isDone
                                        ? AppColors.accent
                                            .withValues(alpha: 0.06)
                                        : Colors.transparent,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (isDone) ...[
                                    Icon(Icons.check,
                                        size: 12,
                                        color: AppColors.accent
                                            .withValues(alpha: 0.7)),
                                    const SizedBox(width: 6),
                                  ],
                                  Text(
                                    widget.sections[i].tab,
                                    style: TextStyle(
                                      fontFamily: AppTypography.fontDisplay,
                                      fontSize: 13,
                                      fontWeight: isActive
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                      color: isActive
                                          ? AppColors.accent
                                          : isDone
                                              ? AppColors.accent
                                                  .withValues(alpha: 0.7)
                                              : AppColors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      // Trailing fade
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          width: 40,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.transparent, AppColors.bg],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Progress bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                  child: Row(
                    children: List.generate(widget.sections.length, (i) {
                      final isDone = i < _activeTab;
                      final isActive = i == _activeTab;
                      double fill = 0;
                      if (isDone) {
                        fill = 1;
                      } else if (isActive) {
                        fill = _sectionProgress.clamp(0.05, 1);
                      }

                      return Expanded(
                        child: Container(
                          height: 3,
                          margin: EdgeInsets.only(
                              right: i < widget.sections.length - 1 ? 3 : 0),
                          decoration: BoxDecoration(
                            color: AppColors.border,
                            borderRadius: BorderRadius.circular(1.5),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: fill,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.accent,
                                borderRadius: BorderRadius.circular(1.5),
                                boxShadow: (isDone || isActive)
                                    ? [
                                        const BoxShadow(
                                            color: AppColors.accentGlow,
                                            blurRadius: 6)
                                      ]
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),

          // ── SCROLLABLE CONTENT ──
          Expanded(
            child: SingleChildScrollView(
              controller: _contentScroll,
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  // Sections
                  ...widget.sections.asMap().entries.map((entry) {
                    final si = entry.key;
                    final section = entry.value;
                    return Container(
                      key: _sectionKeys[si],
                      padding: const EdgeInsets.fromLTRB(24, 28, 24, 12),
                      decoration: BoxDecoration(
                        border: si < widget.sections.length - 1
                            ? const Border(
                                bottom: BorderSide(color: AppColors.border))
                            : null,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: section.elements
                            .map((el) => TheoryElementRenderer(element: el))
                            .toList(),
                      ),
                    );
                  }),

                  // Next Chapter button
                  if (widget.nextChapter != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
                      child: Column(
                        children: [
                          const Divider(color: AppColors.border, height: 1),
                          const SizedBox(height: 24),
                          Text('UP NEXT',
                              style: AppTypography.label(
                                      size: 11, color: AppColors.textMuted)
                                  .copyWith(letterSpacing: 1.0)),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: widget.onNextChapter,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.accent,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppSpacing.buttonRadius)),
                                elevation: 0,
                                shadowColor: AppColors.accentGlow,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Chapter ${widget.nextChapter!.chapterNumber}: ${widget.nextChapter!.title}',
                                    style: AppTypography.button(size: 14),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text('→',
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
