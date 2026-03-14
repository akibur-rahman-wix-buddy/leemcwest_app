import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/builder_models.dart';
import 'package:leemcwest/client/presentation/builder_theme.dart';
import 'builder_widgets.dart';

// ─────────────────────────────────────────────
// PopupMenu — reusable menu overlay
// ─────────────────────────────────────────────

class PopupMenu extends StatelessWidget {
  final String? title;
  final List<MenuItem?> items; // null = divider
  final VoidCallback onClose;
  final ValueChanged<MenuItem>? onSelect;

  const PopupMenu({super.key, this.title, required this.items, required this.onClose, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      child: Container(
        color: Colors.black54,
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            constraints: const BoxConstraints(maxWidth: 320, maxHeight: 500),
            decoration: BoxDecoration(
              color: const Color(0xFF222222),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: BuilderColors.borderLight),
              boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 32)],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                      child: Text(title!, style: BuilderTypography.sectionHeader()),
                    ),
                  ...items.map((item) {
                    if (item == null) {
                      return Container(height: 1, color: BuilderColors.borderLight, margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4));
                    }
                    return GestureDetector(
                      onTap: item.disabled ? null : () { onClose(); onSelect?.call(item); },
                      child: Opacity(
                        opacity: item.disabled ? 0.3 : 1.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                          child: Row(
                            children: [
                              Text(item.icon, style: const TextStyle(fontSize: 14)),
                              const SizedBox(width: 10),
                              Expanded(child: Text(item.label, style: TextStyle(fontSize: 13, color: item.danger ? BuilderColors.danger : BuilderColors.textPrimary))),
                              if (item.sub != null) Text(item.sub!, style: const TextStyle(fontSize: 11, color: BuilderColors.textFaint)),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ConfirmDialog — generic confirmation modal
// ─────────────────────────────────────────────

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String cancelLabel;
  final String confirmLabel;
  final Color confirmColor;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.cancelLabel = 'Cancel',
    this.confirmLabel = 'Confirm',
    this.confirmColor = BuilderColors.danger,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCancel,
      child: Container(
        color: Colors.black54,
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: BuilderColors.cardAlt,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: BuilderColors.borderLight),
              boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 32)],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: confirmColor), textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Text(message, style: const TextStyle(fontSize: 12, color: Color(0xFF888888)), textAlign: TextAlign.center),
                const SizedBox(height: 20),
                Row(children: [
                  Expanded(child: _outlineBtn(cancelLabel, onCancel)),
                  const SizedBox(width: 8),
                  Expanded(child: _solidBtn(confirmLabel, confirmColor, onConfirm)),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// RenameModal
// ─────────────────────────────────────────────

class RenameModal extends StatefulWidget {
  final String currentName;
  final VoidCallback onCancel;
  final ValueChanged<String> onSave;
  const RenameModal({super.key, required this.currentName, required this.onCancel, required this.onSave});

  @override
  State<RenameModal> createState() => _RenameModalState();
}

class _RenameModalState extends State<RenameModal> {
  late final TextEditingController _controller;

  @override
  void initState() { super.initState(); _controller = TextEditingController(text: widget.currentName); }

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return _modalWrapper(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('Rename Composition', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: BuilderColors.textSecondary)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(color: BuilderColors.surface, borderRadius: BorderRadius.circular(8), border: Border.all(color: BuilderColors.borderLight)),
          child: TextField(
            controller: _controller, autofocus: true,
            style: const TextStyle(fontSize: 14, color: BuilderColors.textPrimary),
            decoration: const InputDecoration.collapsed(hintText: 'Composition name', hintStyle: TextStyle(color: BuilderColors.textDim)),
          ),
        ),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: _outlineBtn('Cancel', widget.onCancel)),
          const SizedBox(width: 8),
          Expanded(child: _solidBtn('Save', BuilderColors.accent, () => widget.onSave(_controller.text))),
        ]),
      ]),
    );
  }
}

