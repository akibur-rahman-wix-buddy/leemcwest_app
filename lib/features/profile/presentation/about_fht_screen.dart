import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
import 'package:leemcwest/features/profile/widget/bullet_text.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class AboutFhtScreen extends StatefulWidget {
  const AboutFhtScreen({super.key});

  @override
  State<AboutFhtScreen> createState() => _AboutFhtScreenState();
}

class _AboutFhtScreenState extends State<AboutFhtScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF9FAFB,
      appBar: const CustomCenterTitleAppbar(
        title: 'About FHT',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(36.h),
              Text(
                'Welcome to FHT',
                style: TextFontStyle.headlineCinzel18w600c141313.copyWith(
                  color: AppColors.c1E2939,
                ),
              ),
              UIHelper.verticalSpace(32.h),
              Text(
                'Functional Harmonic Theory (FHT)',
                style: TextFontStyle.headlineCinzel18w600c141313.copyWith(
                  color: AppColors.c1E2939,
                ),
              ),
              UIHelper.verticalSpace(16.h),
              Text(
                'Functional Harmonic Theory (FHT)is a revolutionary approach to understanding music - one that replaces years of complex traditional study with a clear, intuitive system based on function and flow.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(16.h),
              Text(
                'Where traditional theory often focuses on memorising scales, chord names, rules and exceptions, FHT teaches you to feel and see harmony as movement. How each sound functions within a progression.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(16.h),
              Text(
                'This approach shortens the learning path dramatically, helping musicians grasp in weeks what can take years to understand through conventional methods.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(16.h),
              Text(
                'FHT simplifies harmony into a practical framework built on functional relationships - showing how music naturally resolves, flows, and creates emotion. It reveals the patterns behind all styles of music; from jazz and blues to classical and modern songwriting, while filling in the missing gaps left by traditional theory.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(16.h),
              Text(
                'By focusing on why music moves rather than what the notes are, FHT empowers you to:',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(16.h),
              const BulletText(
                text: 'Compose and improvise with confidence and clarity.',
              ),
              UIHelper.verticalSpace(16.h),
              const BulletText(
                text: 'Understand harmony visually and intuitively.',
              ),
              UIHelper.verticalSpace(16.h),
              const BulletText(
                text:
                    'Analyse songs and create smooth, expressive transitions.',
              ),
              UIHelper.verticalSpace(16.h),
              Text(
                'FHT offers the clarity and depth of advanced music education in a modern, accessible format; giving musicians of all levels the tools to understand and create music like never before.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(32.h),
              Text(
                'The Future of FHT',
                style: TextFontStyle.headlineCinzel18w600c141313.copyWith(
                  color: AppColors.c0A1437,
                ),
              ),
              UIHelper.verticalSpace(16.h),
              Text(
                'FHT offers the clarity and depth of advanced music education in a modern, accessible format; giving musicians of all levels the tools to understand and create music like never before.',
               style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(16.h),
               const BulletText(
                text: 'The Songwriting Lab – apply FHT directly in creative composition.',
              ),
              UIHelper.verticalSpace(16.h),
              const BulletText(
                text: 'AI Flow Analyser – upload songs, sheet music, or tabs to see their harmonic flow visualised.',
              ),
              UIHelper.verticalSpace(16.h),
              Text(
                'Together, these tools will transform how you learn, understand, and create music through the world’s first truly functional harmonic framework.',
               style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.c4A5565,
                ),
              ),
              UIHelper.verticalSpace(16.h),
            ],
          ),
        ),
      ),
    );
  }
}
