import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class DialogueWidget extends StatelessWidget {
  final VoidCallback onTapDelete;
  const DialogueWidget({
    super.key,
    required this.onTapDelete,
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
              child: Text(
                'Are You sure?',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.c101828,
                ),
              ),
            ),
            UIHelper.verticalSpace(24.h),
            Text(
              'Are you sure you want to delete your account and all associated data? This action is permanent.”',
              style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                color: AppColors.c4A5565,
              ),
              textAlign: TextAlign.center,
            ),
            UIHelper.verticalSpace(24.h),
            Row(
              children: [
                Expanded(
                  child: customButton(
                    name: 'Cancel',
                    onCallBack: () {
                      NavigationService.goBack;
                    },
                    context: context,
                  ),
                ),
                UIHelper.horizontalSpace(4.w),
                Expanded(
                  child: customButton(
                    name: 'Delete',
                    color: AppColors.cE7000B,
                    borderColor: AppColors.cE7000B,
                    onCallBack: onTapDelete,
                    context: context,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
