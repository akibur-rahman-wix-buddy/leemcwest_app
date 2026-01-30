import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
import 'package:leemcwest/features/lesson/widget/beat_chord_widget.dart';
import 'package:leemcwest/features/lesson/widget/chromatic_answer_widget.dart';
import 'package:leemcwest/features/lesson/widget/chromatic_option_widget.dart';
import 'package:leemcwest/features/lesson/widget/drag_option_container.dart';
import 'package:leemcwest/features/lesson/widget/reset_btn.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class NextLevelQuizScreen extends StatefulWidget {
  const NextLevelQuizScreen({super.key});

  @override
  State<NextLevelQuizScreen> createState() => _NextLevelQuizScreenState();
}

class _NextLevelQuizScreenState extends State<NextLevelQuizScreen> {
  final Map<int, String?> beatValues = {
    1: null,
    2: null,
    3: null,
    4: null,
    5: null,
  };

  final Set<String> usedOptions = {};

  // Add state for chromatic question
  final List<String?> chromaticAnswers = [null, null, null, null, null, null];
  int currentChromaticIndex = 0;

  void handleDrop(int beatNumber, String value) {
    setState(() {
      final currentValue = beatValues[beatNumber];
      if (currentValue != null) {
        usedOptions.remove(currentValue);
      }
      beatValues[beatNumber] = value;
      usedOptions.add(value);
    });
  }

  void removeValue(int beatNumber) {
    setState(() {
      final value = beatValues[beatNumber];
      if (value != null) {
        usedOptions.remove(value);
        beatValues[beatNumber] = null;
      }
    });
  }

  // Add method for chromatic option selection
  void handleChromaticOptionTap(String option) {
    setState(() {
      // Find the next empty slot
      for (int i = 0; i < chromaticAnswers.length; i++) {
        if (chromaticAnswers[i] == null) {
          chromaticAnswers[i] = option;
          break;
        }
      }
    });
  }

  // Add method to remove chromatic answer
  void removeChromaticAnswer(int index) {
    setState(() {
      chromaticAnswers[index] = null;
    });
  }

