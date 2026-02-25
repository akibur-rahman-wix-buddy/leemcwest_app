// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:leemcwest/assets_helper/app_colors.dart';
// import 'package:leemcwest/assets_helper/app_fonts.dart';
// import 'package:leemcwest/assets_helper/app_image.dart';
// import 'package:leemcwest/common_widgets/custom_button.dart';
// import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
// import 'package:leemcwest/features/lesson/widget/answer_sheet_dialogue.dart';
// import 'package:leemcwest/helpers/ui_helpers.dart';
// import 'package:leemcwest/networks/api_acess.dart';

// class QuizScreen extends StatefulWidget {
//   final int id;

//   const QuizScreen({super.key, required this.id});

//   @override
//   State<QuizScreen> createState() => _QuizScreenState();
// }

// class _QuizScreenState extends State<QuizScreen> {
//   Map<int, dynamic> selectedAnswers = {};

//   @override
//   void initState() {
//     super.initState();
//     getLessonQuizRXObj.getLessonQuizRX(lessonId: widget.id);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.cF9FAFB,
//       appBar: const CustomCenterTitleAppbar(title: "QUIZ"),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         child: StreamBuilder(
//           stream: getLessonQuizRXObj.dataFetcher,
//           builder: (context, snapshot) {
//             final quizList = snapshot.data?.data;

//             if (snapshot.connectionState == ConnectionState.waiting &&
//                 quizList == null) {
//               return Center(
//                 child: SpinKitCircle(
//                   color: AppColors.primaryColor,
//                   size: 50.sp,
//                 ),
//               );
//             }

//             if (quizList == null || quizList.isEmpty) {
//               return const Center(child: Text("No Quiz Found"));
//             }

//             final mcqList = quizList[0].mcq;

//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   /// Questions
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: mcqList?.length,
//                     itemBuilder: (context, index) {
//                       final mcqList = quizList[index];

//                       return buildQuestionWidget(
//                         mcqList,
//                         index,
//                       );
//                     },
//                   ),

//                   UIHelper.verticalSpace(20.h),

//                   /// Submit Button
//                   CustomButton(
//                     name: "Submit Answer",
//                     onCallBack: () {
//                       showDialog(
//                         context: context,
//                         builder: (_) => const AnswerSheetDialogue(),
//                       );
//                     },
//                     context: context,
//                   ),

//                   UIHelper.verticalSpace(40.h),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   /// Main Question Builder
//   Widget buildQuestionWidget(question, int index) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 16.h),
//       padding: EdgeInsets.all(16.sp),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           /// Question text
//           Text(
//             "${index + 1}. ${question.questionText}",
//             style: TextFontStyle.textStyle14w500c6A7282.copyWith(
//               fontSize: 16.sp,
//               color: AppColors.c364153,
//             ),
//           ),

//           UIHelper.verticalSpace(12.h),
//           buildMCQ(question)

//           // /// Dynamic type rendering
//           // if (question.type == "mcq")
//           //   buildMCQ(question)
//           // else if (question.type == "tap_order")
//           //   buildTapOrder(question)
//           // else if (question.type == "drag_drop")
//           //   DragDropQuestionWidget(question: question)
//         ],
//       ),
//     );
//   }

//   /// MCQ Widget
//   Widget buildMCQ(question) {
//     List options = question.options;

//     return Column(
//       children: List.generate(options.length, (i) {
//         bool selected = selectedAnswers[question.id] == i;

//         return GestureDetector(
//           onTap: () {
//             setState(() {
//               selectedAnswers[question.id] = i;
//             });
//           },
//           child: Container(
//             margin: EdgeInsets.only(bottom: 10.h),
//             padding: EdgeInsets.all(14.sp),
//             decoration: BoxDecoration(
//               color: AppColors.cF3F4F6,
//               borderRadius: BorderRadius.circular(10.r),
//             ),
//             child: Row(
//               children: [
//                 Image.asset(
//                   selected ? AppImages.selected : AppImages.unselected,
//                   width: 20.w,
//                 ),
//                 UIHelper.horizontalSpace(10.w),
//                 Expanded(
//                   child: Text(
//                     options[i],
//                     style: TextFontStyle.textStyle14w400c6A7282.copyWith(
//                       color: AppColors.c061426,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }

//   /// Tap Order Widget
//   Widget buildTapOrder(question) {
//     List options = question.options;

//     return Wrap(
//       spacing: 10,
//       children: List.generate(options.length, (i) {
//         return GestureDetector(
//           onTap: () {
//             setState(() {
//               selectedAnswers[question.id] = i;
//             });
//           },
//           child: Chip(
//             label: Text(options[i]),
//           ),
//         );
//       }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
import 'package:leemcwest/features/lesson/widget/answer_sheet_dialogue.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';
import 'package:leemcwest/networks/api_acess.dart';

class QuizScreen extends StatefulWidget {
  final int id;

  const QuizScreen({super.key, required this.id});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Map<int, dynamic> selectedAnswers = {};

  @override
  void initState() {
    super.initState();
    getLessonQuizRXObj.getLessonQuizRX(lessonId: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF9FAFB,
      appBar: const CustomCenterTitleAppbar(title: "QUIZ"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: StreamBuilder(
          stream: getLessonQuizRXObj.dataFetcher,
          builder: (context, snapshot) {
            final quizData = snapshot.data?.data;

            if (snapshot.connectionState == ConnectionState.waiting &&
                quizData == null) {
              return Center(
                child: SpinKitCircle(
                  color: AppColors.primaryColor,
                  size: 50.sp,
                ),
              );
            }

            if (quizData == null || quizData.isEmpty) {
              return const Center(child: Text("No Quiz Found"));
            }

            /// ✅ Correct: Access mcq list properly
            final mcqList = quizData[0].mcq ?? [];

            return SingleChildScrollView(
              child: Column(
                children: [
                  /// Questions
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: mcqList.length,
                    itemBuilder: (context, index) {
                      final question = mcqList[index];

                      return buildQuestionWidget(
                        question,
                        index,
                      );
                    },
                  ),

                  UIHelper.verticalSpace(20.h),

                  /// Submit Button
                  CustomButton(
                    name: "Submit Answer",
                    onCallBack: () {
                      showDialog(
                        context: context,
                        builder: (_) => const AnswerSheetDialogue(),
                      );
                    },
                    context: context,
                  ),

                  UIHelper.verticalSpace(40.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Main Question Builder
  Widget buildQuestionWidget(dynamic question, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ✅ Correct property name
          Text(
            "${index + 1}. ${question.questionText ?? ""}",
            style: TextFontStyle.textStyle14w500c6A7282.copyWith(
              fontSize: 16.sp,
              color: AppColors.c364153,
            ),
          ),

          UIHelper.verticalSpace(12.h),

          buildMCQ(question),
        ],
      ),
    );
  }

  /// MCQ Widget
  Widget buildMCQ(dynamic question) {
    final List options = question.options ?? [];

    return Column(
      children: List.generate(options.length, (i) {
        bool selected = selectedAnswers[question.id] == i;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedAnswers[question.id] = i;
            });
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 10.h),
            padding: EdgeInsets.all(14.sp),
            decoration: BoxDecoration(
              color: AppColors.cF3F4F6,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                Image.asset(
                  selected ? AppImages.selected : AppImages.unselected,
                  width: 20.w,
                ),
                UIHelper.horizontalSpace(10.w),
                Expanded(
                  child: Text(
                    options[i].toString(),
                    style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                      color: AppColors.c061426,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
