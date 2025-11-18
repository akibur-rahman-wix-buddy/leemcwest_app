import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_icons.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/common_widgets/pinput_field.dart';
import 'package:leemcwest/features/authentication/verification/widget/dialogue_widget.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            NavigationService.goBack;
          },
          child: SvgPicture.asset(
            AppIcons.back,
          ),
        ),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(36.h),
              Center(
                child: Image.asset(
                  AppImages.splashLogo,
                  width: 140.w,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Center(
                child: Text(
                  'Check your Mail',
                  style: TextFontStyle.headlineCinzel24w700cFFFFFF.copyWith(
                    fontSize: 20.sp,
                    color: AppColors.onboardingButtonColor,
                  ),
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'Please enter the 6 digit code sent to your email',
                    style: TextFontStyle.textStyle14w400c6A7282,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              UIHelper.verticalSpace(32.h),
              const Center(
                child: PinputField(),
              ),
              UIHelper.verticalSpace(24.h),
              CustomButton(
                name: 'Verify',
                onCallBack: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return const DialogueWidget();
                    },
                  );
                },
                context: context,
              ),
              UIHelper.verticalSpace(32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don’t have a code?',
                    style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                      color: AppColors.c99A1AF,
                    ),
                  ),
                  UIHelper.horizontalSpace(4.w),
                  Text(
                    'Resend Code',
                    style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                      color: AppColors.onboardingButtonColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