  // Add reset method for chromatic question
  void resetChromaticAnswers() {
    setState(() {
      for (int i = 0; i < chromaticAnswers.length; i++) {
        chromaticAnswers[i] = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cEEF3ED,
      appBar: const CustomCenterTitleAppbar(
        title: 'QUIZ',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(16.h),
              Container(
                padding: EdgeInsets.all(20.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.sp),
                  color: AppColors.cFFFFFF,
                  border: Border.all(
                    color: AppColors.c134074.withOpacity(0.10),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question 1: Drag the correct functions into each beat to create a balanced phrase in the T–S–D–T flow.',
                      style: TextFontStyle.textStyle16w500c6A7282.copyWith(
                        color: AppColors.c364153,
                      ),
                    ),
                    UIHelper.verticalSpace(16.h),
                    DragOptionContainer(
                      optionText: 'T',
                      isUsed: usedOptions.contains('T'),
                    ),
                    UIHelper.verticalSpace(16.h),
                    DragOptionContainer(
                      optionText: 'S',
                      isUsed: usedOptions.contains('S'),
                    ),
                    UIHelper.verticalSpace(16.h),
                    DragOptionContainer(
                      optionText: 'D',
                      isUsed: usedOptions.contains('D'),
                    ),
                    UIHelper.verticalSpace(16.h),
                    DragOptionContainer(
                      optionText: 'T#',
                      isUsed: usedOptions.contains('T#'),
                    ),
                    UIHelper.verticalSpace(16.h),
                    DragOptionContainer(
                      optionText: 'Db',
                      isUsed: usedOptions.contains('Db'),
                    ),
                    UIHelper.verticalSpace(16.h),
                    BeatChordWidget(
                      chords: 'Beat 1',
                      droppedValue: beatValues[1],
                      onDrop: (value) => handleDrop(1, value),
                      onRemove: () => removeValue(1),
                    ),
                    UIHelper.verticalSpace(16.h),
                    BeatChordWidget(
                      chords: 'Beat 2',
                      droppedValue: beatValues[2],
                      onDrop: (value) => handleDrop(2, value),
                      onRemove: () => removeValue(2),
                    ),
                    UIHelper.verticalSpace(16.h),
                    BeatChordWidget(
                      chords: 'Beat 3',
                      droppedValue: beatValues[3],
                      onDrop: (value) => handleDrop(3, value),
                      onRemove: () => removeValue(3),
                    ),
                    UIHelper.verticalSpace(16.h),
                    BeatChordWidget(
                      chords: 'Beat 4',
                      droppedValue: beatValues[4],
                      onDrop: (value) => handleDrop(4, value),
                      onRemove: () => removeValue(4),
                    ),
                    UIHelper.verticalSpace(16.h),
                    BeatChordWidget(
                      chords: 'Beat 5',
                      droppedValue: beatValues[5],
                      onDrop: (value) => handleDrop(5, value),
                      onRemove: () => removeValue(5),
                    ),
                  ],
                ),
              ),
              UIHelper.verticalSpace(20.h),
              Row(
                children: [
                  Expanded(
                    child: ResetBtn(
                      onTap: () {},
                    ),
                  ),
                  UIHelper.horizontalSpace(12.w),
                  CustomButton(
                    name: 'Check Answer',
                    onCallBack: () {},
                    context: context,
                  ),
                ],
              ),
              UIHelper.verticalSpace(24.h),
              Container(
                padding: EdgeInsets.all(16.sp),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: AppColors.cFFFFFF,
                    border: Border.all(
                      color: AppColors.c134074.withOpacity(0.10.r),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question 2: Tap the Notes in correct chromatic order.',
                      style: TextFontStyle.textStyle16w500c6A7282.copyWith(
                        color: AppColors.c364153,
                      ),
                    ),
                    UIHelper.verticalSpace(16.h),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => handleChromaticOptionTap('4'),
                            child: ChromaticOptionWidget(
                              option: '4',
                            ),
                          ),
                        ),
                        UIHelper.horizontalSpace(8.w),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => handleChromaticOptionTap('8'),
                            child: ChromaticOptionWidget(
                              option: '8',
                            ),
                          ),
                        ),
                        UIHelper.horizontalSpace(8.w),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => handleChromaticOptionTap('7'),
                            child: ChromaticOptionWidget(
                              option: '7',
                            ),
                          ),
                        ),
                        UIHelper.horizontalSpace(8.w),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => handleChromaticOptionTap('9'),
                            child: ChromaticOptionWidget(
                              option: '9',
                            ),
                          ),
                        ),
                        UIHelper.horizontalSpace(8.w),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => handleChromaticOptionTap('6'),
                            child: ChromaticOptionWidget(
                              option: '6',
                            ),
                          ),
                        ),
                        UIHelper.horizontalSpace(8.w),
                        GestureDetector(
                          onTap: () => handleChromaticOptionTap('11'),
                          child: ChromaticOptionWidget(
                            option: '11',
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(16.h),
                    Center(
                      child: Text(
                        'Your Selection',
                        style: TextFontStyle.textStyle16w500c6A7282.copyWith(
                          color: AppColors.c364153,
                        ),
                      ),
                    ),
                    UIHelper.verticalSpace(16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => removeChromaticAnswer(0),
                            child: ChromaticAnswerWidget(
                              answer: chromaticAnswers[0],
                              borderColor: chromaticAnswers[0] != null
                                  ? AppColors.c134074
                                  : AppColors.cF3F4F6,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => removeChromaticAnswer(1),
                            child: ChromaticAnswerWidget(
                              answer: chromaticAnswers[1],
                              borderColor: chromaticAnswers[1] != null
                                  ? AppColors.c134074
                                  : AppColors.cF3F4F6,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => removeChromaticAnswer(2),
                            child: ChromaticAnswerWidget(
                              answer: chromaticAnswers[2],
                              borderColor: chromaticAnswers[2] != null
                                  ? AppColors.c134074
                                  : AppColors.cF3F4F6,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => removeChromaticAnswer(3),
                            child: ChromaticAnswerWidget(
                              answer: chromaticAnswers[3],
                              borderColor: chromaticAnswers[3] != null
                                  ? AppColors.c134074
                                  : AppColors.cF3F4F6,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => removeChromaticAnswer(4),
                          child: ChromaticAnswerWidget(
                            answer: chromaticAnswers[4],
                            borderColor: chromaticAnswers[4] != null
                                ? AppColors.c134074
                                : AppColors.cF3F4F6,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => removeChromaticAnswer(5),
                          child: ChromaticAnswerWidget(
                            answer: chromaticAnswers[5],
                            borderColor: chromaticAnswers[5] != null
                                ? AppColors.c134074
                                : AppColors.cF3F4F6,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              UIHelper.verticalSpace(20.h),
              Row(
                children: [
                  Expanded(
                    child: ResetBtn(
                      onTap: resetChromaticAnswers,
                    ),
                  ),
                  UIHelper.horizontalSpace(12.w),
                  CustomButton(
                    name: 'Check Answer',
                    onCallBack: () {},
                    context: context,
                  ),
                ],
              ),
              UIHelper.verticalSpace(53.h),
            ],
          ),
        ),
      ),
    );
  }
}