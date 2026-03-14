import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/app_theme.dart';
import 'package:leemcwest/client/presentation/case_study_models.dart';
import 'package:leemcwest/client/presentation/fnh_color_resolver.dart';


// ─────────────────────────────────────────────
// Element dispatcher
// ─────────────────────────────────────────────

class StudyElementRenderer extends StatelessWidget {
  final StudyElement element;
  const StudyElementRenderer({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    switch (element.type) {
      case StudyElementType.text:
        return _TextBlock(text: element.text ?? '');
      case StudyElementType.keyPoint:
        return _KeyPointBlock(title: element.title ?? '', text: element.text ?? '');
      case StudyElementType.image:
        return _ImageBlock(caption: element.caption, size: element.imageSize ?? 'full');
      case StudyElementType.audioPlay:
        return _AudioPlayBlock(label: element.label ?? '');
      case StudyElementType.studyInfo:
        return _StudyInfoBlock(rows: element.infoRows ?? []);
      case StudyElementType.fnhKeyMap:
        return FnhKeyMapWidget(root: element.root ?? '', notes: element.notes ?? []);
      case StudyElementType.beatGrid:
        return BeatGridWidget(label: element.label, rows: element.gridRows ?? []);
      case StudyElementType.compare:
        return _CompareBlock(traditional: element.traditional ?? '', fnh: element.fnh ?? '');
    }
  }
}

// ─────────────────────────────────────────────
// Shared elements (reuse lesson theme tokens)
// ─────────────────────────────────────────────

class _TextBlock extends StatelessWidget {
  final String text;
  const _TextBlock({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.elementGap),
      child: Text(text, style: AppTypography.body()),
    );
  }
}

class _KeyPointBlock extends StatelessWidget {
  final String title;
  final String text;
  const _KeyPointBlock({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.elementGap),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.calloutBg,
          border: Border.all(color: AppColors.calloutBorder),
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTypography.label(size: 13, weight: FontWeight.w700, color: AppColors.calloutTitle)),
            const SizedBox(height: 8),
            Text(text, style: AppTypography.body(size: 14.5, color: AppColors.textPrimary, height: 1.65)),
          ],
        ),
      ),
    );
  }
}

