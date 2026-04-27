import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/app_theme.dart';
import 'package:leemcwest/client/presentation/core_theory_models.dart';
import 'package:leemcwest/client/presentation/fnh_color_resolver.dart';


// ─────────────────────────────────────────────
// Element dispatcher
// ─────────────────────────────────────────────

class TheoryElementRenderer extends StatelessWidget {
  final TheoryElement element;
  const TheoryElementRenderer({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    switch (element.type) {
      case TheoryElementType.subtitleText:
        return _SubtitleTextBlock(subtitle: element.subtitle ?? '', text: element.text ?? '');
      case TheoryElementType.text:
        return _TextBlock(text: element.text ?? '');
      case TheoryElementType.image:
        return _ImageBlock(caption: element.caption, size: element.imageSize ?? 'full', color: element.imageColor);
      case TheoryElementType.audioPlay:
        return _AudioPlayBlock(label: element.label ?? '');
      case TheoryElementType.keyPoint:
        return _KeyPointBlock(title: element.title ?? '', text: element.text ?? '');
      case TheoryElementType.sentenceGrid:
        return TheorySentenceGrid(
          label: element.label,
          beats: element.beats ?? [],
          functions: element.functions ?? [],
          chords: element.chords,
          rowLabels: element.rowLabels,
        );
      case TheoryElementType.notationTable:
        return _NotationTable(label: element.label, rows: element.rows ?? []);
      case TheoryElementType.checklist:
        return _ChecklistBlock(items: element.items ?? []);
    }
  }
}

// ─────────────────────────────────────────────
// SubtitleText — heading + prose (section opener)
// ─────────────────────────────────────────────

class _SubtitleTextBlock extends StatelessWidget {
  final String subtitle;
  final String text;
  const _SubtitleTextBlock({required this.subtitle, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle, style: AppTypography.heading(size: 18).copyWith(letterSpacing: -0.2)),
          const SizedBox(height: 10),
          Text(text, style: AppTypography.body()),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// TextBlock
// ─────────────────────────────────────────────

class _TextBlock extends StatelessWidget {
  final String text;
  const _TextBlock({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Text(text, style: AppTypography.body()),
    );
  }
}

// ─────────────────────────────────────────────
// ImageBlock — full / compact / transparent
// ─────────────────────────────────────────────

class _ImageBlock extends StatelessWidget {
  final String? caption;
  final String size;
  final String? color;
  const _ImageBlock({this.caption, required this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (size == 'transparent')
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border, style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('◌ Transparent Image',
                    style: AppTypography.label(size: 12, color: AppColors.textMuted).copyWith(letterSpacing: 0.8)),
              ),
            )
          else
            Container(
              width: double.infinity,
              height: size == 'compact' ? 140.0 : 220.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color != null ? Color(int.parse(color!.replaceFirst('#', '0xFF'))) : const Color(0xFF2A1F3D),
                    const Color(0xFF1E1E2A),
                  ],
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                size == 'compact' ? '◇ Compact Image' : '◆ Full-Width Image',
                style: AppTypography.label(size: 12, color: AppColors.textMuted).copyWith(letterSpacing: 0.8),
              ),
            ),
          if (caption != null) ...[
            const SizedBox(height: 8),
            Text(caption!, style: AppTypography.label(size: 12.5, color: AppColors.textMuted).copyWith(fontStyle: FontStyle.italic)),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// AudioPlayBlock
// ─────────────────────────────────────────────

class _AudioPlayBlock extends StatefulWidget {
  final String label;
  const _AudioPlayBlock({required this.label});
  @override
  State<_AudioPlayBlock> createState() => _AudioPlayBlockState();
}

class _AudioPlayBlockState extends State<_AudioPlayBlock> {
  bool _playing = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: GestureDetector(
        onTap: () => setState(() => _playing = !_playing),
        child: Row(
          children: [
            Container(
              width: 28, height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _playing ? AppColors.accent : Colors.transparent,
                border: Border.all(color: AppColors.accent, width: 2),
              ),
              child: Icon(
                _playing ? Icons.pause : Icons.play_arrow,
                size: 14,
                color: _playing ? Colors.white : AppColors.accent,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(widget.label, style: AppTypography.label(size: 13, color: AppColors.textSecondary))),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// KeyPointBlock — callout with decorative dots
// ─────────────────────────────────────────────

class _KeyPointBlock extends StatelessWidget {
  final String title;
  final String text;
  const _KeyPointBlock({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.calloutBg,
              border: Border.all(color: AppColors.calloutBorder),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.label(size: 14, weight: FontWeight.w700, color: AppColors.calloutTitle).copyWith(letterSpacing: 0.4)),
                const SizedBox(height: 10),
                Text(text, style: AppTypography.body(size: 15, color: AppColors.textPrimary, height: 1.65)),
              ],
            ),
          ),
          // Decorative dots
          Positioned(
            top: -4, left: 16,
            child: Row(
              children: [
                Container(width: 4, height: 4, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.calloutBorder)),
                const SizedBox(width: 4),
                Container(width: 4, height: 4, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.calloutBorder)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SentenceGrid — with optional row labels + scroll indicator
//
// DEV NOTE: See grid overflow behaviour note.
// If any cell content exceeds standard cell width, the entire
// grid auto-expands and shows the scroll indicator.
// Use LayoutBuilder + TextPainter to measure widest cell.
// ─────────────────────────────────────────────

class TheorySentenceGrid extends StatefulWidget {
  final String? label;
  final List<String> beats;
  final List<String> functions;
  final List<String>? chords;
  final List<String>? rowLabels;

  const TheorySentenceGrid({
    super.key,
    this.label,
    required this.beats,
    required this.functions,
    this.chords,
    this.rowLabels,
  });

  @override
  State<TheorySentenceGrid> createState() => _TheorySentenceGridState();
}

class _TheorySentenceGridState extends State<TheorySentenceGrid> {
  final ScrollController _sc = ScrollController();
  bool _canScroll = false;
  bool _scrolledEnd = false;

  bool get _hasLabels => widget.rowLabels != null && widget.rowLabels!.isNotEmpty;
  bool get _needsScroll => widget.beats.length > 9 || _hasLabels;

  @override
  void initState() {
    super.initState();
    _sc.addListener(_check);
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() {
    if (!_needsScroll || !_sc.hasClients) {
      if (_canScroll) setState(() => _canScroll = false);
      return;
    }
    final can = _sc.position.maxScrollExtent > 2;
    final end = _sc.offset >= _sc.position.maxScrollExtent - 4;
    if (can != _canScroll || end != _scrolledEnd) setState(() { _canScroll = can; _scrolledEnd = end; });
  }

  @override
  void dispose() { _sc.dispose(); super.dispose(); }

  String get _beatLabel => _hasLabels ? (widget.rowLabels![0]) : '';
  String get _funcLabel => _hasLabels ? (widget.rowLabels!.length > 1 ? widget.rowLabels![1] : 'Function') : '';
  String get _chordLabel => _hasLabels && widget.chords != null ? (widget.rowLabels!.length > 2 ? widget.rowLabels![2] : 'Chords') : '';

  Widget _labelCell(String text, {bool topBorder = false}) {
    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.gridHeader,
        border: Border(
          right: const BorderSide(color: AppColors.gridBorder),
          top: topBorder ? const BorderSide(color: AppColors.gridBorder) : BorderSide.none,
        ),
      ),
      alignment: Alignment.centerLeft,
      child: Text(text, style: AppTypography.label(size: 11, color: AppColors.textMuted)),
    );
  }

  Widget _buildRow(List<String> cells, {
    double fontSize = 11,
    FontWeight fontWeight = FontWeight.w400,
    Color? bg,
    Color Function(String)? colorFn,
    bool isHeader = false,
    bool topBorder = false,
  }) {
    return Row(
      children: cells.asMap().entries.map((e) {
        final i = e.key;
        final cell = e.value;
        final color = colorFn != null
            ? colorFn(cell)
            : (cell == '~' || cell.isEmpty ? AppColors.textMuted : AppColors.textPrimary);
        return Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: isHeader ? 7 : 9, horizontal: 4),
            decoration: BoxDecoration(
              color: isHeader ? AppColors.gridHeader : (bg ?? AppColors.gridBg),
              border: Border(
                right: i < cells.length - 1 ? const BorderSide(color: AppColors.gridBorder) : BorderSide.none,
                top: topBorder ? const BorderSide(color: AppColors.gridBorder) : BorderSide.none,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              cell.isEmpty ? '\u00A0' : cell,
              style: AppTypography.mono(
                size: fontSize,
                weight: (fontWeight == FontWeight.w600 && cell != '~' && cell.isNotEmpty) ? FontWeight.w600 : fontWeight,
                color: color,
              ),
              maxLines: 1,
              overflow: TextOverflow.visible,
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(widget.label!, style: AppTypography.label(size: 13, color: AppColors.textSecondary)),
            ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(border: Border.all(color: AppColors.gridBorder)),
                child: Row(
                  children: [
                    // Label column (fixed, non-scrolling)
                    if (_hasLabels)
                      Column(
                        children: [
                          _labelCell(_beatLabel),
                          _labelCell(_funcLabel, topBorder: true),
                          if (widget.chords != null) _labelCell(_chordLabel, topBorder: true),
                        ],
                      ),
                    // Data columns (scrollable when needed)
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _needsScroll ? _sc : null,
                        scrollDirection: Axis.horizontal,
                        physics: _needsScroll ? null : const NeverScrollableScrollPhysics(),
                        child: SizedBox(
                          width: _needsScroll ? widget.beats.length * 48.0 : null,
                          child: IntrinsicWidth(
                            child: Column(
                              children: [
                                _buildRow(widget.beats, fontSize: 11, isHeader: true),
                                _buildRow(
                                  widget.functions,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  topBorder: true,
                                  colorFn: (f) => f == '~' || f.isEmpty ? AppColors.textMuted : FnhColorResolver.resolve(f),
                                ),
                                if (widget.chords != null)
                                  _buildRow(widget.chords!, fontSize: 11, topBorder: true),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Scroll indicator
              if (_canScroll && !_scrolledEnd)
                Positioned(
                  right: -4, top: 0, bottom: 0,
                  child: Center(
                    child: Container(
                      width: 22, height: 22,
                      decoration: const BoxDecoration(
                        color: AppColors.accent, shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: AppColors.accentGlow, blurRadius: 8)],
                      ),
                      child: const Icon(Icons.chevron_right, size: 14, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// NotationTable — compact mapping table
// ─────────────────────────────────────────────

class _NotationTable extends StatelessWidget {
  final String? label;
  final List<List<String>> rows;
  const _NotationTable({this.label, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(label!, style: AppTypography.label(size: 13, color: AppColors.textSecondary)),
            ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.gridBorder),
            ),
            clipBehavior: Clip.antiAlias,
            child: IntrinsicWidth(
              child: Column(
                children: rows.asMap().entries.map((entry) {
                  final ri = entry.key;
                  final row = entry.value;
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.gridBg,
                      border: ri > 0 ? const Border(top: BorderSide(color: AppColors.gridBorder)) : null,
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: row.asMap().entries.map((cellEntry) {
                          final ci = cellEntry.key;
                          final cell = cellEntry.value;
                          final isArrow = cell == '→' || cell == '=';
                          return Container(
                            constraints: const BoxConstraints(minWidth: 50),
                            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 16),
                            decoration: BoxDecoration(
                              border: ci < row.length - 1
                                  ? const Border(right: BorderSide(color: AppColors.gridBorder))
                                  : null,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              cell,
                              style: AppTypography.mono(
                                size: 13,
                                weight: isArrow ? FontWeight.w400 : FontWeight.w600,
                                color: isArrow ? AppColors.textMuted : FnhColorResolver.resolve(cell),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ChecklistBlock — interactive understanding check
// ─────────────────────────────────────────────

class _ChecklistBlock extends StatefulWidget {
  final List<String> items;
  const _ChecklistBlock({required this.items});
  @override
  State<_ChecklistBlock> createState() => _ChecklistBlockState();
}

class _ChecklistBlockState extends State<_ChecklistBlock> {
  final Set<int> _checked = {};

  void _toggle(int i) => setState(() => _checked.contains(i) ? _checked.remove(i) : _checked.add(i));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...widget.items.asMap().entries.map((entry) {
            final i = entry.key;
            final item = entry.value;
            final done = _checked.contains(i);
            return GestureDetector(
              onTap: () => _toggle(i),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: i < widget.items.length - 1
                      ? const Border(bottom: BorderSide(color: AppColors.border))
                      : null,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 20, height: 20, margin: const EdgeInsets.only(top: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: done ? AppColors.success : const Color(0xFF3A3A4D),
                          width: 2,
                        ),
                        color: done ? AppColors.success.withValues(alpha: .1) : Colors.transparent,
                      ),
                      child: done
                          ? const Icon(Icons.check, size: 14, color: AppColors.success)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item,
                        style: AppTypography.body(size: 14.5, height: 1.6,
                          color: done ? AppColors.textMuted : AppColors.textSecondary,
                        ).copyWith(decoration: done ? TextDecoration.lineThrough : null),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 14),
          Text(
            '${_checked.length} of ${widget.items.length} completed',
            style: AppTypography.mono(size: 11, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
