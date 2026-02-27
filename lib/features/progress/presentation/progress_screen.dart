import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_icons.dart';
import 'package:leemcwest/common_widgets/custom_title_appbar.dart';
import 'package:leemcwest/features/progress/widget/circular_percentage_card.dart';
import 'package:leemcwest/features/progress/widget/lesson_grade_widget.dart';
import 'package:leemcwest/features/progress/widget/percentage_container.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';
import 'package:leemcwest/networks/api_acess.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  void initState() {
    super.initState();
    getProgressRXObj.getProgressRX();
  }

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
            child: StreamBuilder(
                stream: getProgressRXObj.dataFetcher,
                builder: (context, snapshot) {
                  final data = snapshot.data?.data;
                  final lessonItem =
                      snapshot.data?.data?.lessonCompleted?.items;

                  final quizTaken = snapshot.data?.data?.quizzesTaken?.items;

                  if (snapshot.connectionState == ConnectionState.waiting &&
                      data == null) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Center(
                        child: SizedBox(
                          height: 80.h,
                          width: 60.w,
                          child: SpinKitCircle(
                            color: AppColors.primaryColor,
                            size: 60.h,
                          ),
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text(""));
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UIHelper.verticalSpace(22.h),
                      Row(
                        children: [
                          DonutPercentageCard(
                            percentage: data?.totalProgress!.toDouble() ?? 0,
                            size: 108,
                            progressColor: Color(0xFF0D3B66),
                            backgroundColor: Colors.white,
                          ),
                          UIHelper.horizontalSpace(12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PercentageContainer(
                                  text1: data?.lessonCompleted?.summary ?? '',
                                  text2: data?.progressFraction ?? "",
                                  percentage: 75,
                                ),
                                UIHelper.verticalSpace(12.h),
                                PercentageContainer(
                                    text1: 'Quizzes Done',
                                    text2: data?.quizzesDone ?? "",
                                    percentage: 75
                                    // data.totalProgress??"",
                                    ),
                              ],
                            ),
                          )
                        ],
                      ),
                      UIHelper.verticalSpace(32.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 16.h),
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
                                SvgPicture.asset(AppIcons.lessonCompleted),
                                UIHelper.horizontalSpace(10.w),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Lesson Completed',
                                      style: TextFontStyle
                                          .headlineCinzel18w600c141313,
                                    ),
                                    UIHelper.verticalSpace(4.h),
                                    Text(
                                      data?.lessonCompleted?.summary ?? "",
                                      style: TextFontStyle
                                          .textStyle12w400c64748B
                                          .copyWith(
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
                                itemCount: lessonItem?.length,
                                itemBuilder: (context, index) {
                                  final lessonDetails = lessonItem?[index];
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 12.h),
                                    child: LessonGradeWidget(
                                      title: lessonDetails?.title ?? "",
                                      grade:
                                          lessonDetails?.progressPercentage ??
                                              0,
                                      subtitle:
                                          "${lessonDetails?.lessonId} ${lessonDetails?.status ?? ""}",
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                      UIHelper.verticalSpace(32.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 16.h),
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
                                SvgPicture.asset(AppIcons.quizCompleted),
                                UIHelper.horizontalSpace(10.w),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Quizzes Taken',
                                      style: TextFontStyle
                                          .headlineCinzel18w600c141313,
                                    ),
                                    UIHelper.verticalSpace(4.h),
                                    Text(
                                      data?.quizzesTaken?.summary ?? "",
                                      style: TextFontStyle
                                          .textStyle12w400c64748B
                                          .copyWith(
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
                                itemCount: quizTaken?.length,
                                itemBuilder: (context, index) {
                                  final quizDetails = quizTaken?[index];
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 12.h),
                                    child: LessonGradeWidget(
                                      title: quizDetails?.title ?? "No Title",
                                      grade:
                                          quizDetails?.progressPercentage ?? 0,
                                      subtitle:
                                          "${quizDetails?.quizId} ${quizDetails?.status ?? ""}",
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ],
                  );
                })),
      ),
    );
  }
}
