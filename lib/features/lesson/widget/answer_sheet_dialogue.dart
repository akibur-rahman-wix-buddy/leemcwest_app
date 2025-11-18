import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/features/lesson/widget/correct_ans_widget.dart';
import 'package:leemcwest/features/lesson/widget/quiz_option.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class AnswerSheetDialogue extends StatelessWidget {
  const AnswerSheetDialogue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.cFFFFFF,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "What is harmonic function?",
              style: TextFontStyle.textStyle16w500c6A7282.copyWith(
                color: AppColors.c364153,
              ),
              textAlign: TextAlign.center,
            ),
            UIHelper.verticalSpace(22.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: AppColors.cFB2C36.withOpacity(0.5),
                ),
                color: AppColors.cFEF2F2,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Oops! That\'s not right — the correct answer is shown below',
                      style: TextFontStyle.headlineArial40016,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpace(22.h),
            const CorrectAnsWidget(
              imagePath: AppImages.errorAns,
              imagePath2: AppImages.wrongAns,
            ),
            UIHelper.verticalSpace(22.h),
            const QuizOption(),
            UIHelper.verticalSpace(22.h),
            const CorrectAnsWidget(
              imagePath: AppImages.unselected,
              imagePath2: AppImages.correctAns,
              borderColor: AppColors.c05DF72,
              bgColor: AppColors.cF0FDF4,
            ),
            UIHelper.verticalSpace(22.h),
            const QuizOption(),
            UIHelper.verticalSpace(22.h),
            CustomButton(
              name: 'Next',
              onCallBack: (){
                NavigationService.goBack;
              },
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}