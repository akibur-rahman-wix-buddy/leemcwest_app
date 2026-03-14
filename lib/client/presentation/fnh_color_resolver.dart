import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/app_theme.dart';

/// Resolves FNH function labels to their display colour.
///
/// Priority order:
/// 1. D# → purple
/// 2. D♭ → pink
/// 3. S/S# → green
/// 4. T/T# → blue
/// 5. D → red
/// 6. d/d#/holds/neutral → neutral grey
class FnhColorResolver {
  static Color resolve(String? fn) {
    if (fn == null || fn.isEmpty || fn == '~') return AppColors.textMuted;

    // Exact numeric matches
    if (fn == '4#') return AppColors.fnDsharp;
    if (fn == '2♭' || fn == '2b') return AppColors.fnDb;
    if (RegExp(r'^3#?$').hasMatch(fn)) return AppColors.fnT;
    if (RegExp(r'^6#?$').hasMatch(fn)) return AppColors.fnS;
    if (fn == '2') return AppColors.fnD;

    // Functional label matches (priority order)
    if (fn.contains('D#') && !fn.startsWith('d')) return AppColors.fnDsharp;
    if (fn.contains('D♭') || fn.contains('Db')) return AppColors.fnDb;
    if (fn.contains('S#') || fn.contains('S')) return AppColors.fnS;
    if (fn.contains('T#') || fn.contains('T')) return AppColors.fnT;
    if (RegExp(r'(?<![a-z])D(?![#♭b])').hasMatch(fn)) return AppColors.fnD;

    return AppColors.fnNeutral;
  }
}
