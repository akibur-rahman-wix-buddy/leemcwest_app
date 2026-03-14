import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/builder_models.dart';
import 'package:leemcwest/client/presentation/builder_theme.dart';

import 'builder_widgets.dart';

/// Full analysis bottom sheet shown on long-press of a chord.
/// Contains: Classification, Movement, Functional Path, Reframe,
/// Notes, Next Moves, Home Status, Energy.
class AnalysisSheet extends StatelessWidget {
  final ChordAnalysis chord;
  final VoidCallback onClose;
  const AnalysisSheet({super.key, required this.chord, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final w = WorldColors.forWorld(chord.world);

    return GestureDetector(
      onTap: onClose,
      child: Container(
        color: Colors.black54,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {}, // absorb taps
            child: Container(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
              decoration: const BoxDecoration(
                color: Color(0xFF161616),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag handle
                  Center(
                    child: Container(
                      width: 36, height: 4, margin: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(color: BuilderColors.bg, borderRadius: BorderRadius.circular(2)),
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(children: [
                            WorldBadge(world: chord.world, large: true),
                            const SizedBox(width: 10),
                            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(chord.notes.join(' '), style: BuilderTypography.mono(size: 14, weight: FontWeight.w700, color: BuilderColors.textPrimary)),
                              Text('Bar ${chord.bar}, Beat ${chord.beat} · Sentence ${chord.sentence}', style: BuilderTypography.label(size: 11, color: BuilderColors.textDim)),
                            ]),
                          ]),
                          const SizedBox(height: 16),

                          // M1: Classification
                          _section('CLASSIFICATION', _gridCard([
                            ['Purity', chord.purity],
                            ['Regularity', chord.regularity],
                            ['Leading Core', '${chord.leadingCore} → ${chord.world}', w],
                            ['Influences', chord.influences ?? 'None'],
                          ], extra: 'd# supporter: ${chord.hasDSharp ? "Yes" : "No"}')),

                          // M2: Movement
                          if (chord.movementFrom != null || chord.movementTo != null)
                            _section('MOVEMENT', _movementRow(chord, w)),

                          // M3: Functional Path
                          _section('FUNCTIONAL PATH', Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(spacing: 4, children: chord.skeleton.asMap().entries.map((e) {
                                final sw = e.value;
                                final highlighted = e.key == chord.skeletonHighlight;
                                final c = WorldColors.forWorld(sw);
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: highlighted ? c.withOpacity(0.2) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Text(sw, style: BuilderTypography.mono(size: 10, weight: FontWeight.w700, color: c)),
                                );
                              }).toList()),
                              const SizedBox(height: 8),
                              _miniGrid([
                                ['Realm', '${chord.skeleton.isNotEmpty ? chord.skeleton[0] : ""} · Beat 1'],
                                ['Sentence Status', chord.sentenceStatus],
                                ['Announcement', chord.announcement],
                              ], statusColor: chord.sentenceStatus == 'Closed' ? BuilderColors.success : BuilderColors.warning),
                            ],
                          )),

                          // M4: Reframe
                          if (chord.reframe != null)
                            _section('REFRAME', _miniGrid([
                              ['Type', chord.reframe!.type],
                              ['New Reference', chord.reframe!.newRef],
                            ], statusColor: BuilderColors.warning)),

                          // M5: Notes
                          if (chord.notesFlags != null && chord.notesFlags!.isNotEmpty)
                            _section('NOTES', Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: chord.notesFlags!.map((n) => Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 8),
                                  decoration: const BoxDecoration(border: Border(left: BorderSide(color: BuilderColors.borderLight, width: 2))),
                                  child: Text(n, style: const TextStyle(fontSize: 11, color: Color(0xFFAAAAAA))),
                                ),
                              )).toList(),
                            )),

                          // M6: Next Moves
                          if (chord.nextMoves != null)
                            _section('NEXT MOVES', Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                  Text('NEXT MOVES', style: BuilderTypography.sectionHeader()),
                                  Text('state: ${chord.nextMoves!.state}', style: const TextStyle(fontSize: 9, color: Color(0xFF888888), fontStyle: FontStyle.italic)),
                                ]),
                                if (chord.nextMoves!.context != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4, bottom: 8),
                                    child: Text(chord.nextMoves!.context!, style: const TextStyle(fontSize: 10, color: Color(0xFF888888), fontStyle: FontStyle.italic)),
                                  ),
                                ...chord.nextMoves!.suggestions.asMap().entries.map((e) {
                                  final i = e.key;
                                  final s = e.value;
                                  const arrows = {'decrease': '↓', 'increase': '↑', 'hold': '→', 'variable': '↕'};
                                  const arrowColors = {'decrease': BuilderColors.success, 'increase': BuilderColors.danger, 'hold': BuilderColors.warning, 'variable': BuilderColors.accent};
                                  return Container(
                                    padding: const EdgeInsets.symmetric(vertical: 6),
                                    decoration: BoxDecoration(border: i < chord.nextMoves!.suggestions.length - 1 ? const Border(bottom: BorderSide(color: BuilderColors.borderSubtle)) : null),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(children: [
                                          SizedBox(width: 14, child: Text('${i + 1}.', style: const TextStyle(fontSize: 10, color: BuilderColors.textFaint, fontWeight: FontWeight.w600))),
                                          const SizedBox(width: 6),
                                          Text(s.label, style: const TextStyle(fontSize: 11, color: BuilderColors.textSecondary)),
                                        ]),
                                        Text(arrows[s.impact] ?? '', style: TextStyle(fontSize: 14, color: arrowColors[s.impact] ?? const Color(0xFF888888))),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ), skipHeader: true),

                          // M7: Home Status
                          if (chord.homeStatus != null)
                            _section('HOME STATUS', _miniGrid([
                              ['Type', chord.homeStatus!.type],
                              ['Resolved to', chord.homeStatus!.resolvedTo],
                              ['Beat', '${chord.homeStatus!.homeBeat}'],
                            ], resolvedColor: WorldColors.forWorld(chord.homeStatus!.resolvedTo))),

                          // M8: Energy
                          if (chord.energy != null)
                            _section('ENERGY', Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                  Text('ENERGY', style: BuilderTypography.sectionHeader()),
                                  Text(chord.energy!.endingState, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: chord.energy!.endingState == 'Resolved' ? BuilderColors.success : BuilderColors.warning)),
                                ]),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 32,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: chord.energy!.curve.asMap().entries.map((e) {
                                      final i = e.key;
                                      final v = e.value;
                                      final n = v / 10;
                                      final col = n <= 0.3 ? BuilderColors.success : n <= 0.6 ? BuilderColors.warning : BuilderColors.danger;
                                      final isActive = i == chord.beat - 1;
                                      return Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 1.5),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              if (isActive) Container(width: 4, height: 4, decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                                              const SizedBox(height: 2),
                                              Container(
                                                height: (n * 32).clamp(3, 32),
                                                decoration: BoxDecoration(
                                                  color: col.withOpacity(isActive ? 1 : 0.6),
                                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
                                                  border: isActive ? Border.all(color: col) : null,
                                                ),
                                              ),
                                              Text('${i + 1}', style: const TextStyle(fontSize: 8, color: BuilderColors.textFaint)),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                _miniGrid([
                                  ['Peak', '${chord.energy!.peak} (beat ${chord.energy!.peakBeat})'],
                                  ['Average', '${chord.energy!.avg}'],
                                  ['This beat', '${chord.energy!.currentBeatTension}'],
                                ]),
                              ],
                            ), skipHeader: true),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _section(String title, Widget content, {bool skipHeader = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: BuilderColors.cardAlt,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!skipHeader) ...[
              Text(title, style: BuilderTypography.sectionHeader()),
              const SizedBox(height: 8),
            ],
            content,
          ],
        ),
      ),
    );
  }

  Widget _gridCard(List<List<dynamic>> items, {String? extra}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: items.map((item) {
            final label = item[0] as String;
            final value = item[1] as String;
            final color = item.length > 2 ? item[2] as Color : BuilderColors.textPrimary;
            return SizedBox(
              width: 140,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(label, style: const TextStyle(fontSize: 12, color: BuilderColors.textDim)),
                Text(value, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
              ]),
            );
          }).toList(),
        ),
        if (extra != null) ...[
          const SizedBox(height: 8),
          Text(extra, style: const TextStyle(fontSize: 11, color: BuilderColors.textDim)),
        ],
      ],
    );
  }

  Widget _miniGrid(List<List<String>> items, {Color? statusColor, Color? resolvedColor}) {
    return Wrap(
      spacing: 16,
      runSpacing: 6,
      children: items.map((item) {
        Color valueColor = BuilderColors.textPrimary;
        if (item[0] == 'Sentence Status' && statusColor != null) valueColor = statusColor;
        if (item[0] == 'Resolved to' && resolvedColor != null) valueColor = resolvedColor;
        if (item[0] == 'Type' && statusColor != null) valueColor = statusColor;
        return SizedBox(
          width: 140,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(item[0], style: const TextStyle(fontSize: 11, color: BuilderColors.textDim)),
            Text(item[1], style: TextStyle(fontSize: 11, color: valueColor, fontWeight: FontWeight.w600)),
          ]),
        );
      }).toList(),
    );
  }

  Widget _movementRow(ChordAnalysis chord, Color w) {
    return Row(
      children: [
        if (chord.movementFrom != null) ...[
          Expanded(child: Column(children: [
            WorldBadge(world: chord.movementFrom!.world),
            const SizedBox(height: 4),
            Text(chord.movementFrom!.notes, style: BuilderTypography.mono(size: 10, color: const Color(0xFF777777))),
          ])),
          Expanded(flex: 2, child: Column(children: [
            Container(height: 1, color: w),
            const SizedBox(height: 2),
            Text('→ ${chord.movementFrom!.type}', style: TextStyle(fontSize: 9, color: w, fontWeight: FontWeight.w600)),
          ])),
        ],
        Expanded(child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: w.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: w.withOpacity(0.27)),
          ),
          child: Column(children: [
            WorldBadge(world: chord.world),
            const SizedBox(height: 4),
            Text(chord.notes.join(' '), style: BuilderTypography.mono(size: 10, weight: FontWeight.w700, color: BuilderColors.textPrimary)),
          ]),
        )),
        if (chord.movementTo != null) ...[
          Expanded(flex: 2, child: Column(children: [
            Container(height: 1, color: WorldColors.forWorld(chord.movementTo!.world)),
            const SizedBox(height: 2),
            Text('→ ${chord.movementTo!.type}', style: TextStyle(fontSize: 9, color: WorldColors.forWorld(chord.movementTo!.world), fontWeight: FontWeight.w600)),
          ])),
          Expanded(child: Column(children: [
            WorldBadge(world: chord.movementTo!.world),
            const SizedBox(height: 4),
            Text(chord.movementTo!.notes, style: BuilderTypography.mono(size: 10, color: const Color(0xFF777777))),
          ])),
        ],
      ],
    );
  }
}

extension on BuilderColors {
  static const Color borderDark = Color(0xFF444444);
  static const Color borderSubtle = Color(0xFF252525);
}
