import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/app_theme.dart';
import 'package:leemcwest/client/presentation/case_study_models.dart';
import 'case_study_elements.dart';

/// Persistent FNH Key Map overlay — slides up from the bottom.
/// Accessible from any page in the study view via the KEY MAP button.
class KeyMapOverlay extends StatelessWidget {
  final FnhKeyMapData data;
  final VoidCallback onClose;

  const KeyMapOverlay({super.key, required this.data, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      child: Container(
        color: Colors.black.withValues(alpha: .6),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {}, // absorb taps
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Drag handle
                  Center(
                    child: Container(
                      width: 36,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // Title
                  Text('FNH Key Map',
                      style: AppTypography.heading(size: 14, weight: FontWeight.w700)),
                  const SizedBox(height: 4),

                  // Key Map widget (reused, no label since we have the title above)
                  FnhKeyMapWidget(
                    root: data.root,
                    notes: data.notes,
                    showLabel: true,
                  ),

                  // Hint
                  Text('Core notes highlighted. Tap outside to dismiss.',
                      style: AppTypography.body(size: 12, color: AppColors.textMuted)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
