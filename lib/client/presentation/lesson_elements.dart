import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/app_theme.dart';
import 'package:leemcwest/client/presentation/fnh_color_resolver.dart';


// ─────────────────────────────────────────────
// Data model for lesson elements
// ─────────────────────────────────────────────

enum LessonElementType {
  text,
  bulletList,
  displayText,
  keyPoint,
  image,
  audioPlay,
  notationTable,
  sentenceGrid,
}

class LessonElement {
  final LessonElementType type;
  final String? text;
  final String? subtitle;
  final String? title;
  final String? label;
  final String? caption;
  final String? imageSize; // 'compact', 'full', 'transparent'
  final List<String>? items;
  final List<List<String>>? rows;
  final List<String>? beats;
  final List<String>? functions;
  final List<String>? chords;

  const LessonElement({
    required this.type,
    this.text,
    this.subtitle,
    this.title,
    this.label,
    this.caption,
    this.imageSize,
    this.items,
    this.rows,
    this.beats,
    this.functions,
    this.chords,
  });
}

// ─────────────────────────────────────────────
// Element renderer — dispatches to the correct widget
// ─────────────────────────────────────────────

class ElementRenderer extends StatelessWidget {
  final LessonElement element;
  const ElementRenderer({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    switch (element.type) {
      case LessonElementType.text:
        return TextBlockWidget(text: element.text ?? '');
      case LessonElementType.bulletList:
        return BulletListWidget(items: element.items ?? []);
      case LessonElementType.displayText:
        return DisplayTextWidget(text: element.text ?? '');
      case LessonElementType.keyPoint:
        return KeyPointWidget(title: element.title ?? '', text: element.text ?? '');
      case LessonElementType.image:
        return ImageBlockWidget(caption: element.caption, size: element.imageSize ?? 'full');
      case LessonElementType.audioPlay:
        return AudioPlayWidget(label: element.label ?? '');
      case LessonElementType.notationTable:
        return NotationTableWidget(label: element.label, rows: element.rows ?? []);
      case LessonElementType.sentenceGrid:
        return SentenceGridWidget(
          label: element.label,
          beats: element.beats ?? [],
          functions: element.functions ?? [],
          chords: element.chords,
        );
    }
  }
}

// ─────────────────────────────────────────────
// TextBlockWidget
// ─────────────────────────────────────────────

class TextBlockWidget extends StatelessWidget {
  final String text;
  const TextBlockWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.elementGap),
      child: Text(text, style: AppTypography.body()),
    );
  }
}

// ─────────────────────────────────────────────
// BulletListWidget
// ─────────────────────────────────────────────

class BulletListWidget extends StatelessWidget {
  final List<String> items;
  const BulletListWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.elementGap),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(item, style: AppTypography.body(size: 15, height: 1.65)),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// DisplayTextWidget
// ─────────────────────────────────────────────

class DisplayTextWidget extends StatelessWidget {
  final String text;
  const DisplayTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.elementGap),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: AppTypography.heading(size: 21, weight: FontWeight.w700)
                .copyWith(letterSpacing: 0.4),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// KeyPointWidget
// ─────────────────────────────────────────────

class KeyPointWidget extends StatelessWidget {
  final String title;
  final String text;
  const KeyPointWidget({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.elementGap),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.calloutBg,
          border: Border.all(color: AppColors.calloutBorder),
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: AppTypography.label(
                    size: 13, weight: FontWeight.w700, color: AppColors.calloutTitle)),
            const SizedBox(height: 8),
            Text(text,
                style: AppTypography.body(size: 14.5, color: AppColors.textPrimary, height: 1.65)),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ImageBlockWidget
// ─────────────────────────────────────────────

class ImageBlockWidget extends StatelessWidget {
  final String? caption;
  final String size; // 'compact', 'full', 'transparent'

