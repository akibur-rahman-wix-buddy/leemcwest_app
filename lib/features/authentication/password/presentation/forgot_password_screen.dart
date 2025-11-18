import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_icons.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/common_widgets/custom_textfeild.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
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
                  'Forgot Password?',
                  style: TextFontStyle.headlineCinzel24w700cFFFFFF.copyWith(
                    fontSize: 20.sp,
                    color: AppColors.onboardingButtonColor,
                  ),
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Center(
                child: Text(
                  'Don\'t worry! It occurs. Please enter the email address linked with your account.',
                  style: TextFontStyle.textStyle14w400c6A7282,
                  textAlign: TextAlign.center,
                ),
              ),
              UIHelper.verticalSpace(32.h),
              Text(
                'Email',
                style: TextFontStyle.textStyle14w500c0A2340,
              ),
              UIHelper.verticalSpace(8.h),
              CustomTextField(
                controller: emailController,
                hintText: 'Enter Email',
                fillColor: AppColors.cF3F4F6,
                borderRadius: 8.r,
              ),
              UIHelper.verticalSpace(24.h),
              CustomButton(
                name: 'Resend Code',
                onCallBack: (){
                  NavigationService.navigateTo(Routes.createPassword);
                },
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
