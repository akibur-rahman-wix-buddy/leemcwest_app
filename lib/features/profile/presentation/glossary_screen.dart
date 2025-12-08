import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
import 'package:leemcwest/features/profile/widget/bullet_title.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class GlossaryScreen extends StatefulWidget {
  const GlossaryScreen({super.key});

  @override
  State<GlossaryScreen> createState() => _GlossaryScreenState();
}

class _GlossaryScreenState extends State<GlossaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF9FAFB,
      appBar: const CustomCenterTitleAppbar(
        title: 'Glossary',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(32.h),
              Text(
                'Welcome to FHT',
                style: TextFontStyle.headlineCinzel18w600c141313,
              ),
              UIHelper.verticalSpace(12.h),
              const BulletTitle(
                text: '1, 2♭, 2, 3, 3♯, 4, 4♯, 5, 6, 6♯, 7, 7♯',
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'Fixed numeric row (no enharmonics).',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(18.h),
              const BulletTitle(
                text: 'T (Tonic)',
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'Core = 3. Foundation chords: 1-3-5, 3-5-7.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
               UIHelper.verticalSpace(18.h),
              const BulletTitle(
                text: 'D (Dominant)',
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'Core = 2. Foundation chord: 7-2-4 (preferred).',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(18.h),
              const BulletTitle(
                text: '• D♭ (2♭)',
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'Dual identity: home (short hold on 1) or tension (long hold). Reversal pivot.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(18.h),
              const BulletTitle(
                text: '4♯ (D♯ realm)',
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'Dominant pivot and temporary home on 1.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(18.h),
              const BulletTitle(
                text: 't, s/d (lowercase)',
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'Neighbours or shadows of T, S, D',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(18.h),
              const BulletTitle(
                text: 'Sentence',
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                '8-beat cycle; strong beats = 1, 3, 5, 7.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(18.h),
              const BulletTitle(
                text: 'Announcement',
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'Function declared on a strong beat, held for ≥1 beat.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(18.h),
              const BulletTitle(
                text: 'Noodling',
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'Decoration on weak beats; doesn’t change function.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(18.h),
              const BulletTitle(
                text: 'Gravitational Flow',
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'T → S → D → T and T → D → S → T (basic);',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'T → S → D → ♯ → D♭ → T (expanded); reversible.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(18.h),
              const BulletTitle(
                text: 'Go Bigger / Go Home',
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'Each move either climbs up the hierarchy (bigger) or lands on a natural function (home).',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(18.h),
              const BulletTitle(
                text: 'Reframing',
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'Same notes, new function as time passes.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(18.h),
              const BulletTitle(
                text: 'Equivalence',
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'Same chord can map to multiple functions depending on context (minor/ major grids).',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(18.h),
              const BulletTitle(
                text: 'Rest-in-Tension',
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'Home coloured by D♭/♯ on a rest beat; feels both settled and unsettled.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(18.h),
              const BulletTitle(
                text: 'Super-Modulation (Super-Mod)',
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'Reframing a note/chord as a new function through confirmation in time.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(18.h),
              const BulletTitle(
                text: 'D♭-Expansion Scales',
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'Families where D♭ allows chromatic pairs (3/3♯, 4/4♯, 7/7♯).',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(16.h)
            ],
          ),
        ),
      ),
    );
  }
}
