import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/app_theme.dart';

// ─────────────────────────────────────────────
// Shared Header
// ─────────────────────────────────────────────

class AppHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final Widget? rightIcon;
  const AppHeader({super.key, required this.title, this.onBack, this.rightIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          if (onBack != null)
            GestureDetector(
              onTap: onBack,
              child: const Icon(Icons.arrow_back, color: AppColors.textMuted, size: 22),
            )
          else
            const SizedBox(width: 22),
          Expanded(
            child: Text(title, textAlign: TextAlign.center,
                style: AppTypography.heading(size: 16, weight: FontWeight.w600)),
          ),
          rightIcon ?? SizedBox(width: onBack != null ? 22 : 0),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// InputField
// ─────────────────────────────────────────────

class InputField extends StatelessWidget {
  final String label;
  final String? placeholder;
  final String? value;
  final bool multiline;
  const InputField({super.key, required this.label, this.placeholder, this.value, this.multiline = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTypography.label(size: 13, weight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            constraints: multiline ? const BoxConstraints(minHeight: 100) : null,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: Text(
              value ?? placeholder ?? '',
              style: TextStyle(
                fontFamily: AppTypography.fontDisplay, fontSize: 14,
                color: value != null ? AppColors.textPrimary : AppColors.textMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PrimaryButton
// ─────────────────────────────────────────────

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool danger;
  const PrimaryButton({super.key, required this.label, this.onTap, this.danger = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: danger ? AppColors.error : AppColors.accent,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(label, style: AppTypography.button(size: 15)),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SecondaryButton
// ─────────────────────────────────────────────

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final String? icon;
  const SecondaryButton({super.key, required this.label, this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border, width: 1.5),
        ),
        alignment: Alignment.center,
        child: Text(label, style: TextStyle(
          fontFamily: AppTypography.fontDisplay, fontSize: 14,
          fontWeight: FontWeight.w500, color: AppColors.textSecondary,
        )),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// MenuRow
// ─────────────────────────────────────────────

class MenuRow extends StatelessWidget {
  final String label;
  final String? icon;
  final VoidCallback? onTap;
  final bool showChevron;
  const MenuRow({super.key, required this.label, this.icon, this.onTap, this.showChevron = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
        child: Row(
          children: [
            if (icon != null) ...[
              SizedBox(width: 24, child: Text(icon!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, color: AppColors.textMuted))),
              const SizedBox(width: 14),
            ],
            Expanded(child: Text(label, style: AppTypography.label(size: 14, color: AppColors.textPrimary))),
            if (showChevron) const Icon(Icons.chevron_right, size: 16, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Toggle
// ─────────────────────────────────────────────

class AppToggle extends StatelessWidget {
  final bool value;
  final VoidCallback? onTap;
  const AppToggle({super.key, required this.value, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 44, height: 24,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: value ? AppColors.accent : AppColors.border,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 20, height: 20,
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// BottomTabBar
// ─────────────────────────────────────────────

class BottomTabBar extends StatelessWidget {
  final String activeTab;
  final ValueChanged<String>? onTap;
  const BottomTabBar({super.key, required this.activeTab, this.onTap});

  @override
  Widget build(BuildContext context) {
    final tabs = [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.menu_book, 'label': 'Lesson'},
      {'icon': Icons.radio_button_unchecked, 'label': 'Progress'},
      {'icon': Icons.person, 'label': 'Profile'},
    ];
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      padding: const EdgeInsets.only(top: 10, bottom: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: tabs.map((t) {
          final active = t['label'] == activeTab;
          return GestureDetector(
            onTap: () => onTap?.call(t['label'] as String),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(t['icon'] as IconData, size: 20, color: active ? AppColors.accent : AppColors.textMuted),
                const SizedBox(height: 2),
                Text(t['label'] as String, style: TextStyle(
                  fontFamily: AppTypography.fontDisplay, fontSize: 10,
                  color: active ? AppColors.accent : AppColors.textMuted,
                  fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                )),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ProgressRing (for progress screen)
// ─────────────────────────────────────────────

class ProgressRing extends StatelessWidget {
  final double size;
  final double percentage;
  final String? label;
  const ProgressRing({super.key, required this.size, required this.percentage, this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size, height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size, height: size,
            child: CircularProgressIndicator(
              value: percentage / 100,
              strokeWidth: size > 60 ? 5 : 3,
              backgroundColor: AppColors.border,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (label != null) Text(label!, style: AppTypography.label(size: 10, color: AppColors.textMuted)),
              Text('${percentage.round()}%', style: TextStyle(
                fontFamily: AppTypography.fontDisplay,
                fontSize: size > 60 ? 22 : 14,
                fontWeight: FontWeight.w700, color: AppColors.textPrimary,
              )),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SectionCard (for home screen)
// ─────────────────────────────────────────────

class HomeSectionCard extends StatelessWidget {
  final String title;
  final String description;
  final String buttonLabel;
  final Color color;
  final bool disabled;
  final VoidCallback? onTap;

  const HomeSectionCard({
    super.key,
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.color,
    this.disabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: [color.withOpacity(0.13), AppColors.card],
        ),
        border: Border.all(color: color.withOpacity(0.19)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.heading(size: 17)),
          const SizedBox(height: 8),
          Text(description, style: AppTypography.body(size: 13, height: 1.55)),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: disabled ? null : onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                color: disabled ? AppColors.textMuted : color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Opacity(
                opacity: disabled ? 0.5 : 1,
                child: Text(buttonLabel, style: AppTypography.button(size: 13)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
