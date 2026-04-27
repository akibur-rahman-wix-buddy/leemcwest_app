import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
import 'package:leemcwest/features/home/widget/correct_answer_widget.dart';
import 'package:leemcwest/features/home/widget/option_widget.dart';
import 'package:leemcwest/features/home/widget/play_sound_container.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class EarTrainingQuizScreen extends StatefulWidget {
  const EarTrainingQuizScreen({super.key});

  @override
  State<EarTrainingQuizScreen> createState() => _EarTrainingQuizScreenState();
}

class _EarTrainingQuizScreenState extends State<EarTrainingQuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cEEF3ED,
      appBar: const CustomCenterTitleAppbar(
        title: 'Functional Ear Training',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIHelper.verticalSpace(32.h),
            Center(
              child: Text(
                'Which flow do you hear?',
                style: TextFontStyle.textStyle16w500c6A7282.copyWith(
                  fontSize: 18.sp,
                  color: AppColors.c0F172B,
                ),
              ),
            ),
            UIHelper.verticalSpace(16.h),
            PlaySoundContainer(
              onTap: () {},
            ),
            UIHelper.verticalSpace(8.h),
            Center(
              child: Text(
                'Score: 1/10',
                style: TextFontStyle.textStyle16w400c6A7282,
              ),
            ),
            UIHelper.verticalSpace(8.h),
            Center(
              child: Text(
                'Incorrect',
                style: TextFontStyle.textStyle16w400c6A7282.copyWith(
                  color: AppColors.cE7000B,
                ),
              ),
            ),
            UIHelper.verticalSpace(16.h),
            Row(
              children: [
                const Expanded(
                  child: OptionWidget(
                    text: 'T → S → T',
                  ),
                ),
                UIHelper.horizontalSpace(18.w),
                Expanded(
                  child: OptionWidget(
                    text: 'T → S → T',
                    bgColor: AppColors.cF0FDF4,
                    borderColor: AppColors.c05DF72.withValues(alpha: .5),
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpace(10.h),
            Row(
              children: [
                Expanded(
                  child: OptionWidget(
                    text: 'T → S → T',
                    bgColor: AppColors.cF0FDF4,
                    borderColor: AppColors.c05DF72.withValues(alpha: .5),
                  ),
                ),
                UIHelper.horizontalSpace(18.w),
                Expanded(
                  child: OptionWidget(
                    text: 'D → S → T',
                    bgColor: AppColors.cF0FDF4,
                    borderColor: AppColors.c05DF72.withValues(alpha: .5),
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpace(16.h),
            const CorrectAnswerWidget(
              answer: 'T → S → T',
              description:
                  'A plagal cadence pattern: Tonic to Subdominant and back to Tonic, creating a softer resolution.',
            ),
            UIHelper.verticalSpace(32.h),
            Row(
              children: [
                Expanded(
                  child: customButton(
                    name: 'Tonic Root Hint',
                    context: context,
                    borderColor: AppColors.cE2E8F0,
                    color: AppColors.cFFFFFF,
                    textStyle: const TextStyle(
                      color: AppColors.c061426,
                    ),
                    onCallBack: () {},
                  ),
                ),
                UIHelper.horizontalSpace(12.w),
                Expanded(
                  child: customButton(
                    name: 'Show Answer',
                    context: context,
                    onCallBack: () {},
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpace(32.h),
            customButton(
              name: 'Next Phrase',
              context: context,
              borderColor: AppColors.c134074,
              color: AppColors.cFFFFFF,
              textStyle: const TextStyle(
                color: AppColors.c134074,
              ),
              onCallBack: () {},
            ),
          ],
        ),
      ),
    );
  }
}
