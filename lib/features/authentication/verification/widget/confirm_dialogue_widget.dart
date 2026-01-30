import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class ConfirmDialogueWidget extends StatelessWidget {
  const ConfirmDialogueWidget({
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
        padding: EdgeInsets.all(16.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Image.asset(AppImages.success),
            ),
            UIHelper.verticalSpace(24.h),
            Text(
              'Account Create Successful',
              style: TextFontStyle.textStyle16w500c6A7282.copyWith(
                color: AppColors.c134074,
                fontSize: 18.sp
              ),
              textAlign: TextAlign.center,
            ),
            UIHelper.verticalSpace(24.h),
            Text(
              'Your account is ready to use. You will be redirected to the form page for further details',
              style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                color: AppColors.c99A1AF,
              ),
              textAlign: TextAlign.center,
            ),
            UIHelper.verticalSpace(24.h),
            CustomButton(
              name: 'Login Now',
              onCallBack: () {
                NavigationService.navigateTo(Routes.signIn);
              },
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}
