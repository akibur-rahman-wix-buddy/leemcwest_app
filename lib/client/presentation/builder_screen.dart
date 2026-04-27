import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/builder_models.dart';
import 'package:leemcwest/client/presentation/builder_theme.dart';
import 'package:leemcwest/client/presentation/builder_widgets.dart';

/// The main Composition Builder screen.
/// Contains: header, config row, hierarchy bar, beat ruler,
/// sentence rows, input panel (Notes/Functions/Library), playback bar.
///
/// State management is kept minimal here — in production, use
/// Riverpod/Bloc/Provider as appropriate.
class BuilderScreen extends StatefulWidget {
  const BuilderScreen({super.key});

  @override
  State<BuilderScreen> createState() => _BuilderScreenState();
}

class _BuilderScreenState extends State<BuilderScreen> {
  String _activeBeat = ''; // "sentIdx-beat"
  final List<NoteEntry> _selectedNotes = [];
  int _currentOctave = 0;
  final String _selectedRoot = 'C#';
  String _activeFunc = 'S#';
  String _inputMode = 'Notes'; // Notes, Functions, Library
  final String _hierarchyMode = 'TSDT';
  bool _showEnergyLane = false;

  // Mock sentence data
  late List<SentenceData> _sentences;

  @override
  void initState() {
    super.initState();
    _sentences = [
      const SentenceData(num: 1, beatCount: 8, chords: {
        1: ChordData(
            world: 'T#', notes: ['1', '3#', '5'], leadingCore: '3#'),
        5: ChordData(
            world: 'S#', notes: ['4', '6#', '1'], leadingCore: '6#'),
        7: ChordData(
            world: 'D', notes: ['5', '7#', '2'], leadingCore: '2'),
      }),
      const SentenceData(num: 2, beatCount: 8, chords: {
        1: ChordData(
            world: 'T#',
            notes: ['1', '3#', '5'],
            leadingCore: '3#',
            duration: 2),
        5: ChordData(
            world: 'S#', notes: ['4', '6#', '1'], leadingCore: '6#'),
        7: ChordData(
            world: 'D', notes: ['5', '7#', '2'], leadingCore: '2', duration: 2),
      }),
      const SentenceData(num: 3, beatCount: 8, chords: {
        1: ChordData(
            world: 'Db',
            notes: ['2b', '4', '6'],
            leadingCore: '2b',
            hasReframe: true),
        7: ChordData(
            world: 'Db', notes: ['4#', '2b', '7'], leadingCore: '2b'),
      }),
      const SentenceData(num: 4, beatCount: 12, chords: {
        1: ChordData(
            world: 'T#', notes: ['1', '3#', '5'], leadingCore: '3#'),
        3: ChordData(
            world: 'S#', notes: ['4', '6#', '1'], leadingCore: '6#'),
        5: ChordData(
            world: 'D', notes: ['5', '7#', '2'], leadingCore: '2'),
        7: ChordData(
            world: 'D#', notes: ['4#', '7', '2'], leadingCore: '4#'),
        9: ChordData(
            world: 'Db', notes: ['2b', '4', '6'], leadingCore: '2b'),
        11: ChordData(
            world: 'T#', notes: ['1', '3#', '5'], leadingCore: '3#'),
      }),
    ];
  }

  // Mock energy data per sentence
  final Map<int, List<double>> _energyData = {
    0: [2.0, 2.0, 2.0, 4.5, 4.5, 7.0, 7.0, 2.0],
    1: [2.0, 2.0, 6.0, 6.0, 4.0, 4.0, 6.0, 6.0],
    2: [9.0, 9.0, 9.0, 9.0, 9.0, 9.0, 9.0, 9.0],
    3: [2.0, 2.0, 4.5, 4.5, 7.0, 7.0, 8.5, 8.5, 9.5, 9.5, 2.0, 2.0],
  };

  List<KeyboardKey> get _keyboardKeys {
    final rootIndex = ChromaticMap.notes.indexOf(_selectedRoot);
    return ChromaticMap.fnhLabels.asMap().entries.map((e) {
      final i = e.key;
      final label = e.value;
      final physicalIndex = (rootIndex + i) % 12;
      return KeyboardKey(
        label: label,
        isBlack: ChromaticMap.physicalBlack.contains(physicalIndex),
        physicalNote: ChromaticMap.notes[physicalIndex],
      );
    }).toList();
  }

  Set<String> get _noteSet => _selectedNotes.map((n) => n.note).toSet();