  const ImageBlockWidget({super.key, this.caption, required this.size});

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
                child: // In production, replace with Image.network or Image.asset
                    Text('◌ Transparent Image',
                        style: AppTypography.label(size: 12, color: AppColors.textMuted)
                            .copyWith(letterSpacing: 0.8)),
              ),
            )
          else
            Container(
              width: double.infinity,
              height: size == 'compact' ? 140 : 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                border: Border.all(color: AppColors.border),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2A1F3D), Color(0xFF1E1E2A)],
                ),
              ),
              alignment: Alignment.center,
              child: // In production, replace with Image.network or Image.asset
                  Text(
                size == 'compact' ? '◇ Compact Image' : '◆ Full Image',
                style: AppTypography.label(size: 12, color: AppColors.textMuted)
                    .copyWith(letterSpacing: 0.8),
              ),
            ),
          if (caption != null) ...[
            const SizedBox(height: 8),
            Text(caption!,
                style: AppTypography.label(size: 12.5, color: AppColors.textMuted)
                    .copyWith(fontStyle: FontStyle.italic)),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// AudioPlayWidget
// ─────────────────────────────────────────────

class AudioPlayWidget extends StatefulWidget {
  final String label;
  const AudioPlayWidget({super.key, required this.label});

  @override
  State<AudioPlayWidget> createState() => _AudioPlayWidgetState();
}

class _AudioPlayWidgetState extends State<AudioPlayWidget> {
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
              width: 28,
              height: 28,
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
            Expanded(
              child: Text(widget.label,
                  style: AppTypography.label(size: 13, color: AppColors.textSecondary)),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// NotationTableWidget
// ─────────────────────────────────────────────

class NotationTableWidget extends StatelessWidget {
  final String? label;
  final List<List<String>> rows;
  const NotationTableWidget({super.key, this.label, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.elementGap),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(label!, style: AppTypography.label()),
            ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.gridBorder),
            ),
            child: IntrinsicWidth(
              child: Column(
                children: rows.asMap().entries.map((entry) {
                  final ri = entry.key;
                  final row = entry.value;
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.gridBg,
                      border: ri > 0
                          ? const Border(top: BorderSide(color: AppColors.gridBorder))
                          : null,
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: row.asMap().entries.map((cellEntry) {
                          final ci = cellEntry.key;
                          final cell = cellEntry.value;
                          final isArrow = cell == '→' || cell == '=';
                          return Container(
                            constraints: BoxConstraints(minWidth: ci >= 3 ? 100 : 36),
                            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 14),
                            decoration: BoxDecoration(
                              border: ci < row.length - 1
                                  ? const Border(
                                      right: BorderSide(color: AppColors.gridBorder))
                                  : null,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              cell,
                              style: AppTypography.mono(
                                weight: isArrow ? FontWeight.w400 : FontWeight.w600,
                                color: isArrow
                                    ? AppColors.textMuted
                                    : FnhColorResolver.resolve(cell),
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
// SentenceGridWidget
// ─────────────────────────────────────────────

class SentenceGridWidget extends StatefulWidget {
  final String? label;
  final List<String> beats;
  final List<String> functions;
  final List<String>? chords;

  const SentenceGridWidget({
    super.key,
    this.label,
    required this.beats,
    required this.functions,
    this.chords,
  });

  @override
  State<SentenceGridWidget> createState() => _SentenceGridWidgetState();
}

class _SentenceGridWidgetState extends State<SentenceGridWidget> {
  final ScrollController _scrollController = ScrollController();
  bool _canScroll = false;
  bool _scrolledEnd = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkOverflow());
  }

  void _checkOverflow() {
    if (!_scrollController.hasClients) return;
    final canScroll = _scrollController.position.maxScrollExtent > 2;
    final atEnd = _scrollController.offset >=
        _scrollController.position.maxScrollExtent - 4;
    if (canScroll != _canScroll || atEnd != _scrolledEnd) {
      setState(() {
        _canScroll = canScroll;
        _scrolledEnd = atEnd;
      });
    }
  }

  void _onScroll() => _checkOverflow();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cellWidth = widget.beats.length > 9 ? 52.0 : null;
    final totalMinWidth = cellWidth != null ? cellWidth * widget.beats.length : null;

    Widget buildRow(List<String> cells, Color bg,
        {double fontSize = 13,
        FontWeight fontWeight = FontWeight.w600,
        Color Function(String)? colorResolver,
        bool isHeader = false}) {
      return Container(
        color: bg,
        child: Row(
          children: cells.asMap().entries.map((entry) {
            final i = entry.key;
            final cell = entry.value;
            final color = colorResolver != null
                ? colorResolver(cell)
                : (isHeader ? AppColors.textMuted : AppColors.textMuted);
            return Container(
              width: cellWidth,
              constraints: cellWidth == null
                  ? null
                  : BoxConstraints(minWidth: cellWidth),
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
              decoration: BoxDecoration(
                border: i < cells.length - 1
                    ? const Border(right: BorderSide(color: AppColors.gridBorder))
                    : null,
              ),
              alignment: Alignment.center,
              child: Text(
                cell.isEmpty ? '\u00A0' : cell,
                style: AppTypography.mono(
                  size: fontSize,
                  weight: fontWeight,
                  color: color,
                ),
              ),
            );
          }).toList(),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.elementGap),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(widget.label!, style: AppTypography.label()),
            ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.gridBorder),
                ),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: totalMinWidth ?? MediaQuery.of(context).size.width - 48,
                    ),
                    child: IntrinsicWidth(
                      child: Column(
                        children: [
                          // Beat numbers row
                          buildRow(widget.beats, AppColors.gridHeader,
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              isHeader: true),
                          Container(height: 1, color: AppColors.gridBorder),
                          // Functions row
                          buildRow(widget.functions, AppColors.gridBg,
                              colorResolver: (cell) =>
                                  cell == '~' || cell.isEmpty
                                      ? AppColors.textMuted
                                      : FnhColorResolver.resolve(cell)),
                          // Chords row (optional)
                          if (widget.chords != null) ...[
                            Container(height: 1, color: AppColors.gridBorder),
                            buildRow(widget.chords!, AppColors.gridBg,
                                fontSize: 11,
                                fontWeight: FontWeight.w400),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Scroll indicator
              if (_canScroll && !_scrolledEnd)
                Positioned(
                  right: -4,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accentGlow,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.chevron_right,
                          size: 14, color: Colors.white),
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
