import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/builder_models.dart';
import 'package:leemcwest/client/presentation/builder_theme.dart';



// ─────────────────────────────────────────────
// WorldBadge — coloured function label
// ─────────────────────────────────────────────

class WorldBadge extends StatelessWidget {
  final String world;
  final bool large;
  const WorldBadge({super.key, required this.world, this.large = false});

  @override
  Widget build(BuildContext context) {
    final color = WorldColors.forWorld(world);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: large ? 12 : 6,
        vertical: large ? 4 : 2,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        world,
        style: BuilderTypography.mono(
          size: large ? 13 : 10,
          weight: FontWeight.w700,
          color: Colors.white,
        ).copyWith(letterSpacing: 0.5),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// OctaveLines — small lines above/below note
// ─────────────────────────────────────────────

class OctaveLines extends StatelessWidget {
  final int octave;
  final double lineWidth;
  const OctaveLines({super.key, required this.octave, this.lineWidth = 6});

  @override
  Widget build(BuildContext context) {
    if (octave == 0) return const SizedBox.shrink();
    final count = octave.abs();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (_) => Container(
        width: lineWidth,
        height: 1,
        margin: const EdgeInsets.only(bottom: 1),
        color: BuilderColors.textMuted,
      )),
    );
  }
}

// ─────────────────────────────────────────────
// ChordCell — single beat in the sentence grid
// ─────────────────────────────────────────────

class ChordCell extends StatelessWidget {
  final ChordData? chord;
  final bool isEmpty;
  final bool isActive;
  final bool isPendingTarget;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDragHandle;

  const ChordCell({
    super.key,
    this.chord,
    this.isEmpty = false,
    this.isActive = false,
    this.isPendingTarget = false,
    this.onTap,
    this.onLongPress,
    this.onDragHandle,
  });

