import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
import 'package:leemcwest/features/lesson/widget/quiz_drag_widget.dart';
import 'package:leemcwest/features/lesson/widget/step_circular_progress.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/toast.dart';
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
  bool isLoading = false;
  int totalQuestionCount = 0;

  @override
  void initState() {
    super.initState();
    selectedAnswers.clear();
    getLessonQuizRXObj.getLessonQuizRX(lessonId: widget.id);
  }

  Future<Map<String, dynamic>?> submitAnswerMethod() async {
    try {
      if (selectedAnswers.length < totalQuestionCount) {
        ToastUtil.showShortToast("Please answer all questions");
        return null;
      }

      setState(() => isLoading = true);

      List<Map<String, dynamic>> formattedAnswers = [];

      selectedAnswers.forEach((questionId, answerValue) {
        formattedAnswers.add({
          "question_id": questionId,
          "answer": answerValue,
        });
      });

      // Call your Rx API
      final success = await submitAnswerRxObj.submitAnswerRx(
        lessonId: widget.id,
        answers: formattedAnswers,
      );

      setState(() => isLoading = false);

      if (success) {
        // Return the API response
        return submitAnswerRxObj.getFileData.valueOrNull;
      } else {
        ToastUtil.showShortToast("Failed to submit answer");
        return null;
      }
    } catch (e) {
      setState(() => isLoading = false);
      ToastUtil.showShortToast(e.toString());
      return null;
    }
  }

  // Future<bool> submitAnswerMethod() async {
  //   try {
  //     if (selectedAnswers.length < totalQuestionCount) {
  //       ToastUtil.showShortToast("Please answer all questions");
  //       return false;
  //     }

  //     setState(() => isLoading = true);

  //     List<Map<String, dynamic>> formattedAnswers = [];

  //     selectedAnswers.forEach((questionId, answerValue) {
  //       formattedAnswers.add({
  //         "question_id": questionId,
  //         "answer": answerValue,
  //       });
  //     });

  //     bool success = await submitAnswerRxObj.submitAnswerRx(
  //       lessonId: widget.id,
  //       answers: formattedAnswers,
  //     );

  //     setState(() => isLoading = false);

  //     if (success) {
  //       ToastUtil.showShortToast('Answer Submitted Successfully');
  //       return true;
  //     }

  //     return false;
  //   } catch (e) {
  //     setState(() => isLoading = false);
  //     ToastUtil.showShortToast(e.toString());
  //     return false;
  //   }
  // }

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

            final lesson = quizData[0];

            /// ====== CALCULATE TOTAL QUESTIONS ======
            ///

            totalQuestionCount = (lesson.mcq?.length ?? 0) +
                (lesson.tapOrder?.length ?? 0) +
                (lesson.dragDrop?.length ?? 0);

            // totalQuestionCount = 0;
            // if (lesson.mcq != null) totalQuestionCount += lesson.mcq!.length;
            // if (lesson.tapOrder != null)
            //   totalQuestionCount += lesson.tapOrder!.length;
            // if (lesson.dragDrop != null)
            //   totalQuestionCount += lesson.dragDrop!.length;

            int questionNumber = 0;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ================= MCQ =================
                  if (lesson.mcq != null && lesson.mcq!.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: lesson.mcq!.length,
                      itemBuilder: (context, index) {
                        questionNumber++;
                        final question = lesson.mcq![index];
                        return buildQuestionWidget(question, questionNumber);
                      },
                    ),

                  /// ================= TAP ORDER =================
                  if (lesson.tapOrder != null && lesson.tapOrder!.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: lesson.tapOrder!.length,
                      itemBuilder: (context, index) {
                        questionNumber++;
                        final question = lesson.tapOrder![index];
                        return buildQuestionWidget(question, questionNumber);
                      },
                    ),

                  // / ================= DRAG DROP =================

                  if (lesson.dragDrop != null && lesson.dragDrop!.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: lesson.dragDrop!.length,
                      itemBuilder: (context, index) {
                        questionNumber++;
                        final question = lesson.dragDrop![index];
                        return buildQuestionWidget(question, questionNumber);
                      },
                    ),

                  UIHelper.verticalSpace(20.h),

                  isLoading
                      ? Center(
                          child: SpinKitCircle(
                            color: AppColors.primaryColor,
                            size: 60.h,
                          ),
                        )
                      : CustomButton(
                          name: "Submit Answer",
                          onCallBack: () async {
                            final apiResponse = await submitAnswerMethod();

                            if (apiResponse != null) {
                              final answered = apiResponse['answered'] ??
                                  0; // adjust key names from your API
                              final total =
                                  apiResponse['total'] ?? totalQuestionCount;

                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  backgroundColor: AppColors.cFFFFFF,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(16.sp),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("Congratulations",
                                            style: TextFontStyle
                                                .headlinePublicSans60024
                                                .copyWith(fontSize: 20)),
                                        UIHelper.verticalSpace(12.h),
                                        StepCircularProgress(
                                            currentStep: answered,
                                            totalSteps: total),
                                        UIHelper.verticalSpace(12.h),
                                        Text(
                                            "You answered $answered out of $total questions",
                                            style: TextFontStyle
                                                .headline40014c989BA2
                                                .copyWith(
                                                    color: AppColors.c6A7282)),
                                        UIHelper.verticalSpace(12.h),
                                        CustomButton(
                                          name: "Lesson Summary",
                                          onCallBack: () {
                                            NavigationService
                                                .navigateToWithArgs(
                                                    Routes.lessonSummary,
                                                    {"id": widget.id});
                                          },
                                          context: context,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
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

  /// ================= QUESTION BUILDER =================
  Widget buildQuestionWidget(dynamic question, int number) {
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
          Text(
            "$number. ${question.questionText ?? ""}",
            style: TextFontStyle.textStyle14w500c6A7282.copyWith(
              fontSize: 16.sp,
              color: AppColors.c364153,
            ),
          ),
          UIHelper.verticalSpace(12.h),
          if (question.type == "mcq")
            buildMCQ(question)
          else if (question.type == "tap_order")
            buildTapOrder(question)
          else if (question.type == "drag_drop")
            DragDropQuestionWidget(
              question: question,
              onAnswer: (questionId, answerList) {
                selectedAnswers[questionId] = answerList;
              },
              checkOntap: () {
                List<int> selected = selectedAnswers[question.id] ?? [];

                print("Question ID: ${question.id}");
                print("Selected Indexes: $selected");
              },
            ),
        ],
      ),
    );
  }

  /// ================= MCQ =================
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
                  child: Text(options[i].toString()),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  // 🔹 Tap Order
  Widget buildTapOrder(dynamic question) {
    final List options = question.options ?? [];

    selectedAnswers.putIfAbsent(question.id, () => <int>[]);
    List<int> selectedList = selectedAnswers[question.id];

    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(options.length, (index) {
            bool alreadySelected = selectedList.contains(index);

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (alreadySelected) {
                    selectedList.remove(index);
                  } else {
                    selectedList.add(index);
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: alreadySelected
                      ? Colors.grey.shade300
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(options[index].toString()),
              ),
            );
          }),
        ),
        UIHelper.verticalSpace(20.h),
        Text(
          "Your Selection",
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        UIHelper.verticalSpace(12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(selectedList.length, (i) {
            final value = options[selectedList[i]];
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 6.w),
              width: 40.w,
              height: 40.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue),
              ),
              child: Text(value.toString()),
            );
          }),
        ),
        UIHelper.verticalSpace(16.h),
        CustomButton(
          name: "Check Answer",
          onCallBack: () {
            List<int> selected = selectedAnswers[question.id] ?? [];

            print("Question ID: ${question.id}");
            print("Selected Indexes: $selected");
          },
          context: context,
        ),
      ],
    );
  }
}