class _ImageBlock extends StatelessWidget {
  final String? caption;
  final String size;
  const _ImageBlock({this.caption, required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.elementGap),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (size == 'transparent')
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border, style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                ),
                child: Text('◌ Transparent Image',
                    style: AppTypography.label(size: 12, color: AppColors.textMuted).copyWith(letterSpacing: 0.8)),
              ),
            )
          else
            Container(
              width: double.infinity,
              height: size == 'compact' ? 140.0 : 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                border: Border.all(color: AppColors.border),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                  colors: [Color(0xFF2A1F3D), Color(0xFF1E1E2A)],
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                size == 'compact' ? '◇ Compact Image' : '◆ Full Image',
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
      padding: const EdgeInsets.only(bottom: AppSpacing.elementGap),
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
// Study Info table
// ─────────────────────────────────────────────

class _StudyInfoBlock extends StatelessWidget {
  final List<List<String>> rows;
  const _StudyInfoBlock({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.elementGap),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          border: Border.all(color: AppColors.gridBorder),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: rows.asMap().entries.map((entry) {
            final i = entry.key;
            final row = entry.value;
            return Container(
              decoration: BoxDecoration(
                border: i < rows.length - 1
                    ? const Border(bottom: BorderSide(color: AppColors.gridBorder))
                    : null,
              ),
              child: Row(
                children: [
                  Container(
                    width: 110,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    color: AppColors.gridHeader,
                    child: Text(row[0], style: AppTypography.label(size: 11, color: AppColors.textMuted)),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      color: AppColors.gridBg,
                      child: Text(row[1], style: AppTypography.label(size: 12, color: AppColors.textPrimary)),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Compare block (Traditional vs FNH)
// ─────────────────────────────────────────────

class _CompareBlock extends StatelessWidget {
  final String traditional;
  final String fnh;
  const _CompareBlock({required this.traditional, required this.fnh});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.elementGap),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          border: Border.all(color: AppColors.gridBorder),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                color: AppColors.gridBg,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('TRADITIONAL',
                        style: AppTypography.label(size: 9, color: AppColors.textMuted)
                            .copyWith(letterSpacing: 1.0, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    Text(traditional, style: AppTypography.body(size: 12.5, height: 1.55)),
                  ],
                ),
              ),
            ),
            Container(width: 1, color: AppColors.gridBorder),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                color: AppColors.gridBg,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('FNH',
                        style: AppTypography.label(size: 9, color: AppColors.accent)
                            .copyWith(letterSpacing: 1.0, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    Text(fnh, style: AppTypography.body(size: 12.5, height: 1.55)),
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

// ─────────────────────────────────────────────
// FNH Key Map with scroll indicator
// ─────────────────────────────────────────────

class FnhKeyMapWidget extends StatefulWidget {
  final String root;
  final List<String> notes;
  final bool showLabel;
  const FnhKeyMapWidget({super.key, required this.root, required this.notes, this.showLabel = true});

  @override
  State<FnhKeyMapWidget> createState() => _FnhKeyMapWidgetState();
}

class _FnhKeyMapWidgetState extends State<FnhKeyMapWidget> {
  final ScrollController _sc = ScrollController();
  bool _canScroll = false;
  bool _scrolledEnd = false;

  @override
  void initState() {
    super.initState();
    _sc.addListener(_check);
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() {
    if (!_sc.hasClients) return;
    final can = _sc.position.maxScrollExtent > 2;
    final end = _sc.offset >= _sc.position.maxScrollExtent - 4;
    if (can != _canScroll || end != _scrolledEnd) setState(() { _canScroll = can; _scrolledEnd = end; });
  }

  @override
  void dispose() { _sc.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.elementGap),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.showLabel)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text('FNH Key Map — Root: ${widget.root}',
                  style: AppTypography.mono(size: 11, color: AppColors.accent)),
            ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.gridBorder),
                ),
                clipBehavior: Clip.antiAlias,
                child: SingleChildScrollView(
                  controller: _sc,
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 480,
                    child: Column(
                      children: [
                        // Note names row
                        Row(
                          children: widget.notes.asMap().entries.map((e) {
                            final i = e.key;
                            return Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.gridHeader,
                                  border: i < 11 ? const Border(right: BorderSide(color: AppColors.gridBorder)) : null,
                                ),
                                alignment: Alignment.center,
                                child: Text(e.value, style: AppTypography.mono(size: 10, weight: FontWeight.w600, color: AppColors.textPrimary)),
                              ),
                            );
                          }).toList(),
                        ),
                        // FNH labels row
                        Row(
                          children: FnhKeyMapData.fnhLabels.asMap().entries.map((e) {
                            final i = e.key;
                            final f = e.value;
                            final isCore = FnhKeyMapData.coreNotes.contains(f);
                            return Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 7),
                                decoration: BoxDecoration(
                                  color: isCore ? AppColors.accent.withOpacity(0.06) : AppColors.gridBg,
                                  border: i < 11 ? const Border(right: BorderSide(color: AppColors.gridBorder)) : null,
                                ),
                                alignment: Alignment.center,
                                child: Text(f, style: AppTypography.mono(
                                  size: 11,
                                  weight: isCore ? FontWeight.w700 : FontWeight.w400,
                                  color: isCore ? AppColors.accent : AppColors.textMuted,
                                )),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (_canScroll && !_scrolledEnd)
                Positioned(
                  right: -4, top: 0, bottom: 0,
                  child: Center(
                    child: Container(
                      width: 22, height: 22,
                      decoration: BoxDecoration(
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
// Beat Grid with scroll indicator + sticky labels
// ─────────────────────────────────────────────

class BeatGridWidget extends StatefulWidget {
  final String? label;
  final List<BeatGridRow> rows;
  const BeatGridWidget({super.key, this.label, required this.rows});

  @override
  State<BeatGridWidget> createState() => _BeatGridWidgetState();
}

class _BeatGridWidgetState extends State<BeatGridWidget> {
  final ScrollController _sc = ScrollController();
  bool _canScroll = false;
  bool _scrolledEnd = false;

  @override
  void initState() {
    super.initState();
    _sc.addListener(_check);
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() {
    if (!_sc.hasClients) return;
    final can = _sc.position.maxScrollExtent > 2;
    final end = _sc.offset >= _sc.position.maxScrollExtent - 4;
    if (can != _canScroll || end != _scrolledEnd) setState(() { _canScroll = can; _scrolledEnd = end; });
  }

  @override
  void dispose() { _sc.dispose(); super.dispose(); }

  Color _cellColor(String cell, BeatGridRow row) {
    if (cell == '~' || cell.isEmpty) return AppColors.textMuted;
    if (row.colorMode == 'fn') return FnhColorResolver.resolve(cell);
    if (row.colorMode != null) {
      try { return Color(int.parse(row.colorMode!.replaceFirst('#', '0xFF'))); } catch (_) {}
    }
    return AppColors.textPrimary;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.elementGap),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(widget.label!, style: AppTypography.mono(size: 11, color: AppColors.textMuted)),
            ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.gridBorder),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: widget.rows.asMap().entries.map((entry) {
                    final ri = entry.key;
                    final row = entry.value;
                    final bgColor = row.shade != null
                        ? Color(int.parse(row.shade!.replaceFirst('#', '0xFF')))
                        : AppColors.gridBg;
                    return Container(
                      decoration: BoxDecoration(
                        border: ri < widget.rows.length - 1
                            ? const Border(bottom: BorderSide(color: AppColors.gridBorder))
                            : null,
                      ),
                      child: Row(
                        children: [
                          // Sticky label
                          Container(
                            width: 80,
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                            color: AppColors.gridHeader,
                            alignment: Alignment.centerLeft,
                            child: Text(row.label, style: AppTypography.label(size: 10, color: AppColors.textMuted)),
                          ),
                          // Scrollable cells
                          Expanded(
                            child: SingleChildScrollView(
                              controller: ri == 0 ? _sc : null,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: row.cells.asMap().entries.map((ce) {
                                  final cell = ce.value;
                                  return Container(
                                    constraints: const BoxConstraints(minWidth: 52),
                                    padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: bgColor,
                                      border: const Border(left: BorderSide(color: AppColors.gridBorder)),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      cell.isEmpty ? '' : cell,
                                      style: AppTypography.mono(
                                        size: row.bold ? 11 : 10,
                                        weight: (row.bold && cell != '~' && cell.isNotEmpty)
                                            ? FontWeight.w700
                                            : FontWeight.w400,
                                        color: _cellColor(cell, row),
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
                  }).toList(),
                ),
              ),
              if (_canScroll && !_scrolledEnd)
                Positioned(
                  right: -4, top: 0, bottom: 0,
                  child: Center(
                    child: Container(
                      width: 22, height: 22,
                      decoration: BoxDecoration(
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
