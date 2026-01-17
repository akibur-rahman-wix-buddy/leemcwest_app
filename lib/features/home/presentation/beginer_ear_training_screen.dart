import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/features/home/widget/next_level_btn.dart';
import 'package:leemcwest/features/home/widget/repeat_level_widget.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class BeginerEarTrainingScreen extends StatefulWidget {
  const BeginerEarTrainingScreen({super.key});

  @override
  State<BeginerEarTrainingScreen> createState() =>
      _BeginerEarTrainingScreenState();
}

class _BeginerEarTrainingScreenState extends State<BeginerEarTrainingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIHelper.verticalSpace(64.h),
            Center(
              child: Image.asset(
                AppImages.python,
                width: 88.w,
              ),
            ),
            UIHelper.verticalSpace(32.h),
            Text(
              'You’ve reached the end of this level!',
              style: TextFontStyle.headlinePublicSans60024.copyWith(
                color: AppColors.c0A2340,
              ),
              textAlign: TextAlign.center,
            ),
            UIHelper.verticalSpace(16.h),
            Text(
              'You’ve explored every sound in this stage your awareness of harmonic gravity is deepening.',
              style: TextFontStyle.textStyle16w400c6A7282.copyWith(
                color: AppColors.c364153,
              ),
              textAlign: TextAlign.center,
            ),
            UIHelper.verticalSpace(32.h),
            Text(
              'Functional hearing grows through exposure, not perfection. Every attempt refines your instinct teaching your ear to feel motion, direction, and return.',
              style: TextFontStyle.textStyle16w400c6A7282.copyWith(
                color: AppColors.c364153,
              ),
              textAlign: TextAlign.center,
            ),
            UIHelper.verticalSpace(8.h),
            Text(
              'You can revisit this level anytime to refine your flow or move forward to explore deeper gravity shifts.',
              style: TextFontStyle.textStyle16w400c6A7282.copyWith(
                color: AppColors.c364153,
              ),
              textAlign: TextAlign.center,
            ),
            UIHelper.verticalSpace(32.h),
            Row(
              children: [
                Expanded(
                  child: RepeatLevelWidget(
                    onTap: () {},
                  ),
                ),
                UIHelper.horizontalSpace(24.w),
                Expanded(
                  child: NextLevelBtn(
                    text: 'Next Level',
                    onTap: () {
                      NavigationService.navigateTo(Routes.earTrainingTransition);
                    },
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpace(32.h),
            Text(
              'Your progress is measured by awareness, not accuracy. Listen again, feel again, and let the gravity guide you',
              style: TextFontStyle.textStyle12w400c64748B.copyWith(
                color: AppColors.c6A7282,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
