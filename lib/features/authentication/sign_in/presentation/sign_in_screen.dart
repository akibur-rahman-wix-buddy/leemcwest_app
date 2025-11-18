import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/common_widgets/custom_alternative_widget.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/common_widgets/custom_textfeild.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(60.h),
              Center(
                child: Image.asset(
                  AppImages.splashLogo,
                  width: 140.w,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Center(
                child: Text(
                  'Login to your account',
                  style: TextFontStyle.headlineCinzel24w700cFFFFFF.copyWith(
                    color: AppColors.onboardingButtonColor,
                    fontSize: 20.sp,
                  ),
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
                fillColor: AppColors.cF3F4F6,
                borderRadius: 8.r,
                hintText: 'Enter Email',
                inputAction: TextInputAction.next,
              ),
              UIHelper.verticalSpace(16.h),
              Text(
                'Password',
                style: TextFontStyle.textStyle14w500c0A2340,
              ),
              UIHelper.verticalSpace(8.h),
              CustomTextField(
                controller: passwordController,
                fillColor: AppColors.cF3F4F6,
                borderRadius: 8.r,
                hintText: 'Enter your password',
                isPassword: true,
                
              ),
              UIHelper.verticalSpace(12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      NavigationService.navigateTo(Routes.forgotPassword);
                    },
                    child: Text(
                      'Forgot password?',
                      style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                        color: AppColors.onboardingButtonColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(24.h),
              CustomButton(
                name: 'Login',
                onCallBack: () {
                  NavigationService.navigateToReplacement(Routes.earTraining);
                },
                context: context,
              ),
              UIHelper.verticalSpace(24.h),
              CustomAlternativeWidget(
                text: 'Or continue with',
              ),
              UIHelper.verticalSpace(24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.google,
                      width: 48.w,
                    ),
                    UIHelper.horizontalSpace(24.w),
                    Image.asset(
                      AppImages.apple,
                      width: 48.w,
                    ),
                  ],
                ),
                UIHelper.verticalSpace(24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account?',
                      style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                        color: AppColors.c99A1AF,
                      ),
                    ),
                    UIHelper.horizontalSpace(4.w),
                    GestureDetector(
                      onTap: () {
                        NavigationService.navigateTo(Routes.signUp);
                      },
                      child: Text(
                        'Sign up',
                        style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                          color: AppColors.onboardingButtonColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(24.h),
            ],
          ),
        ),
      ),
    );
  }
}
