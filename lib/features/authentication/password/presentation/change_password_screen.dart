import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_icons.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/common_widgets/custom_textfeild.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/toast.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';
import 'package:leemcwest/networks/api_acess.dart';


class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  
  Future<void> submitForm() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        final success = await postChangePasswordRxObj.postChangePasswordRx(
          currentPassword: currentPasswordController.text, 
          password: newPasswordController.text,
          passwordConfirmation: confirmPasswordController.text,
        );

        if (success == true) {
           NavigationService.navigateTo(Routes.manageAccount);
        } else {
          ToastUtil.showShortToast("Error");
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
      appBar: AppBar(
        backgroundColor: AppColors.cFFFFFF,
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
        key: _formKey,
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
                    'Create New Password',
                    style: TextFontStyle.headlineCinzel24w700cFFFFFF.copyWith(
                      fontSize: 20.sp,
                      color: AppColors.onboardingButtonColor,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(8.h),
                Center(
                  child: Text(
                    'Set a strong password to secure access',
                    style: TextFontStyle.textStyle14w400c6A7282,
                    textAlign: TextAlign.center,
                  ),
                ),
                UIHelper.verticalSpace(32.h),
                Text(
                  'Current Password',
                  style: TextFontStyle.textStyle14w500c0A2340,
                ),
                UIHelper.verticalSpace(8.h),
                CustomTextField(
                  controller: currentPasswordController,
                  hintText: 'Current Password',
                  fillColor: AppColors.cF3F4F6,
                  borderRadius: 8.r,
                  inputAction: TextInputAction.next,
                ),
                UIHelper.verticalSpace(16.h),
                Text(
                  'New Password',
                  style: TextFontStyle.textStyle14w500c0A2340,
                ),
                UIHelper.verticalSpace(8.h),
                CustomTextField(
                  controller: newPasswordController,
                  hintText: 'New Password',
                  fillColor: AppColors.cF3F4F6,
                  borderRadius: 8.r,
                  inputAction: TextInputAction.next,
                ),
                UIHelper.verticalSpace(16.h),
                Text(
                  'Confirm Password',
                  style: TextFontStyle.textStyle14w500c0A2340,
                ),
                UIHelper.verticalSpace(8.h),
                CustomTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  fillColor: AppColors.cF3F4F6,
                  borderRadius: 8.r,
                ),
                UIHelper.verticalSpace(24.h),
                isLoading
                ? const Center(
                  child: SpinKitCircle(
                    color: AppColors.primaryColor2,
                  ),
                )
                :
                CustomButton(
                  name: 'Reset Password',
                  onCallBack: (){
                   submitForm();
                  },
                  context: context,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
