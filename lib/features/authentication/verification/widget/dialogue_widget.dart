import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class DialogueWidget extends StatelessWidget {
  const DialogueWidget({
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
            Center(
              child: Image.asset(
                AppImages.success,
                width: 200.w,
              ),
            ),
            UIHelper.verticalSpace(24.h),
            Text(
              "Account Create Successful",
              style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.onboardingButtonColor,
              ),
              textAlign: TextAlign.center,
            ),
            UIHelper.verticalSpace(8.h),
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
              onCallBack: (){
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
