import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';

class BulletTextWidget extends StatelessWidget {
  final String text;
  final VoidCallback ontap;
  final Color textColor;

  const BulletTextWidget({
    super.key,
    required this.text, required this.ontap, required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: ontap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "•  ",
            style: TextStyle(
              fontSize: 18,
              height: 1.4,
            ),
          ),
          Expanded(
            child: Text(text,
                style: TextFontStyle.headlineCinzel24w500cFFFFFF.copyWith(
                  color: textColor,
                  fontSize: 16.sp,
                )),
          ),
        ],
      ),
    );
  }
}
