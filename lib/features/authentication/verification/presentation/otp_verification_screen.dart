import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_icons.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/common_widgets/pinput_field.dart';
import 'package:leemcwest/features/authentication/verification/widget/confirm_dialogue_widget.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/toast.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';
import 'package:leemcwest/networks/api_acess.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isLoading2 = false;
   TextEditingController otpController = TextEditingController();

  Future<void> submitOtp() async {
    setState(() {
      isLoading2 = true;
    });
    try {
      if (_formkey.currentState!.validate()) {
        final success = await resendOtpRxObj.resendOtpRx(
          email: widget.email,
        );

        if (success == true) {
          NavigationService.navigateTo(Routes.otpVerification);
        } else {
          ToastUtil.showShortToast("Error");
        }
      }
    } catch (e) {
      ToastUtil.showShortToast(e.toString());
    } finally {
      setState(() {
        isLoading2 = false;
      });
    }
  }

   Future<bool> submitForm() async {
    try {
      if (_formkey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
        await verifyEmailRxObj.verifyEmailRX(
      email: widget.email,
      otp: otpController.text,
    )
            .then(
          (value) {
            if (value) {
              setState(() {
                isLoading = false;
              });
              showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const ConfirmDialogueWidget(),
      );
            } else {
              setState(() {
                isLoading = false;
              });
            }
          },
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ToastUtil.showShortToast("An error occurred. Please try again.");
    }
    return true;
  }
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
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
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
                      'Please enter the 4 digit code sent to your email',
                      style: TextFontStyle.textStyle14w400c6A7282,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(32.h),
                Center(
                  child: PinputField(
                    controller: otpController,
                  ),
                ),
                UIHelper.verticalSpace(24.h),
                isLoading
                    ? const Center(
                        child: SpinKitCircle(
                          color: AppColors.onboardingButtonColor,
                        ),
                      )
                    : CustomButton(
                        name: 'Verify',
                        onCallBack: () {
                          submitForm();
                          log('otpController.text: ${otpController.text}');
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
                    isLoading2
                    ?
                    const Center(
                      child: SpinKitCircle(
                        color: AppColors.primaryColor2,
                      ),
                    )
                    :
                    GestureDetector(
                      onTap: () {
                        submitOtp();
                      },
                      child: Text(
                        'Resend Code',
                        style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                          color: AppColors.onboardingButtonColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
