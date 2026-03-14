/// A section in the Core Theory chapter (continuous scroll).
class TheorySection {
  final String id;
  final String tab;
  final List<TheoryElement> elements;

  const TheorySection({
    required this.id,
    required this.tab,
    required this.elements,
  });
}

/// Element types available in Core Theory content.
enum TheoryElementType {
  subtitleText,
  text,
  image,
  audioPlay,
  keyPoint,
  sentenceGrid,
  notationTable,
  checklist,
}

/// A content element within a theory section.
class TheoryElement {
  final TheoryElementType type;
  final String? text;
  final String? subtitle;
  final String? title;
  final String? label;
  final String? caption;
  final String? imageSize; // 'full', 'compact', 'transparent'
  final String? imageColor; // gradient start hex
  final List<String>? beats;
  final List<String>? functions;
  final List<String>? chords;
  final List<String>? rowLabels; // optional: ['Beats', 'Function', 'FNH Notes']
  final List<String>? columns; // for notation-table
  final List<List<String>>? rows; // for notation-table
  final List<String>? items; // for checklist

  const TheoryElement({
    required this.type,
    this.text,
    this.subtitle,
    this.title,
    this.label,
    this.caption,
    this.imageSize,
    this.imageColor,
    this.beats,
    this.functions,
    this.chords,
    this.rowLabels,
    this.columns,
    this.rows,
    this.items,
  });
}

/// Next chapter info for the end-of-chapter button.
class NextChapterInfo {
  final int chapterNumber;
  final String title;

  const NextChapterInfo({required this.chapterNumber, required this.title});
}