  void _toggleNote(String n) {
    setState(() {
      final idx = _selectedNotes.indexWhere((x) => x.note == n);
      if (idx >= 0) {
        _selectedNotes.removeAt(idx);
      } else {
        _selectedNotes.add(NoteEntry(note: n, octave: _currentOctave));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BuilderColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFF1A1A1A)))),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      child: const Text('‹',
                          style: TextStyle(
                              color: BuilderColors.textFaint, fontSize: 20))),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Text('COMPOSITION BUILDER',
                          style: BuilderTypography.heading())),
                  const Text('↩',
                      style: TextStyle(
                          color: BuilderColors.textFaint, fontSize: 13)),
                  const SizedBox(width: 14),
                  const Text('↪',
                      style: TextStyle(
                          color: BuilderColors.textFaint, fontSize: 13)),
                  const SizedBox(width: 14),
                  const Text('⋮',
                      style: TextStyle(
                          color: BuilderColors.textFaint, fontSize: 16)),
                ],
              ),
            ),

            // ── Config row ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                children: [
                  _configChip('Root $_selectedRoot'),
                  _configChip('BPM 90'),
                  _configChip('🔊'),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                          color: BuilderColors.card,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text('TSDT ▾',
                          style: TextStyle(
                              fontSize: 11,
                              color: BuilderColors.accent,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () =>
                        setState(() => _showEnergyLane = !_showEnergyLane),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _showEnergyLane
                            ? BuilderColors.accent.withValues(alpha: 0.13)
                            : BuilderColors.card,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: _showEnergyLane
                                ? BuilderColors.accent.withValues(alpha: 0.27)
                                : Colors.transparent),
                      ),
                      child: Text('∿',
                          style: TextStyle(
                              fontSize: 13,
                              color: _showEnergyLane
                                  ? BuilderColors.accent
                                  : BuilderColors.textDim,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),

            // ── Hierarchy bar ──
            HierarchyBar(mode: _hierarchyMode),

            // ── Beat ruler ──
            BeatRuler(
              activeBeat: _activeBeat.isNotEmpty
                  ? int.tryParse(_activeBeat.split('-').last)
                  : null,
              beatCount: _activeBeat.isNotEmpty
                  ? (_sentences[int.tryParse(_activeBeat.split('-').first) ?? 0]
                      .beatCount)
                  : 8,
              onBeatTap: (b) => setState(() {
                final si =
                    _activeBeat.isNotEmpty ? _activeBeat.split('-').first : '0';
                _activeBeat = '$si-$b';
              }),
            ),

            // ── Sentences ──
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _sentences.asMap().entries.map((e) {
                    final si = e.key;
                    final sent = e.value;
                    return _buildSentence(sent, si);
                  }).toList(),
                ),
              ),
            ),

            // ── Input Panel ──
            Container(
              decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: BuilderColors.border))),
              child: Column(
                children: [
                  // Mode tabs
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                    child: Row(
                      children: ['Notes', 'Functions', 'Library'].map((m) {
                        final active = m == _inputMode;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _inputMode = m),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: active
                                    ? BuilderColors.accent
                                    : BuilderColors.card,
                                borderRadius: m == 'Notes'
                                    ? const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8))
                                    : m == 'Library'
                                        ? const BorderRadius.only(
                                            topRight: Radius.circular(8),
                                            bottomRight: Radius.circular(8))
                                        : null,
                              ),
                              alignment: Alignment.center,
                              child: Text(m,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: active
                                          ? FontWeight.w700
                                          : FontWeight.w400,
                                      color: active
                                          ? Colors.white
                                          : BuilderColors.textDim)),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  // Notes keyboard
                  if (_inputMode == 'Notes')
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 12, 4, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 24),
                            child: OctaveStrip(
                                current: _currentOctave,
                                onChange: (v) =>
                                    setState(() => _currentOctave = v)),
                          ),
                          ..._keyboardKeys.map((k) => PianoKey(
                                label: k.label,
                                isBlack: k.isBlack,
                                isSelected: _noteSet.contains(k.label),
                                onTap: () => _toggleNote(k.label),
                              )),
                        ],
                      ),
                    ),

                  // Functions tab
                  if (_inputMode == 'Functions')
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Wrap(
                              spacing: 6,
                              children: ['T', 'T#', 'S', 'S#', 'D', 'D#', 'Db']
                                  .map(
                                    (f) => FuncBtn(
                                        label: f,
                                        isActive: _activeFunc == f,
                                        onTap: () =>
                                            setState(() => _activeFunc = f)),
                                  )
                                  .toList()),
                          const SizedBox(height: 12),
                          Text('Chords for $_activeFunc:',
                              style: BuilderTypography.label(
                                  size: 11, color: BuilderColors.textFaint)),
                          const SizedBox(height: 6),
                          ...[
                            '4 6# 1|Natural triad',
                            '6# 1 3#|With tonic colour',
                            '3# 6# 1|Tonic overlap'
                          ].map((c) {
                            final parts = c.split('|');
                          //  final w = WorldColors.forWorld(_activeFunc);
                            return Container(
                              margin: const EdgeInsets.only(bottom: 6),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: BuilderColors.surface,
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: BuilderColors.cardAlt),
                              ),
                              child: Row(children: [
                                Text(parts[0],
                                    style: BuilderTypography.mono(
                                        size: 14,
                                        weight: FontWeight.w700,
                                        color: BuilderColors.textSecondary)),
                                const SizedBox(width: 12),
                                Text(parts[1],
                                    style: const TextStyle(
                                        fontSize: 10,
                                        color: BuilderColors.textDim)),
                              ]),
                            );
                          }),
                        ],
                      ),
                    ),

                  // Library tab
                  if (_inputMode == 'Library')
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Wrap(
                              spacing: 4,
                              children: [
                                'All',
                                'T',
                                'T#',
                                'S',
                                'S#',
                                'D',
                                'D#',
                                'Db'
                              ].map((f) {
                                final active = f == 'S#';
                                final w = WorldColors.forWorld(f);
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  decoration: BoxDecoration(
                                      color: active ? w : BuilderColors.card,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Text(f,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: active ? Colors.white : w)),
                                );
                              }).toList()),
                          const SizedBox(height: 8),
                          Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: [
                                const LibraryChip(notes: '4 6# 1', world: 'S#'),
                                const LibraryChip(
                                    notes: '6# 1 3#', world: 'S#'),
                                const LibraryChip(
                                    notes: '3# 6# 1', world: 'S#'),
                                const LibraryChip(
                                    notes: '6# 2 4#', world: 'D#'),
                                const LibraryChip(
                                    notes: '4 6# 2b', world: 'Db'),
                                const LibraryChip(notes: '6# 1 4', world: 'S#'),
                              ]
                                  .map((c) => SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  28) /
                                              3,
                                      child: c))
                                  .toList()),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // ── Playback bar ──
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Color(0xFF1A1A1A)))),
              child: Row(
                children: [
                  const Text('⏮',
                      style: TextStyle(
                          fontSize: 14, color: BuilderColors.textFaint)),
                  const SizedBox(width: 16),
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                        color: BuilderColors.accent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: BuilderColors.accent.withValues(alpha: 0.27),
                              blurRadius: 12)
                        ]),
                    alignment: Alignment.center,
                    child: const Text('▶',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                  const SizedBox(width: 16),
                  const Text('🔁',
                      style: TextStyle(
                          fontSize: 13, color: BuilderColors.textFaint)),
                  const Spacer(),
                  Text('S1 · Bar 2 · Beat 5',
                      style: BuilderTypography.mono(
                          size: 11, color: BuilderColors.textFaint)),
                  const SizedBox(width: 12),
                  const Text('90',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: BuilderColors.textDim)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _configChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
            color: BuilderColors.card, borderRadius: BorderRadius.circular(8)),
        child: Text(label,
            style: BuilderTypography.label(
                size: 11, color: BuilderColors.textMuted)),
      ),
    );
  }

  Widget _buildSentence(SentenceData sent, int si) {
    final bc = sent.beatCount;
    final isExtended = bc > 8;
    final coveredBeats = <int>{};
    for (final entry in sent.chords.entries) {
      for (var i = 1; i < entry.value.duration; i++) {
        coveredBeats.add(entry.key + i);
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.only(bottom: 6, top: 2),
      decoration: BoxDecoration(
        color: si.isEven ? BuilderColors.surface : BuilderColors.surfaceAlt,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          SentenceHeader(num: sent.num, beatCount: bc, isExtended: isExtended),
          if (_showEnergyLane && _energyData.containsKey(si))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: EnergyLane(data: _energyData[si]!),
            ),
          SingleChildScrollView(
            scrollDirection: isExtended ? Axis.horizontal : Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                mainAxisAlignment: isExtended
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: List.generate(bc, (i) {
                  final b = i + 1;
                  if (coveredBeats.contains(b)) return const SizedBox.shrink();
                  final chord = sent.chords[b];
                  final beatKey = '$si-$b';
                  return Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: ChordCell(
                      chord: chord,
                      isEmpty: chord == null,
                      isActive: _activeBeat == beatKey,
                      isPendingTarget:
                          _activeBeat == beatKey && _selectedNotes.isNotEmpty,
                      onTap: () => setState(() => _activeBeat = beatKey),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
