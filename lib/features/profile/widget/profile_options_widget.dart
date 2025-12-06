import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class ProfileOptionsWidget extends StatelessWidget {
  final IconData iconPath;
  final String text;
  final void Function()? onTap;

  const ProfileOptionsWidget({
    super.key,
    required this.iconPath,
    required this.text,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  color: AppColors.c1E2939.withOpacity(0.03),
                ),
                child: Icon(
                  iconPath,
                ),
              ),
              UIHelper.horizontalSpace(12.w),
              Text(
                text,
                style: TextFontStyle.textStyle16w400c141313,
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
          ),
          
        ],
      ),
    );
  }
}
