import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class MusicNameContainer extends StatelessWidget {
  final String name;
  final int duration;
  const MusicNameContainer({
    super.key,
    required this.name,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.cFFFFFF,
        border: Border.all(
          color: AppColors.cE2E8F0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(16.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.c134074,
                ),
                child: const Icon(
                  Icons.music_note,
                  color: AppColors.cFFFFFF,
                ),
              ),
              UIHelper.horizontalSpace(10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextFontStyle.textStyle16w600c020617,
                  ),
                  UIHelper.verticalSpace(4.h),
                  Text(
                    '$duration Hours ago',
                    style: TextFontStyle.textStyle12w400c64748B,
                  ),
                ],
              )
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