// ─────────────────────────────────────────────
// BeatCountStepper
// ─────────────────────────────────────────────

class BeatCountStepper extends StatefulWidget {
  final int sentenceNum;
  final int initialCount;
  final VoidCallback onCancel;
  final ValueChanged<int> onApply;
  const BeatCountStepper({super.key, required this.sentenceNum, required this.initialCount, required this.onCancel, required this.onApply});

  @override
  State<BeatCountStepper> createState() => _BeatCountStepperState();
}

class _BeatCountStepperState extends State<BeatCountStepper> {
  late int _count;
  @override
  void initState() { super.initState(); _count = widget.initialCount; }

  @override
  Widget build(BuildContext context) {
    return _modalWrapper(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('Set Beat Count', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: BuilderColors.textSecondary)),
        Text('Sentence ${widget.sentenceNum}', style: const TextStyle(fontSize: 11, color: BuilderColors.textDim)),
        const SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _stepperBtn('−', () { if (_count > 2) setState(() => _count--); }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('$_count', style: BuilderTypography.mono(size: 32, weight: FontWeight.w700, color: BuilderColors.textPrimary)),
          ),
          _stepperBtn('+', () { if (_count < 16) setState(() => _count++); }),
        ]),
        const SizedBox(height: 8),
        const Text('Range: 2 – 16 beats', style: TextStyle(fontSize: 10, color: BuilderColors.textFaint)),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: _outlineBtn('Cancel', widget.onCancel)),
          const SizedBox(width: 8),
          Expanded(child: _solidBtn('Apply', BuilderColors.accent, () => widget.onApply(_count))),
        ]),
      ]),
    );
  }

  Widget _stepperBtn(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(color: const Color(0xFF2A2A2A), borderRadius: BorderRadius.circular(10), border: Border.all(color: BuilderColors.borderLight)),
        alignment: Alignment.center,
        child: Text(label, style: const TextStyle(fontSize: 20, color: BuilderColors.textMuted)),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// HierarchyPicker
// ─────────────────────────────────────────────

class HierarchyPicker extends StatelessWidget {
  final String current;
  final ValueChanged<String> onSelect;
  final VoidCallback onClose;
  const HierarchyPicker({super.key, required this.current, required this.onSelect, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return _modalWrapper(
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Center(child: Text('Hierarchy Orientation', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: BuilderColors.textSecondary))),
        const SizedBox(height: 4),
        const Center(child: Text('Sets the gravitational direction', style: TextStyle(fontSize: 11, color: BuilderColors.textDim))),
        const SizedBox(height: 16),
        ...Hierarchies.sequences.keys.map((key) {
          final isActive = current == key;
          final seq = Hierarchies.sequences[key]!;
          return GestureDetector(
            onTap: () { onSelect(key); onClose(); },
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isActive ? BuilderColors.accent.withOpacity(0.12) : BuilderColors.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: isActive ? BuilderColors.accent : BuilderColors.borderLight),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(Hierarchies.labels[key] ?? key, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: isActive ? BuilderColors.accent : BuilderColors.textPrimary)),
                const SizedBox(height: 6),
                Wrap(spacing: 3, children: seq.map((s) {
                  if (s == '|') return Container(width: 1, height: 12, color: BuilderColors.borderLight, margin: const EdgeInsets.symmetric(horizontal: 4));
                  return Text(s, style: BuilderTypography.mono(size: 10, weight: FontWeight.w700, color: WorldColors.forWorld(s)));
                }).toList()),
              ]),
            ),
          );
        }),
      ]),
    );
  }
}

// ─────────────────────────────────────────────
// OpenSavedModal
// ─────────────────────────────────────────────

