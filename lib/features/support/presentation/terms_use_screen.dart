import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
import 'package:leemcwest/features/profile/widget/bullet_text.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class TermsUseScreen extends StatefulWidget {
  const TermsUseScreen({super.key});

  @override
  State<TermsUseScreen> createState() => _TermsUseScreenState();
}

class _TermsUseScreenState extends State<TermsUseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      appBar: const CustomCenterTitleAppbar(
        title: 'Terms of Use (FHT)',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(12.h),
              Text(
                'Functional Harmonic Theory (FHT) – Terms of Use',
                style: TextFontStyle.headlineCinzel18w600c141313.copyWith(
                  color: AppColors.c1E2939,
                ),
              ),
              UIHelper.verticalSpace(4.h),
              Text(
                'Last updated: 29th October 2025',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                'Functional Harmonic Theory (“FHT”, “we”, “our”, or “us”) respects your privacy and is committed to protecting your personal data. This Privacy Policy explains how we collect, use, and safeguard information when you use our mobile application and related services (the “App”).',
                style: TextFontStyle.textStyle14w500c6A7282.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.c1E2939,
                ),
              ),
              UIHelper.verticalSpace(24.h),
              Text(
                '1. Information We Collect',
                style: TextFontStyle.headlineCinzel18w600c141313.copyWith(
                  color: AppColors.c1E2939,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                'We may collect the following types of information:',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(18.h),
              Text(
                'A. Account Information',
                style: TextFontStyle.textStyle14w500c6A7282.copyWith(
                  color: AppColors.c1E2939,
                ),
              ),
              UIHelper.verticalSpace(12.h),
              const BulletText(
                text: 'Name, email address, and password when you create an FHT account.',
              ),
              UIHelper.verticalSpace(12.h),
              const BulletText(
                text: 'Subscription or membership details (Basic or Premium).',
              ),
               UIHelper.verticalSpace(18.h),
              Text(
                'B. Usage Data',
                style: TextFontStyle.textStyle14w500c6A7282.copyWith(
                  color: AppColors.c1E2939,
                ),
              ),
               UIHelper.verticalSpace(12.h),
              const BulletText(
                text: 'Lesson progress, quiz results, and app activity (for tracking learning progress).',
              ),
              UIHelper.verticalSpace(12.h),
              const BulletText(
                text: 'Device type, operating system, and app version (for performance optimisation).',
              ),
               UIHelper.verticalSpace(12.h),
              const BulletText(
                text: 'Non-identifiable analytics data such as session length and interaction counts',
              ),
               UIHelper.verticalSpace(18.h),
              Text(
                'C. Payment Information',
                style: TextFontStyle.textStyle14w500c6A7282.copyWith(
                  color: AppColors.c1E2939,
                ),
              ),
              Text(
                'Payments are processed securely by Stripe, Apple, or Google. We do not store or have access to your full payment card details.',
                style: TextFontStyle.textStyle14w500c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
              ),
               UIHelper.verticalSpace(18.h),
              Text(
                'D. Support and Feedback',
                style: TextFontStyle.textStyle14w500c6A7282.copyWith(
                  color: AppColors.c1E2939,
                ),
              ),
              Text(
                'If you contact us via in-app support, we may collect your name, email, and message content to respond to your query.',
                style: TextFontStyle.textStyle14w500c6A7282.copyWith(
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
