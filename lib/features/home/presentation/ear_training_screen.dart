import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_icons.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class EarTrainingScreen extends StatefulWidget {
  const EarTrainingScreen({super.key});

  @override
  State<EarTrainingScreen> createState() => _EarTrainingScreenState();
}

class _EarTrainingScreenState extends State<EarTrainingScreen> {
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
              Center(
                child: Text(
                  'Welcome to Functional Harmonic Theory',
                  style: TextFontStyle.headlineCinzel24w700cFFFFFF.copyWith(
                    color: AppColors.onboardingButtonColor,
                    fontSize: 18.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              UIHelper.verticalSpace(30.h),
              Center(
                child: Image.asset(
                  AppImages.python,
                  width: 88.w,
                ),
              ),
              UIHelper.verticalSpace(32.h),
              Center(
                child: Text(
                  'You’ve just stepped into a new era of music education a living framework that teaches harmony through flow, not formula.',
                  style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                    color: AppColors.c4A5565,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Center(
                child: Text(
                  'Functional Harmonic Theory is a new living framework that reveals the natural gravitational movement of sound.',
                  style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                    color: AppColors.c4A5565,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Center(
                child: Text(
                  'Removing the confusion that, for centuries, traditional theory had left behind endless rules, contradictions, and unanswered questions.',
                  style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                    color: AppColors.c4A5565,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Center(
                child: Text(
                  'Here, you’ll learn harmony as it truly exists in motion. Expanding, contracting, and resolving through pure functional gravity.',
                  style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                    color: AppColors.c4A5565,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              UIHelper.verticalSpace(12.h),
              Center(
                child: Text(
                  'Learn through structured lessons. Create freely in the Composition Builder. Go deeper with Case Study Analysis, Advanced Insights, and develop your instinct through Functional Ear Training a unique approach that helps you feel harmonic direction rather than memorise intervals.',
                  style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                    color: AppColors.c4A5565,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Center(
                child: Text(
                  'Whether you’re a musician, producer, composer, or curious learner, FHT will reshape how you hear, write, and understand music.',
                  style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                    color: AppColors.c4A5565,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              UIHelper.verticalSpace(12.h),
              Center(
                child: Text(
                  'Explore at your own pace.',
                  style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                    color: AppColors.c4A5565,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Center(
                child: Text(
                  'Learn the logic and feel the flow.',
                  style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                    color: AppColors.c4A5565,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Center(
                child: Text(
                  'Learn the logic and feel the flow.',
                  style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                    color: AppColors.c4A5565,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Center(
                child: Text(
                  'Intuitive. Logical. Complete.',
                  style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                    color: AppColors.c4A5565,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              UIHelper.verticalSpace(54.h),
              Center(
                child: Text(
                  'Welcome to Functional Harmonic Theory where music finally makes sense.',
                  style: TextFontStyle.headlineCinzel24w700cFFFFFF.copyWith(
                    color: AppColors.onboardingButtonColor,
                    fontSize: 18.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              UIHelper.verticalSpace(12.h),
              GestureDetector(
                onTap: () {
                  NavigationService.navigateTo(Routes.navigation);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColors.onboardingButtonColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Enter F.H.T',
                        style: TextFontStyle.headlinePoppins60016.copyWith(
                          color: AppColors.cFFFFFF,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      UIHelper.horizontalSpace(8.w),
                      SvgPicture.asset(AppIcons.forward)
                    ],
                  ),
                ),
              ),
              UIHelper.verticalSpace(36.h),
            ],
          ),
        ),
      ),
    );
  }
}