class OpenSavedModal extends StatelessWidget {
  final VoidCallback onClose;
  const OpenSavedModal({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final saves = [
      {'name': 'Midnight Flow', 'date': '12 Mar 2026', 'sentences': 4, 'root': 'C#'},
      {'name': 'Jazz Exploration', 'date': '10 Mar 2026', 'sentences': 6, 'root': 'A'},
      {'name': 'Blues Sketch', 'date': '8 Mar 2026', 'sentences': 2, 'root': 'E'},
    ];
    return _modalWrapper(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('Open Saved Composition', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: BuilderColors.textSecondary)),
        const SizedBox(height: 16),
        ...saves.map((s) => GestureDetector(
          onTap: onClose,
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: BuilderColors.surface, borderRadius: BorderRadius.circular(10), border: Border.all(color: BuilderColors.borderLight)),
            child: Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(s['name']! as String, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: BuilderColors.textPrimary)),
                Text('${s['date']} · ${s['sentences']} sentences · Root ${s['root']}', style: const TextStyle(fontSize: 10, color: BuilderColors.textDim)),
              ])),
              const Icon(Icons.chevron_right, size: 16, color: BuilderColors.textFaint),
            ]),
          ),
        )),
        const SizedBox(height: 8),
        _outlineBtn('Cancel', onClose),
      ]),
    );
  }
}

// ─────────────────────────────────────────────
// SettingsModal
// ─────────────────────────────────────────────

class SettingsModal extends StatelessWidget {
  final VoidCallback onClose;
  const SettingsModal({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return _modalWrapper(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('Settings', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: BuilderColors.textSecondary)),
        const SizedBox(height: 16),
        _settingRow('Auto-classify chords', true),
        _settingRow('Show energy lane', false),
        _settingRow('Snap to strong beats', true),
        _settingRow('Show octave indicators', true),
        const SizedBox(height: 16),
        _outlineBtn('Close', onClose),
      ]),
    );
  }

  Widget _settingRow(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: BuilderColors.textSecondary)),
          Container(
            width: 44, height: 24,
            decoration: BoxDecoration(
              color: value ? BuilderColors.accent : BuilderColors.borderLight,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            padding: const EdgeInsets.all(2),
            child: Container(width: 20, height: 20, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// UnsavedChangesDialog
// ─────────────────────────────────────────────

class UnsavedChangesDialog extends StatelessWidget {
  final VoidCallback onSaveAndOpen;
  final VoidCallback onDiscard;
  final VoidCallback onCancel;
  const UnsavedChangesDialog({super.key, required this.onSaveAndOpen, required this.onDiscard, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return _modalWrapper(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('Unsaved Changes', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: BuilderColors.warning)),
        const SizedBox(height: 8),
        const Text('Your current composition has unsaved changes. What would you like to do?', style: TextStyle(fontSize: 12, color: Color(0xFF888888)), textAlign: TextAlign.center),
        const SizedBox(height: 20),
        _solidBtn('Save & Open', BuilderColors.accent, onSaveAndOpen),
        const SizedBox(height: 8),
        _outlineBtn('Discard & Open', onDiscard, color: BuilderColors.danger),
        const SizedBox(height: 8),
        _outlineBtn('Cancel', onCancel),
      ]),
    );
  }
}

// ─────────────────────────────────────────────
// Shared helpers
// ─────────────────────────────────────────────

Widget _modalWrapper({required Widget child}) {
  return Builder(builder: (context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: Colors.black54,
        alignment: Alignment.center,
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: BuilderColors.cardAlt,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: BuilderColors.borderLight),
            boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 32)],
          ),
          child: child,
        ),
      ),
    );
  });
}

Widget _solidBtn(String label, Color color, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      alignment: Alignment.center,
      child: Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
    ),
  );
}

Widget _outlineBtn(String label, VoidCallback onTap, {Color? color}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color?.withOpacity(0.27) ?? BuilderColors.borderLight),
      ),
      alignment: Alignment.center,
      child: Text(label, style: TextStyle(fontSize: 13, color: color ?? BuilderColors.textMuted)),
    ),
  );
}
