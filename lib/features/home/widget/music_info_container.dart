import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class MusicInfoContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color? titleColor;
  final Color? btnColor;
  final String imagePath;
  final String btnText;
  void Function()? onTap;
   MusicInfoContainer({
    super.key,
    required this.title,
    this.titleColor,
    this.btnColor,
    required this.subTitle,
    required this.imagePath,
    required this.btnText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 162.h,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        image:  DecorationImage(
          image: AssetImage(
            imagePath,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextFontStyle.headlineCinzel24w700cFFFFFF.copyWith(
              fontSize: 16.sp,
              color: titleColor ?? AppColors.c1199F2,
            ),
          ),
          UIHelper.verticalSpace(8.h),
          Padding(
            padding: EdgeInsets.only(right: 70.w),
            child: Text(
              subTitle,
              style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                fontSize: 12.sp,
              ),
            ),
          ),
          UIHelper.verticalSpace(20.h),
          GestureDetector(
            onTap: () {
              NavigationService.navigateTo(Routes.functionalEarTraining);
            },
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                color: btnColor ?? AppColors.c1199F2,
              ),
              child: Text(
                btnText,
                style: TextFontStyle.headlinePoppins50014.copyWith(
                  color: AppColors.cFFFFFF,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
