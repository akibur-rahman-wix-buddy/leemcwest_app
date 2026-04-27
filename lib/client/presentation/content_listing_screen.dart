import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/app_theme.dart';


// ═══════════════════════════════════════
// CONTENT LISTING SCREEN
// ═══════════════════════════════════════

/// Shared content listing layout used by Core Theory and Advanced Insights.
/// Each content area provides its own title, subtitle, accent colour, and list of topics.
class ContentListingScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color accentColor;
  final String countNoun; // "chapters", "topics"
  final List<Widget> cards;
  final VoidCallback? onBack;

  const ContentListingScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.countNoun,
    required this.cards,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onBack ?? () => Navigator.maybePop(context),
                    child: const Icon(Icons.arrow_back, color: AppColors.textMuted, size: 22),
                  ),
                  Expanded(
                    child: Text('NumoniX', textAlign: TextAlign.center,
                        style: AppTypography.heading(size: 16, weight: FontWeight.w600)),
                  ),
                  const SizedBox(width: 22),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.heading(size: 24, weight: FontWeight.w700).copyWith(letterSpacing: -0.4)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: AppTypography.label(size: 13, weight: FontWeight.w500, color: AppColors.textMuted)),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Divider(height: 1, color: AppColors.border),
            ),

            // Count
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${cards.length} $countNoun',
                  style: AppTypography.mono(size: 11, color: AppColors.textMuted),
                ),
              ),
            ),

            // Card list
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                itemCount: cards.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, i) => cards[i],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════
// CHAPTER CARD (for Core Theory)
// ═══════════════════════════════════════

class ChapterCard extends StatelessWidget {
  final int number;
  final String title;
  final String description;
  final int? readTime;
  final Color accentColor;
  final VoidCallback? onTap;

  const ChapterCard({
    super.key,
    required this.number,
    required this.title,
    required this.description,
    this.readTime,
    required this.accentColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(10),
          border: Border(left: BorderSide(color: accentColor, width: 3)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Chapter $number: $title',
                      style: AppTypography.label(size: 15, weight: FontWeight.w600, color: AppColors.textPrimary)),
                  const SizedBox(height: 4),
                  Text(description, style: AppTypography.body(size: 13.5, height: 1.5)),
                ],
              ),
            ),
            if (readTime != null) ...[
              const SizedBox(width: 14),
              Text('$readTime min', style: AppTypography.mono(size: 11, color: AppColors.textMuted)),
            ],
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, size: 16, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════
// TOPIC CARD (for Advanced Insights)
// ═══════════════════════════════════════

class TopicCard extends StatelessWidget {
  final String title;
  final String description;
  final String? icon;
  final Color accentColor;
  final VoidCallback? onTap;

  const TopicCard({
    super.key,
    required this.title,
    required this.description,
    this.icon,
    required this.accentColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(10),
          border: Border(left: BorderSide(color: accentColor, width: 3)),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: .08),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(icon!, style: TextStyle(fontSize: 18, color: accentColor)),
              ),
              const SizedBox(width: 14),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.label(size: 15, weight: FontWeight.w600, color: AppColors.textPrimary)),
                  const SizedBox(height: 4),
                  Text(description, style: AppTypography.body(size: 13, height: 1.5)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, size: 16, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}
