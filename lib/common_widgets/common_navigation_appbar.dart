import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class CommonNavigationAppbar extends StatelessWidget {
  final String title;

  const CommonNavigationAppbar(
      {super.key,
      required this.title,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.sp),
        height: 100.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.r),
            bottomRight: Radius.circular(30.r),
          ),
          color: AppColors.c134074,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIHelper.verticalSpace(32.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.arrow_back_ios,
                    color: AppColors.cFFFFFF, size: 24.sp),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextFontStyle.headlineCinzel18w600c141313.copyWith(
                        color: AppColors.cFFFFFF,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_back,
                    color: Colors.transparent, size: 24.sp),
              ],
            )
          ],
        ),
        );
  }
}
