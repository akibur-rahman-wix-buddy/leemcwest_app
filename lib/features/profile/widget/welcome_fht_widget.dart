import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/features/profile/widget/bullet_text.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';
class WelcomeFhtWidget extends StatelessWidget {
  const WelcomeFhtWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome to FHT',
          style:
              TextFontStyle.headlineCinzel18w600c141313,
        ),
        UIHelper.verticalSpace(16.h),
        Text(
          'Welcome to the Functional Harmonic Theory (FHT) learning app a new, structured way to understand how harmonic movement. Instead of memorising endless scales or chord names, FHT teaches you to see the relationships between sounds the gravitational pull of each function within music.',
          style: TextFontStyle.textStyle14w400c6A7282
              .copyWith(
            color: AppColors.c4A5565,
          ),
        ),
        UIHelper.verticalSpace(16.h),
        Text(
          'Whether you’re a beginner or an experienced musician, this guide will help you get started and make the most of your learning journey.',
          style: TextFontStyle.textStyle14w400c6A7282
              .copyWith(
            color: AppColors.c4A5565,
          ),
        ),
        UIHelper.verticalSpace(16.h),
        Text(
          'How to Approach Learning FHT',
          style:
              TextFontStyle.headlineCinzel18w600c141313,
        ),
        UIHelper.verticalSpace(16.h),
        Text(
          'Here’s the best way to approach your lessons:',
          style: TextFontStyle.textStyle14w400c6A7282
              .copyWith(
                  color: AppColors.c4A5565,
                  fontSize: 16.sp),
        ),
        UIHelper.verticalSpace(16.h),
        Text(
          '1. Start with the free foundational lessons.',
          style: TextFontStyle.textStyle14w400c6A7282
              .copyWith(
            color: AppColors.c4A5565,
          ),
        ),
        UIHelper.verticalSpace(8.h),
        Text(
          'These will show you the fixed numeric system and the concept of functions (Tonic, Subdominant, Dominant)',
          style: TextFontStyle.textStyle14w400c6A7282
              .copyWith(
            color: AppColors.c4A5565,
          ),
        ),
        UIHelper.verticalSpace(16.h),
        Text(
          '2.Follow the lessons in order',
          style: TextFontStyle.textStyle14w400c6A7282
              .copyWith(
            color: AppColors.c4A5565,
          ),
        ),
        UIHelper.verticalSpace(8.h),
        Text(
          'Each lesson builds upon the last. FHT is cumulative you’ll develop understanding progressively rather than memorising isolated concepts',
          style: TextFontStyle.textStyle14w400c6A7282
              .copyWith(
            color: AppColors.c4A5565,
          ),
        ),
        UIHelper.verticalSpace(16.h),
        Text(
          '3.Listen actively.',
          style: TextFontStyle.textStyle14w400c6A7282
              .copyWith(
            color: AppColors.c4A5565,
          ),
        ),
        UIHelper.verticalSpace(8.h),
        Text(
          'Each example has an audio demonstration. Play it several times and notice how each function “feels” stable, moving, or resolving.',
          style: TextFontStyle.textStyle14w400c6A7282
              .copyWith(
            color: AppColors.c4A5565,
          ),
        ),
        UIHelper.verticalSpace(16.h),
        Text(
          '5.Visualise the flow.',
          style: TextFontStyle.textStyle14w400c6A7282
              .copyWith(
            color: AppColors.c4A5565,
          ),
        ),
        UIHelper.verticalSpace(8.h),
        Text(
          'Pay attention to the Sentence Skeleton diagrams they show how functions move across beats, creating structure and direction in music.',
          style: TextFontStyle.textStyle14w400c6A7282
              .copyWith(
            color: AppColors.c4A5565,
          ),
        ),
        UIHelper.verticalSpace(16.h),
        Text(
          'If You Play an Instrument',
          style:
              TextFontStyle.headlineCinzel18w600c141313,
        ),
        UIHelper.verticalSpace(16.h),
        Text(
          'If you already play an instrument (such as guitar, piano, or bass), apply what you learn immediately:',
          style: TextFontStyle.textStyle14w400c6A7282
              .copyWith(
            color: AppColors.c4A5565,
            fontSize: 16.sp,
          ),
        ),
        UIHelper.verticalSpace(16.h),
        const BulletText(
          text:
              'Play each sentence skeleton on your instrument after hearing the example.',
        ),
        UIHelper.verticalSpace(16.h),
        const BulletText(
          text:
              'Try transposing flows into different keys or positions.',
        ),
        UIHelper.verticalSpace(16.h),
        const BulletText(
          text:
              'Experiment with rhythm how does the same flow feel at different tempos?',
        ),
        UIHelper.verticalSpace(16.h),
        Text(
          'This hands-on approach reinforces your learning and helps you hear the gravitational flow instead of just recognising it visually.',
          style: TextFontStyle.textStyle14w400c6A7282
              .copyWith(
            color: AppColors.c4A5565,
          ),
        ),
        UIHelper.verticalSpace(16.h),
        Text(
          'If you’re not an instrumentalist, no problem — simply use the audio demonstrations in each lesson to develop your ear.',
          style: TextFontStyle.textStyle14w400c6A7282
              .copyWith(
            color: AppColors.c4A5565,
          ),
        ),
        UIHelper.verticalSpace(16.h),
        Text(
          'How Lessons Work',
          style:
              TextFontStyle.headlineCinzel18w600c141313,
        ),
        UIHelper.verticalSpace(16.h),
        const BulletText(
          text:
              'Each Lesson introduces one clear concept (for example: Tonic Function, Gravitational Movement, or Raised Dominant).',
        ),
        UIHelper.verticalSpace(16.h),
        const BulletText(
          text:
              'You’ll see text, diagrams, and an audio example that brings the theory to life.',
        ),
        UIHelper.verticalSpace(16.h),
        const BulletText(
          text:
              'Some lessons include quizzes — these test your understanding and help solidify what you’ve learned.',
        ),
        UIHelper.verticalSpace(16.h),
        Text(
          'After completing each lesson, you can move on to the next topic or revisit earlier lessons to reinforce key ideas.',
          style: TextFontStyle.textStyle14w400c6A7282
              .copyWith(
            color: AppColors.c4A5565,
          ),
        ),
        UIHelper.verticalSpace(16.h),
        Text(
          'Listening and Understanding',
          style:
              TextFontStyle.headlineCinzel18w600c141313,
        ),
      ],
    );
  }
}
