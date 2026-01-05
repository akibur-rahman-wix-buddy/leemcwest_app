import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/common_widgets/custom_title_appbar.dart';
import 'package:leemcwest/features/progress/widget/circular_percentage_card.dart';
import 'package:leemcwest/features/progress/widget/lesson_grade_widget.dart';
import 'package:leemcwest/features/progress/widget/percentage_container.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF9FAFB,
      appBar: const CustomTitleAppbar(
        title: 'Your F.H.T Progress',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(22.h),
              Row(
                children: [
                  const DonutPercentageCard(
                    percentage: 84,
                    size: 108,
                    progressColor: Color(0xFF0D3B66),
                    backgroundColor: Colors.white,
                  ),
                  UIHelper.horizontalSpace(12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const PercentageContainer(
                          text1: '12 of 28 lessons',
                          text2: '12/28',
                          percentage: 75,
                        ),
                        UIHelper.verticalSpace(12.h),
                        const PercentageContainer(
                          text1: 'Quizzes Done',
                          text2: '4/2',
                          percentage: 75,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              UIHelper.verticalSpace(32.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.cFFFFFF,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: AppColors.CEDBFF,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.grade,
                        ),
                        UIHelper.horizontalSpace(10.w),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Lesson Completed',
                              style: TextFontStyle.headlineCinzel18w600c141313,
                            ),
                            UIHelper.verticalSpace(4.h),
                            Text(
                              '47 of 67 Lessons completed',
                              style:
                                  TextFontStyle.textStyle12w400c64748B.copyWith(
                                color: AppColors.c99A1AF,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(20.h),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: const LessonGradeWidget(
                          title: 'Scale Degrees',
                          grade: '100%',
                          subtitle: '01 Lesson Completed',
                                                ),
                        );
                      }
                      
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}