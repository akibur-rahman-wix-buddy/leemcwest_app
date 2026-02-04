import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/common_widgets/cached_image_widget.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
import 'package:leemcwest/common_widgets/custom_textfeild.dart';
import 'package:leemcwest/constants/app_constants.dart';
import 'package:leemcwest/helpers/di.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/toast.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';
import 'package:leemcwest/networks/api_acess.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  File? profileImage;
  final ImagePicker _picker = ImagePicker();
   final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Future<void> submitForm() async {
    try {
      if (formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
        await editProfileRxObj
            .editProfileRx(
                name: nameController.text,
                phone: phoneController.text,
                avatar: profileImage)
            .then(
          (value) {
            if (value) {
              setState(() {
                isLoading = false;
              });
              ToastUtil.showShortToast("Profile updated successfully");
              NavigationService.goBack;
            } else {
              setState(() {
                isLoading = false;
              });
              ToastUtil.showShortToast("Failed to submit Bug report");
            }
          },
        );
      }
    } catch (e) {
      ToastUtil.showShortToast(e.toString());
    }
  }
  @override
  void initState() {
    super.initState();
    nameController.text = appData.read(kKeyName);
    emailController.text = appData.read(kKeyEmail);
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF9FAFB,
      appBar: const CustomCenterTitleAppbar(
        title: 'Edit Profile',
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.verticalSpace(32.h),
                GestureDetector(
                  onTap: () {
                    pickImage();
                  },
                  child: Center(
                    child: profileImage != null
                        ? ClipOval(
                            child: Image.file(
                              profileImage!,
                              height: 104.h,
                              width: 104.w,
                              fit: BoxFit.cover,
                            ),
                          )
                        : CachedImageWidget(
                            url:
                                'https://img.freepik.com/premium-vector/young-man-avatar-character-due-avatar-man-vector-icon-cartoon-illustration_1186924-4438.jpg?semt=ais_hybrid&w=740&q=80',
                            height: 104.h,
                            width: 104.w,
                          ),
                  ),
                ),
                UIHelper.verticalSpace(32.h),
                Text(
                  'Your Name',
                  style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.c141313,
                  ),
                ),
                UIHelper.verticalSpace(8.h),
                CustomTextField(
                  controller: nameController,
                  hintText: 'Enter your name',
                ),
                UIHelper.verticalSpace(20.h),
                Text(
                  'Your Email',
                  style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.c141313,
                  ),
                ),
                UIHelper.verticalSpace(8.h),
                CustomTextField(
                  controller: emailController,
                  hintText: 'Enter your email',
                  readOnly: true,
                ),
                UIHelper.verticalSpace(20.h),
                Text(
                  'Phone Number',
                  style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.c141313,
                  ),
                ),
                UIHelper.verticalSpace(8.h),
                CustomTextField(
                  controller: phoneController,
                  hintText: 'Enter your number',
                ),
                UIHelper.verticalSpace(32.h),
                isLoading
                ?
                const Center(
                  child: SpinKitCircle(
                    color: AppColors.primaryColor2,
                  ),
                )
                :
                CustomButton(
                  name: 'Update',
                  onCallBack: () {
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