  @override
  Widget build(BuildContext context) {
    if (isEmpty || chord == null) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 42,
          height: 60,
          decoration: BoxDecoration(
            color: isPendingTarget
                ? const Color(0xFF1A2A1A)
                : isActive
                    ? BuilderColors.cardAlt
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: isPendingTarget
                  ? WorldColors.s
                  : isActive
                      ? BuilderColors.borderLight
                      : Colors.transparent,
              width: isPendingTarget ? 1.5 : 1,
              // Use dashed for pending (simulated with decoration)
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            isPendingTarget ? '+' : '~',
            style: TextStyle(
              color: isPendingTarget ? WorldColors.s : const Color(0xFF3A3A3A),
              fontSize: isPendingTarget ? 18 : 16,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      );
    }

    final c = chord!;
    final w = WorldColors.forWorld(c.world);
    final cellWidth = 42.0 * c.duration + (c.duration - 1) * 3;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: cellWidth,
            height: 60,
            padding: const EdgeInsets.fromLTRB(5, 4, 3, 8),
            decoration: BoxDecoration(
              color: w.withOpacity(0.12),
              borderRadius: BorderRadius.circular(6),
              border: Border(
                left: BorderSide(color: w, width: 3),
                top: isActive ? BorderSide(color: w, width: 1.5) : BorderSide.none,
                right: isActive ? BorderSide(color: w, width: 1.5) : BorderSide.none,
                bottom: isActive ? BorderSide(color: w, width: 1.5) : BorderSide.none,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WorldBadge(world: c.world),
                Wrap(
                  spacing: 3,
                  children: c.notes.asMap().entries.map((entry) {
                    final i = entry.key;
                    final n = entry.value;
                    final isCore = n == c.leadingCore;
                    return Text(
                      n,
                      style: BuilderTypography.mono(
                        size: 9,
                        weight: isCore ? FontWeight.w800 : FontWeight.w400,
                        color: isCore ? Colors.white : BuilderColors.textMuted,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          // Reframe indicator
          if (c.hasReframe)
            Positioned(
              top: -3,
              right: -3,
              child: Transform.rotate(
                angle: 0.785, // 45 degrees
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: BuilderColors.warning,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          // Duration drag handle
          if (isActive)
            Positioned(
              right: -2,
              top: 0,
              bottom: 0,
              child: Center(
                child: GestureDetector(
                  onHorizontalDragStart: (_) => onDragHandle?.call(),
                  child: Container(
                    width: 6,
                    height: 24,
                    decoration: BoxDecoration(
                      color: w.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Workaround: add borderDim to BuilderColors
extension BuilderColorsExt on BuilderColors {
  static const Color borderDim = Color(0xFF444444);
}

// ─────────────────────────────────────────────
// BeatRuler — beat numbers above sentence
// ─────────────────────────────────────────────

class BeatRuler extends StatelessWidget {
  final int? activeBeat;
  final int beatCount;
  final ValueChanged<int>? onBeatTap;
  const BeatRuler({super.key, this.activeBeat, this.beatCount = 8, this.onBeatTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: beatCount > 8 ? Axis.horizontal : Axis.vertical,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(beatCount, (i) {
          final b = i + 1;
          final strong = b.isOdd;
          final active = b == activeBeat;
          return GestureDetector(
            onTap: () => onBeatTap?.call(b),
            child: SizedBox(
              width: beatCount > 8 ? 36 : 42,
              child: Center(
                child: Container(
                  width: 26,
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  decoration: BoxDecoration(
                    color: active ? BuilderColors.accent : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$b',
                    style: BuilderTypography.mono(
                      size: strong ? 12 : 10,
                      weight: strong ? FontWeight.w700 : FontWeight.w400,
                      color: active
                          ? Colors.white
                          : strong
                              ? const Color(0xFF888888)
                              : BuilderColors.textFaint,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// OctaveStrip — octave selector left of keyboard
// ─────────────────────────────────────────────

class OctaveStrip extends StatelessWidget {
  final int current;
  final ValueChanged<int> onChange;
  const OctaveStrip({super.key, required this.current, required this.onChange});

  @override
  Widget build(BuildContext context) {
    final positions = [2, 1, 0, -1, -2];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: current < 2 ? () => onChange(current + 1) : null,
          child: SizedBox(
            width: 30,
            height: 24,
            child: Center(
              child: Text('▲',
                  style: TextStyle(
                      fontSize: 14, color: current < 2 ? const Color(0xFF888888) : BuilderColors.borderLight)),
            ),
          ),
        ),
        ...positions.map((oct) {
          final isActive = current == oct;
          final count = oct.abs();
          return GestureDetector(
            onTap: () => onChange(oct),
            child: Container(
              width: 30,
              height: 22,
              margin: const EdgeInsets.symmetric(vertical: 1.5),
              decoration: BoxDecoration(
                color: isActive ? BuilderColors.accent : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: oct == 0
                  ? Text('·',
                      style: TextStyle(
                          fontSize: 8,
                          color: isActive ? Colors.white : BuilderColors.textFaint,
                          fontWeight: FontWeight.w700))
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        count,
                        (_) => Container(
                          width: 12,
                          height: 1.5,
                          margin: const EdgeInsets.symmetric(vertical: 1),
                          decoration: BoxDecoration(
                            color: isActive ? Colors.white : BuilderColors.textFaint,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),
                    ),
            ),
          );
        }),
        GestureDetector(
          onTap: current > -2 ? () => onChange(current - 1) : null,
          child: SizedBox(
            width: 30,
            height: 24,
            child: Center(
              child: Text('▼',
                  style: TextStyle(
                      fontSize: 14, color: current > -2 ? const Color(0xFF888888) : BuilderColors.borderLight)),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// PianoKey — single key on the FNH keyboard
// ─────────────────────────────────────────────

class PianoKey extends StatelessWidget {
  final String label;
  final bool isBlack;
  final bool isSelected;
  final VoidCallback? onTap;
  const PianoKey({super.key, required this.label, this.isBlack = false, this.isSelected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    final coreColor = CoreColors.map[label];
    final selectColor = isSelected ? (coreColor ?? CoreColors.neutralSelect) : null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isBlack ? 30 : 38,
        height: isBlack ? 75 : 110,
        margin: EdgeInsets.only(
          left: isBlack ? -15 : 0,
          right: isBlack ? -15 : 0,
        ),
        decoration: BoxDecoration(
          color: selectColor ?? (isBlack ? const Color(0xFF1A1A1A) : const Color(0xFFF0F0F2)),
          border: Border.all(color: isBlack ? const Color(0xFF2A2A2A) : const Color(0xFFD0D0D0)),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(6),
            bottomRight: Radius.circular(6),
          ),
          boxShadow: isSelected && coreColor != null
              ? [BoxShadow(color: coreColor.withOpacity(0.27), blurRadius: 12)]
              : isBlack
                  ? null
                  : [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          label,
          style: BuilderTypography.mono(
            size: 9,
            weight: FontWeight.w600,
            color: isSelected ? Colors.white : (isBlack ? const Color(0xFF777777) : BuilderColors.textDark),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// FuncBtn — function selector button
// ─────────────────────────────────────────────

class FuncBtn extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback? onTap;
  const FuncBtn({super.key, required this.label, this.isActive = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    final w = WorldColors.forWorld(label);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isActive ? w : w.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
          border: isActive ? null : Border.all(color: w.withOpacity(0.27), width: 2),
          boxShadow: isActive ? [BoxShadow(color: w.withOpacity(0.27), blurRadius: 16)] : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: BuilderTypography.mono(
            size: 14,
            weight: FontWeight.w700,
            color: isActive ? Colors.white : w,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// LibraryChip — chord card in library grid
// ─────────────────────────────────────────────

class LibraryChip extends StatelessWidget {
  final String notes;
  final String world;
  final VoidCallback? onTap;
  const LibraryChip({super.key, required this.notes, required this.world, this.onTap});

  @override
  Widget build(BuildContext context) {
    final w = WorldColors.forWorld(world);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          color: w.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border(left: BorderSide(color: w, width: 3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notes, style: BuilderTypography.mono(size: 12, color: BuilderColors.textSecondary)),
            const SizedBox(height: 2),
            Text(world, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: w)),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// HierarchyBar — persistent hierarchy display
// ─────────────────────────────────────────────

class HierarchyBar extends StatelessWidget {
  final String mode;
  final VoidCallback? onTap;
  const HierarchyBar({super.key, required this.mode, this.onTap});

  @override
  Widget build(BuildContext context) {
    final seq = Hierarchies.sequences[mode] ?? [];
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: seq.map((item) {
            if (item == '|') {
              return Container(
                width: 1,
                height: 14,
                color: BuilderColors.borderLight,
                margin: const EdgeInsets.symmetric(horizontal: 6),
              );
            }
            final color = WorldColors.forWorld(item);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                item,
                style: BuilderTypography.mono(size: 10, weight: FontWeight.w700, color: color),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Toast — notification overlay
// ─────────────────────────────────────────────

class BuilderToast extends StatelessWidget {
  final String message;
  final bool visible;
  const BuilderToast({super.key, required this.message, this.visible = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: visible ? 1.0 : 0.0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: BuilderColors.borderLight,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: BuilderColors.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SentenceHeader — number + kebab menu
// ─────────────────────────────────────────────

class SentenceHeader extends StatelessWidget {
  final int num;
  final int? beatCount;
  final bool isExtended;
  final VoidCallback? onMenuTap;

  const SentenceHeader({
    super.key,
    required this.num,
    this.beatCount,
    this.isExtended = false,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 3, 8, 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text('$num', style: BuilderTypography.mono(size: 12, color: BuilderColors.textDim)),
              if (isExtended && beatCount != null) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(
                    color: BuilderColors.accent.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '$beatCount beats →',
                    style: BuilderTypography.mono(size: 9, color: BuilderColors.accent),
                  ),
                ),
              ],
            ],
          ),
          GestureDetector(
            onTap: onMenuTap,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text('⋮', style: TextStyle(color: BuilderColors.textFaint, fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// EnergyLane — mini bar chart per sentence
// ─────────────────────────────────────────────

class EnergyLane extends StatelessWidget {
  final List<double> data;
  const EnergyLane({super.key, required this.data});

  Color _tensionColor(double v) {
    final n = v / 10;
    if (n <= 0.3) return BuilderColors.success;
    if (n <= 0.6) return BuilderColors.warning;
    return BuilderColors.danger;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16,
      child: Row(
        children: data.map((v) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1.5),
              alignment: Alignment.bottomCenter,
              child: Container(
                height: (v / 10).clamp(0.1, 1.0) * 16,
                decoration: BoxDecoration(
                  color: _tensionColor(v).withOpacity(0.8),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(2),
                    topRight: Radius.circular(2),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
