import 'package:flutter/material.dart';

/// A case study entry in the list.
class CaseStudy {
  final int id;
  final int tier;
  final String title;
  final String artist;
  final String centre;
  final String? key;
  final String? root;

  const CaseStudy({
    required this.id,
    required this.tier,
    required this.title,
    required this.artist,
    required this.centre,
    this.key,
    this.root,
  });
}

/// A tier grouping for case studies.
class StudyTier {
  final int num;
  final String name;
  final String desc;
  final Color color;
  final List<int> studyIds;

  const StudyTier({
    required this.num,
    required this.name,
    required this.desc,
    required this.color,
    required this.studyIds,
  });
}

/// A single page in the page-by-page study view.
class StudyPage {
  final String group;
  final String title;
  final List<StudyElement> elements;

  const StudyPage({
    required this.group,
    required this.title,
    required this.elements,
  });
}

/// Element types for case study content.
enum StudyElementType {
  text,
  keyPoint,
  image,
  audioPlay,
  studyInfo,
  fnhKeyMap,
  beatGrid,
  compare,
}

/// A content element within a study page.
class StudyElement {
  final StudyElementType type;
  final String? text;
  final String? title;
  final String? label;
  final String? caption;
  final String? imageSize; // 'compact', 'full', 'transparent'
  final List<List<String>>? infoRows; // For study-info
  final String? root; // For fnh-key-map
  final List<String>? notes; // For fnh-key-map
  final int? beats; // For beat-grid
  final List<BeatGridRow>? gridRows; // For beat-grid
  final String? traditional; // For compare
  final String? fnh; // For compare

  const StudyElement({
    required this.type,
    this.text,
    this.title,
    this.label,
    this.caption,
    this.imageSize,
    this.infoRows,
    this.root,
    this.notes,
    this.beats,
    this.gridRows,
    this.traditional,
    this.fnh,
  });
}

/// A row in a beat grid.
class BeatGridRow {
  final String label;
  final List<String> cells;
  final bool bold;
  final String? colorMode; // 'fn' for function colours, or hex string
  final String? shade; // background hex

  const BeatGridRow({
    required this.label,
    required this.cells,
    this.bold = false,
    this.colorMode,
    this.shade,
  });
}

/// FNH Key Map data for the persistent overlay.
class FnhKeyMapData {
  final String root;
  final List<String> notes;

  const FnhKeyMapData({required this.root, required this.notes});

  static const List<String> fnhLabels = [
    '1', '2b', '2', '3', '3#', '4', '4#', '5', '6', '6#', '7', '7#'
  ];

  static const List<String> coreNotes = ['3', '3#', '6', '6#', '2', '4#', '2b'];
}
