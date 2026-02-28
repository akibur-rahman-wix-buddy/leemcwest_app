import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UIHelper.verticalSpace(50.h),
            Image.asset(
              AppImages.splashLogo,
              height: 200.h,
              width: 185.h,
              fit: BoxFit.cover,
            ),
            UIHelper.verticalSpace(24.h),
            Padding(
              padding: EdgeInsets.all(12.sp),
              child: Text(
                "Why Music Theory Needs a Fresh Start ",
                textAlign: TextAlign.center,
                style: TextFontStyle.headlinecinzel70018,
              ),
            ),
            UIHelper.verticalSpace(24.h),
            Text(
              "And why Functional Numeric Harmony exists",
              textAlign: TextAlign.center,
              style: TextFontStyle.textStyle14w400c4A5565,
            )
          ],
        ),
      ),
    );
  }
}
