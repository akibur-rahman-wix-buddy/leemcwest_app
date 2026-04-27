import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/features/lesson/widget/step_circular_progress.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class CongratulationsDialogue extends StatelessWidget {
  const CongratulationsDialogue({
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
              "Congratulations",
              style: TextFontStyle.textStyle16w500c6A7282.copyWith(
                color: AppColors.c134074,
              ),
              textAlign: TextAlign.center,
            ),
            UIHelper.verticalSpace(12.h),
            const StepCircularProgress(
              currentStep: 3,
              totalSteps: 4,
            ),
            UIHelper.verticalSpace(12.h),
            Text(
              'You are answered 3 out of 4 questions',
              style: TextFontStyle.textStyle14w400c6A7282,
              textAlign: TextAlign.center,
            ),
            UIHelper.verticalSpace(12.h),
            customButton(
              name: 'Lesson Summary',
              onCallBack: () {
                NavigationService.navigateTo(Routes.lessonSummary);
              },
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}
