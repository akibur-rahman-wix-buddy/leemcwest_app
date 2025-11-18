import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class FunctionalEarTrainingScreen extends StatefulWidget {
  const FunctionalEarTrainingScreen({super.key});

  @override
  State<FunctionalEarTrainingScreen> createState() =>
      _FunctionalEarTrainingScreenState();
}

class _FunctionalEarTrainingScreenState
    extends State<FunctionalEarTrainingScreen> {
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
              UIHelper.verticalSpace(86.h),
              Center(
                child: Image.asset(
                  AppImages.python,
                  width: 88.w,
                ),
              ),
              UIHelper.verticalSpace(32.h),
              Text(
                'Why Music Theory Needs a Fresh Start',
                style: TextFontStyle.headlineCinzel24w700cFFFFFF.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onboardingButtonColor,
                ),
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'And why Functional Harmonic Theory exists.',
                style: TextFontStyle.headlineCinzel24w500cFFFFFF.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.onboardingButtonColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'For centuries, traditional theory tried to explain music through labels, scales, and chord names but never through motion.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Text(
                'Music isn’t built on formulas.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'It’s built on gravity energy that expands, contracts, and returns home.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                'Functional Harmonic Theory (FHT) begins where traditional theory stopped. It reveals music as one continuous field of motion, where every note is connected by function, not by key or name.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                'No more contradictions.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                'No more guesswork.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                'Just harmony as it naturally flows.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Text(
                'To understand that flow, we start at the foundation:',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'a fixed chromatic system twelve tones that never change, yet explain every sound in existence.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                'Here, you’re not just learning theory you’re learning the language of music itself.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
