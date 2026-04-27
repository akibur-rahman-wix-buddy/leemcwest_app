import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_icons.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
import 'package:leemcwest/common_widgets/custom_textfeild.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/toast.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';
import 'package:leemcwest/networks/api_acess.dart';

class ReportABugScreen extends StatefulWidget {
  const ReportABugScreen({super.key});

  @override
  State<ReportABugScreen> createState() => _ReportABugScreenState();
}

class _ReportABugScreenState extends State<ReportABugScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final emailController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Future<void> submitForm() async {
    try {
      if (formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
        await postBugReportRxObj
            .postBugReportRx(
                email: emailController.text,
                title: titleController.text,
                description: descriptionController.text,
                screenshot: _selectedImage)
            .then(
          (value) {
            if (value) {
              setState(() {
                isLoading = false;
              });
              ToastUtil.showShortToast("Bug report submitted successfully");
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

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      appBar: const CustomCenterTitleAppbar(
        title: 'Report A bug',
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.verticalSpace(12.h),
                Center(
                  child: Text(
                    'Help us improve by describing issue',
                    style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                      color: AppColors.c1E2939,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(18.h),
                Text(
                  'Issue Title',
                  style: TextFontStyle.textStyle14w500c6A7282.copyWith(
                    color: AppColors.c0A2340,
                  ),
                ),
                UIHelper.verticalSpace(8.h),
                CustomTextField(
                  controller: titleController,
                  fillColor: AppColors.cF3F4F6,
                  borderRadius: 8.r,
                  hintText: 'Issue Title',
                  inputAction: TextInputAction.next,
                ),
                UIHelper.verticalSpace(20.h),
                Text(
                  'Description',
                  style: TextFontStyle.textStyle14w500c6A7282.copyWith(
                    color: AppColors.c0A2340,
                  ),
                ),
                UIHelper.verticalSpace(8.h),
                CustomTextField(
                  controller: descriptionController,
                  fillColor: AppColors.cF3F4F6,
                  borderRadius: 8.r,
                  hintText: 'Description of the bug',
                  inputAction: TextInputAction.next,
                ),
                UIHelper.verticalSpace(20.h),
                Text(
                  'Email',
                  style: TextFontStyle.textStyle14w500c6A7282.copyWith(
                    color: AppColors.c0A2340,
                  ),
                ),
                UIHelper.verticalSpace(8.h),
                CustomTextField(
                  controller: emailController,
                  fillColor: AppColors.cF3F4F6,
                  borderRadius: 8.r,
                  hintText: 'Your Email ( Optional)',
                ),
                UIHelper.verticalSpace(20.h),
                Row(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 68.w,
                        height: 68.w,
                        decoration: BoxDecoration(
                          color: AppColors.cF3F4F6,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColors.c6A7282),
                        ),
                        child: _selectedImage == null
                            ? Center(
                                child: SvgPicture.asset(
                                  AppIcons.upload,
                                  width: 24.w,
                                  height: 24.w,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    UIHelper.horizontalSpace(20.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upload Screenshot',
                          style: TextFontStyle.textStyle14w500c6A7282.copyWith(
                            color: AppColors.c1E2939,
                            fontSize: 16.sp,
                          ),
                        ),
                        UIHelper.verticalSpace(8.h),
                        Text(
                          '(Optional)',
                          style: TextFontStyle.textStyle14w400c6A7282,
                        ),
                      ],
                    ),
                  ],
                ),
                UIHelper.verticalSpace(32.h),
                isLoading
                    ? const Center(
                        child: SpinKitCircle(
                          color: AppColors.primaryColor2,
                        ),
                      )
                    : customButton(
                        name: 'Submit Report',
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
