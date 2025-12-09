import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/common_widgets/cached_image_widget.dart';
import 'package:leemcwest/features/profile/widget/information_btn.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class PersonalInformationWidget extends StatelessWidget {
  final String url;
  final String name;
  final String email;
  final void Function() onTapEdit;
  final void Function() onTapChangePassword;
  const PersonalInformationWidget({
    super.key,
    required this.url,
    required this.name,
    required this.email,
    required this.onTapEdit,
    required this.onTapChangePassword,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.cF3F4F6,
      ),
      child: Column(
        children: [
          Text(
            'Personal Information',
            style: TextFontStyle.textStyle14w400c6A7282.copyWith(
              color: AppColors.c101828,
            ),
          ),
          UIHelper.verticalSpace(16.h),
          CachedImageWidget(
            url:
                url,
            width: 86.h,
            height: 86.h,
          ),
          UIHelper.verticalSpace(16.h),
          Text(
            name,
            style: TextFontStyle.textStyle16w500c1E2939.copyWith(
              color: AppColors.c101828,
            ),
          ),
          UIHelper.verticalSpace(8.h),
          Text(
            email,
            style: TextFontStyle.textStyle14w400c6A7282.copyWith(
              fontSize: 12.sp,
              color: AppColors.c99A1AF,
            ),
          ),
          UIHelper.verticalSpace(8.h),
           InformationBtn(
            icon: Icons.edit,
            text: 'Edit Profile',
            onTap: onTapEdit,
          ),
          UIHelper.verticalSpace(8.h),
          InformationBtn(
            icon: Icons.lock,
            text: 'Change Password',
            onTap: onTapChangePassword,
          ),
        ],
      ),
    );
  }
}