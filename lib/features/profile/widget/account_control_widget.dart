import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class AccountControlWidget extends StatelessWidget {
  final void Function() onTap;
  const AccountControlWidget({
    super.key, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.cF3F4F6,
      ),
      child: Column(
        children: [
          Center(
            child: Text(
              'Account Control',
              style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                color: AppColors.c101828,
              ),
            ),
          ),
          UIHelper.verticalSpace(24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.dangerous,
                color: Colors.redAccent,
              ),
              UIHelper.horizontalSpace(8.w),
              Text(
                'Danger Zone',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c101828,
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(12.h),
          Text(
            'Deleting your account will permanently remove all',
            style: TextFontStyle.textStyle14w400c6A7282.copyWith(
              color: AppColors.c101828,
            ),
            textAlign: TextAlign.center,
          ),
          UIHelper.verticalSpace(24.h),
          CustomButton(
            name: 'Delete Account',
            onCallBack: onTap,
            context: context,
            color: AppColors.cE7000B,
            borderColor: AppColors.cE7000B,
          )
        ],
      ),
    );
  }
}
