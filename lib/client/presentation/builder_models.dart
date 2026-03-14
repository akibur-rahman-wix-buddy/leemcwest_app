/// Represents a single note with octave position.
class NoteEntry {
  final String note;
  final int octave;
  const NoteEntry({required this.note, this.octave = 0});
}

/// Voicing entry for a note within a chord.
class VoicingEntry {
  final String note;
  final int octave;
  const VoicingEntry({required this.note, this.octave = 0});
}

/// A chord placed on a beat within a sentence.
class ChordData {
  final String world;
  final List<String> notes;
  final String leadingCore;
  final int duration;
  final List<VoicingEntry>? voicing;
  final bool hasReframe;

  const ChordData({
    required this.world,
    required this.notes,
    required this.leadingCore,
    this.duration = 1,
    this.voicing,
    this.hasReframe = false,
  });

  ChordData copyWith({int? duration, bool? hasReframe}) => ChordData(
    world: world,
    notes: notes,
    leadingCore: leadingCore,
    duration: duration ?? this.duration,
    voicing: voicing,
    hasReframe: hasReframe ?? this.hasReframe,
  );
}

/// A sentence (8+ beat phrase) containing chords.
class SentenceData {
  final int num;
  final int beatCount;
  final Map<int, ChordData> chords; // beat number → chord

  const SentenceData({
    required this.num,
    this.beatCount = 8,
    this.chords = const {},
  });

  SentenceData copyWith({int? beatCount, Map<int, ChordData>? chords}) => SentenceData(
    num: num,
    beatCount: beatCount ?? this.beatCount,
    chords: chords ?? this.chords,
  );
}

/// Analysis data for a chord (shown in the analysis sheet).
class ChordAnalysis {
  final String world;
  final List<String> notes;
  final int bar;
  final int beat;
  final int sentence;
  final String purity;
  final String regularity;
  final String leadingCore;
  final String? influences;
  final bool hasDSharp;
  final MovementInfo? movementFrom;
  final MovementInfo? movementTo;
  final List<String> skeleton;
  final int skeletonHighlight;
  final String sentenceStatus;
  final String announcement;
  final ReframeInfo? reframe;
  final List<String>? notesFlags;
  final NextMovesInfo? nextMoves;
  final HomeStatusInfo? homeStatus;
  final EnergyInfo? energy;

  const ChordAnalysis({
    required this.world,
    required this.notes,
    required this.bar,
    required this.beat,
    required this.sentence,
    required this.purity,
    required this.regularity,
    required this.leadingCore,
    this.influences,
    this.hasDSharp = false,
    this.movementFrom,
    this.movementTo,
    required this.skeleton,
    required this.skeletonHighlight,
    required this.sentenceStatus,
    required this.announcement,
    this.reframe,
    this.notesFlags,
    this.nextMoves,
    this.homeStatus,
    this.energy,
  });
}

class MovementInfo {
  final String world;
  final String notes;
  final String type;
  const MovementInfo({required this.world, required this.notes, required this.type});
}

class ReframeInfo {
  final String type;
  final String newRef;
  const ReframeInfo({required this.type, required this.newRef});
}

class NextMovesInfo {
  final String state;
  final String? context;
  final List<NextMoveSuggestion> suggestions;
  const NextMovesInfo({required this.state, this.context, required this.suggestions});
}

class NextMoveSuggestion {
  final String label;
  final String impact; // 'decrease', 'increase', 'hold', 'variable'
  final double? confidence;
  const NextMoveSuggestion({required this.label, required this.impact, this.confidence});
}

class HomeStatusInfo {
  final String type;
  final String resolvedTo;
  final int homeBeat;
  const HomeStatusInfo({required this.type, required this.resolvedTo, required this.homeBeat});
}

class EnergyInfo {
  final List<double> curve;
  final double peak;
  final int peakBeat;
  final double avg;
  final String endingState;
  final double currentBeatTension;
  const EnergyInfo({
    required this.curve,
    required this.peak,
    required this.peakBeat,
    required this.avg,
    required this.endingState,
    required this.currentBeatTension,
  });
}

/// A keyboard key mapped from chromatic to FNH.
class KeyboardKey {
  final String label;
  final bool isBlack;
  final String physicalNote;
  const KeyboardKey({required this.label, required this.isBlack, required this.physicalNote});
}

/// Menu item for popup menus.
class MenuItem {
  final String icon;
  final String label;
  final String? sub;
  final bool danger;
  final bool disabled;
  const MenuItem({required this.icon, required this.label, this.sub, this.danger = false, this.disabled = false});
}

/// Library chord chip data.
class LibraryChord {
  final String notes;
  final String world;
  final String? description;
  const LibraryChord({required this.notes, required this.world, this.description});
}
