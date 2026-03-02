import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class BulletTextWidget extends StatelessWidget {
  final String text;
  final Widget svg;
  final VoidCallback ontap;
  final Color textColor;
  final Color textBackgroundColor;

  const BulletTextWidget({
    super.key,
    required this.text,
    required this.ontap,
    required this.textColor,
    required this.textBackgroundColor,
    required this.svg,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(color: textBackgroundColor),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: svg),
            UIHelper.horizontalSpace(8.w),
            // const Text(
            //   "•  ",
            //   style: TextStyle(
            //     fontSize: 18,
            //     height: 1.4,
            //   ),
            // ),
            Expanded(
              child: Text(text,
                  style: TextFontStyle.headlineCinzel24w500cFFFFFF.copyWith(
                    color: textColor,
                    fontSize: 16.sp,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
