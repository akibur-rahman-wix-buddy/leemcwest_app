import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
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
              const Row(
                children: [
                  Expanded(
                    child:  QuizContainer(),
                  ),
                ],
              ),
              UIHelper.verticalSpace(16.h),
              const Row(
                children: [
                  Expanded(
                    child:  QuizContainer(),
                  ),
                ],
              ),
              UIHelper.verticalSpace(24.h),
              CustomButton(
                name: 'Submit Answer',
                onCallBack: (){
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