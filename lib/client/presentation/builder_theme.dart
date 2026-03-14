import 'package:flutter/material.dart';

/// World (function) definitions for the Composition Builder.
/// These use slightly different hex values from the lesson FNH colours
/// to match the builder's visual style.
class WorldColors {
  static const Color t = Color(0xFF4A90D9);
  static const Color s = Color(0xFF43A047);
  static const Color d = Color(0xFFE53935);
  static const Color dSharp = Color(0xFF7B1FA2);
  static const Color db = Color(0xFFE91E90);
  static const Color cl = Color(0xFF757575);
  static const Color reframe = Color(0xFFFFA726);

  static Color forWorld(String world) {
    switch (world) {
      case 'T': case 'T#': return t;
      case 'S': case 'S#': return s;
      case 'D': return d;
      case 'D#': return dSharp;
      case 'Db': return db;
      default: return cl;
    }
  }

  static Color withAlpha(Color c, double a) => c.withOpacity(a);
}

/// Core note colours for piano keyboard highlighting.
class CoreColors {
  static const Map<String, Color> map = {
    '3': WorldColors.t,
    '3#': WorldColors.t,
    '6': WorldColors.s,
    '6#': WorldColors.s,
    '2': WorldColors.d,
    '4#': WorldColors.dSharp,
    '2b': WorldColors.db,
  };
  static const Color neutralSelect = Color(0xFF555555);
}

/// Builder-specific colours.
class BuilderColors {
  static const Color bg = Color(0xFF0E0E0E);
  static const Color surface = Color(0xFF141414);
  static const Color surfaceAlt = Color(0xFF161616);
  static const Color card = Color(0xFF1A1A1A);
  static const Color cardAlt = Color(0xFF1E1E1E);
  static const Color border = Color(0xFF222222);
  static const Color borderLight = Color(0xFF333333);
  static const Color borderSubtle = Color(0xFF252525);

  static const Color textPrimary = Color(0xFFEEEEEE);
  static const Color textSecondary = Color(0xFFCCCCCC);
  static const Color textMuted = Color(0xFF999999);
  static const Color textDim = Color(0xFF666666);
  static const Color textFaint = Color(0xFF555555);
  static const Color textDark = Color(0xFF444444);

  static const Color accent = Color(0xFF4A90D9);
  static const Color danger = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA726);
  static const Color success = Color(0xFF43A047);
}

/// Builder typography.
class BuilderTypography {
  static const String fontUI = 'SF Pro Display';
  static const String fontMono = 'JetBrains Mono';

  static TextStyle heading({double size = 14, Color color = BuilderColors.textSecondary}) =>
      TextStyle(fontFamily: fontUI, fontSize: size, fontWeight: FontWeight.w800, color: color, letterSpacing: 1.5);

  static TextStyle mono({double size = 12, FontWeight weight = FontWeight.w600, Color color = BuilderColors.textPrimary}) =>
      TextStyle(fontFamily: fontMono, fontSize: size, fontWeight: weight, color: color);

  static TextStyle label({double size = 11, Color color = BuilderColors.textMuted}) =>
      TextStyle(fontFamily: fontUI, fontSize: size, fontWeight: FontWeight.w500, color: color);

  static TextStyle sectionHeader() =>
      TextStyle(fontFamily: fontMono, fontSize: 9, fontWeight: FontWeight.w700, color: BuilderColors.textFaint, letterSpacing: 1.5);
}

/// Hierarchy orientations.
class Hierarchies {
  static const Map<String, List<String>> sequences = {
    'TSDT': ['T', 'T#', 'S', 'S#', 'D', 'D#', 'Db', '|', 'T', 'T#'],
    'TSDT Rev': ['T#', 'T', 'Db', 'D#', 'D', 'S#', 'S', '|', 'T#', 'T'],
    'TDST': ['T', 'T#', 'D', 'D#', 'Db', 'S', 'S#', '|', 'T', 'T#'],
    'TDST Rev': ['T#', 'T', 'S#', 'S', 'Db', 'D#', 'D', '|', 'T#', 'T'],
  };

  static const Map<String, String> labels = {
    'TSDT': 'TSDT',
    'TSDT Rev': 'TSDT Reverse',
    'TDST': 'TDST',
    'TDST Rev': 'TDST Reverse',
  };
}

/// Chromatic mapping for keyboard.
class ChromaticMap {
  static const List<String> notes = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'];
  static const Set<int> physicalBlack = {1, 3, 6, 8, 10};
  static const List<String> fnhLabels = ['1', '2b', '2', '3', '3#', '4', '4#', '5', '6', '6#', '7', '7#'];
}
