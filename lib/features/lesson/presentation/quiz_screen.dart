import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
import 'package:leemcwest/features/lesson/widget/answer_sheet_dialogue.dart';
import 'package:leemcwest/features/lesson/widget/quiz_container.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF9FAFB,
      appBar: const CustomCenterTitleAppbar(
        title: 'QUIZ',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(16.h),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: AppColors.cFFFFFF,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1.What is harmonic function?',
                          style: TextFontStyle.textStyle14w500c6A7282.copyWith(
                            fontSize: 16.sp,
                            color: AppColors.c364153,
                          ),
                        ),
                        UIHelper.verticalSpace(20.h),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(20.sp),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.sp),
                              color: AppColors.cF3F4F6,
                            ),
                            child: Row(
                              children: [
                                isSelected
                                    ? Image.asset(
                                        AppImages.selected,
                                        width: 20.w,
                                      )
                                    : Image.asset(
                                        AppImages.unselected,
                                        width: 20.w,
                                      ),
                                UIHelper.horizontalSpace(8.w),
                                Text(
                                  'Retry Quiz',
                                  style: TextFontStyle.textStyle14w400c6A7282
                                      .copyWith(
                                    color: AppColors.c061426,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              UIHelper.verticalSpace(16.h),
              const Row(
                children: [
                  Expanded(
                    child: QuizContainer(),
                  ),
                ],
              ),
              UIHelper.verticalSpace(24.h),
              CustomButton(
                name: 'Submit Answer',
                onCallBack: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return const AnswerSheetDialogue();
                    },
                  );
                },
                context: context,
              ),
              UIHelper.verticalSpace(47.h),
            ],
          ),
        ),
      ),
    );
  }
}
