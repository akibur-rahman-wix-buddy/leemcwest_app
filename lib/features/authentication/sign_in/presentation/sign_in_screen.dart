import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/common_widgets/custom_alternative_widget.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/common_widgets/custom_textfeild.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/social_login_helper.dart';
import 'package:leemcwest/helpers/toast.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';
import 'package:leemcwest/networks/api_acess.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isLoadingSocial = false;

  Future<void> submitForm() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        final success = await loginRxObj.loginRX(
          email: emailController.text,
          password: passwordController.text,
        );

        if (success == true) {
          NavigationService.navigateTo(Routes.navigation);
        } else {
          ToastUtil.showShortToast("Invalid Credentials");
        }
      }
    } catch (e) {
      ToastUtil.showShortToast(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: Form(
        key: _formKey,
        child: Padding(
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
                isLoading
                    ? const Center(
                        child: SpinKitCircle(
                          color: AppColors.primaryColor2,
                        ),
                      )
                    : customButton(
                        name: 'Login',
                        onCallBack: () {
                          submitForm();
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
                    isLoadingSocial
                        ? SizedBox(
                            width: 48.w,
                            height: 48.w,
                            child: const SpinKitCircle(
                              color: AppColors.primaryColor2,
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              setState(() {
                                isLoadingSocial = true;
                              });

                              var google = SocialLoginHelper.instance;
                              bool value =
                                  await google.signInWithGoogle(context);

                              setState(() {
                                isLoadingSocial = false;
                              });
                              log('============Value Not Working');

                              if (value) {
                                // await sentFCMToken();
                                // checkSubscription();

                                NavigationService.navigateTo(Routes.navigation);

                                ToastUtil.showShortToast(
                                  "Log in Success",
                                );
                              } else {
                                log('>>>login Fail');
                              }
                            },
                            child: Image.asset(
                              AppImages.google,
                              width: 48.w,
                            ),
                          ),
                    // GestureDetector(
                    //   onTap: isLoadingSocial
                    //       ? null
                    //       : () async {
                    //           setState(() {
                    //             isLoadingSocial = true;
                    //           });

                    //           var google = SocialLoginHelper.instance;
                    //           bool value =
                    //               await google.signInWithGoogle(context);

                    //           setState(() {
                    //             isLoadingSocial = false;
                    //           });

                    //           if (value) {
                    //             ToastUtil.showShortToast(
                    //                 "Social Log in Success");
                    //             NavigationService.navigateTo(
                    //                 Routes.earTraining);
                    //           }
                    //         },
                    //   child: isLoadingSocial
                    //       ? SizedBox(
                    //           width: 48.w,
                    //           height: 48.w,
                    //           child: const SpinKitCircle(
                    //             color: AppColors.primaryColor2,
                    //           ),
                    //         )
                    //       : Image.asset(
                    //           AppImages.google,
                    //           width: 48.w,
                    //         ),
                    // ),
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
      ),
    );
  }
}
