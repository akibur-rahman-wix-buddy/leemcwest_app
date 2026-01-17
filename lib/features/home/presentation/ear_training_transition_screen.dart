import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/features/home/widget/next_level_btn.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class EarTrainingTransitionScreen extends StatefulWidget {
  const EarTrainingTransitionScreen({super.key});

  @override
  State<EarTrainingTransitionScreen> createState() =>
      _EarTrainingTransitionScreenState();
}

class _EarTrainingTransitionScreenState
    extends State<EarTrainingTransitionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(60.h),
              Text(
                'Welcome to Functional Harmonic Theory',
                style: TextFontStyle.headlineCinzel18w600c141313,
                textAlign: TextAlign.center,
              ),
              UIHelper.verticalSpace(22.h),
              Center(
                child: Image.asset(
                  AppImages.python,
                  width: 88.w,
                ),
              ),
              UIHelper.verticalSpace(32.h),
              Text(
                'Fade Transition 2',
                style: TextFontStyle.headlineCinzel18w600c141313,
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'You’ve just stepped into a new era of music education a living framework that teaches harmony through flow, not formula.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                'Functional Harmonic Theory is a new living framework that reveals the natural gravitational movement of sound.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                'Removing the confusion that, for centuries, traditional theory had left behind endless rules, contradictions, and unanswered questions.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Text(
                'Fade Transition 3',
                style: TextFontStyle.headlineCinzel18w600c141313,
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'Here, you’ll learn harmony as it truly exists in motion. Expanding, contracting, and resolving through pure functional gravity.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                'Learn through structured lessons. Create freely in the Composition Builder. Go deeper with Case Study Analysis, Advanced Insights, and develop your instinct through Functional Ear Training a unique approach that helps you feel harmonic direction rather than memorise intervals.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Text(
                'Fade Transition 4',
                style: TextFontStyle.headlineCinzel18w600c141313,
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'Whether you’re a musician, producer, composer, or curious learner, FHT will reshape how you hear, write, and understand music.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'Explore at your own pace.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'Learn the logic and feel the flow.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Text(
                'Fade Transition ',
                style: TextFontStyle.headlineCinzel18w600c141313,
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'This is music theory, redefined.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'Intuitive. Logical. Complete.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(32.h),
              Text(
                'Welcome to Functional Harmonic Theory where music finally makes sense. ',
                style: TextFontStyle.headlineCinzel18w600c141313,
                textAlign: TextAlign.center,
              ),
              UIHelper.verticalSpace(12.h),
              NextLevelBtn(
                text: 'Enter F.H.T',
                onTap: (){
                  NavigationService.navigateTo(Routes.earTrainingTheory);
                },
              ),
              UIHelper.verticalSpace(24.h),
            ],
          ),
        ),
      ),
    );
  }
}
