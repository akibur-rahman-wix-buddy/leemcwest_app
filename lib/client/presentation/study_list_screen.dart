import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/app_theme.dart';
import 'package:leemcwest/client/presentation/case_study_models.dart';
import 'package:leemcwest/client/presentation/fnh_color_resolver.dart';


/// Study List screen — tiered accordion with expandable sections
/// and study cards showing title, artist, and function badge.
class StudyListScreen extends StatefulWidget {
  final List<StudyTier> tiers;
  final List<CaseStudy> studies;
  final ValueChanged<int> onOpenStudy;

  const StudyListScreen({
    super.key,
    required this.tiers,
    required this.studies,
    required this.onOpenStudy,
  });

  @override
  State<StudyListScreen> createState() => _StudyListScreenState();
}

class _StudyListScreenState extends State<StudyListScreen> {
  int? _expandedTier = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Case Studies',
                        style: TextStyle(fontFamily: 'DM Sans', fontSize: 24,
                            fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    SizedBox(height: 6),
                    Text('FNH analysis of real music. Every note, every beat, every function.',
                        style: TextStyle(fontFamily: 'Source Serif 4', fontSize: 14,
                            color: AppColors.textMuted, height: 1.55)),
                  ],
                ),
              ),

              // Tier count summary
              Row(
                children: widget.tiers.map((t) {
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: t.num < widget.tiers.length ? 8 : 0),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        children: [
                          Text('${t.studyIds.length}',
                              style: TextStyle(fontFamily: 'DM Mono', fontSize: 18,
                                  fontWeight: FontWeight.w700, color: t.color)),
                          const SizedBox(height: 2),
                          Text('Tier ${t.num}',
                              style: AppTypography.label(size: 10, color: AppColors.textMuted)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Tier accordions
              ...widget.tiers.map((tier) {
                final isExpanded = _expandedTier == tier.num;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    children: [
                      // Tier header
                      GestureDetector(
                        onTap: () => setState(() =>
                            _expandedTier = isExpanded ? null : tier.num),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isExpanded
                                  ? tier.color.withValues(alpha: .33)
                                  : AppColors.border,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 36, height: 36,
                                decoration: BoxDecoration(
                                  color: tier.color.withValues(alpha: .09),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: tier.color.withValues(alpha: .25), width: 1.5),
                                ),
                                alignment: Alignment.center,
                                child: Text('${tier.num}',
                                    style: TextStyle(fontFamily: 'DM Mono', fontSize: 16,
                                        fontWeight: FontWeight.w700, color: tier.color)),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(tier.name, style: AppTypography.heading(size: 15)),
                                    Text(tier.desc, style: AppTypography.label(size: 12, color: AppColors.textMuted)),
                                  ],
                                ),
                              ),
                              Text('${tier.studyIds.length}',
                                  style: AppTypography.mono(size: 11, color: AppColors.textMuted)),
                            ],
                          ),
                        ),
                      ),

                      // Expanded study cards
                      if (isExpanded)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Column(
                            children: tier.studyIds.map((id) {
                              final study = widget.studies.firstWhere((s) => s.id == id);
                              final centreLabel = study.centre.split(' ').first;
                              final centreColor = FnhColorResolver.resolve(centreLabel);
                              return GestureDetector(
                                onTap: () => widget.onOpenStudy(id),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 2),
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: AppColors.border),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 28, height: 28,
                                        decoration: BoxDecoration(
                                          color: tier.color.withValues(alpha: .08),
                                          borderRadius: BorderRadius.circular(7),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text('${study.id}',
                                            style: TextStyle(fontFamily: 'DM Mono', fontSize: 12,
                                                fontWeight: FontWeight.w600, color: tier.color)),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(study.title, style: AppTypography.label(size: 13, color: AppColors.textPrimary)),
                                            Text(study.artist, style: AppTypography.label(size: 11, color: AppColors.textMuted)),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: centreColor.withValues(alpha: .08),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(study.centre,
                                            style: TextStyle(fontFamily: 'DM Mono', fontSize: 10,
                                                fontWeight: FontWeight.w600, color: centreColor)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
