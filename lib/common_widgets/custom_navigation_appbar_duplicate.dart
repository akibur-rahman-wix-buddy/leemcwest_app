import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

// ignore: must_be_immutable
class CustomNavigationAppbarDuplicate extends StatelessWidget {
  final String title;
  final String subTitle;
  final String url;
  VoidCallback onTapNotification;

  CustomNavigationAppbarDuplicate(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.url,
      required this.onTapNotification});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.sp),
        height: 120.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.r),
            bottomRight: Radius.circular(30.r),
          ),
          color: AppColors.c124074,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIHelper.verticalSpace(32.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  AppImages.menu,
                  width: 38.w,
                ),
                UIHelper.horizontalSpace(8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextFontStyle.headlineCinzel24w700cFFFFFF.copyWith(
                        fontSize: 18.sp
                      ),
                    ),
                  ],
                ),
                UIHelper.horizontalSpace(8.w),
                GestureDetector(
                  onTap: onTapNotification,
                  child: Container(
                    padding: EdgeInsets.all(10.sp),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.cFFFFFF),
                    child: Image.asset(
                      AppImages.notification,
                      width: 24.w,
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
