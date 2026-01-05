import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
import 'package:leemcwest/features/profile/widget/bullet_text.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';
class LessonSummaryScreen extends StatefulWidget {
  const LessonSummaryScreen({super.key});

  @override
  State<LessonSummaryScreen> createState() => _LessonSummaryScreenState();
}

class _LessonSummaryScreenState extends State<LessonSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF9FAFB,
      appBar: const CustomCenterTitleAppbar(
        title: 'Lesson Summary',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            UIHelper.verticalSpace(32.h),
            const BulletText(text: 'The tonic (T) chord is the home where musical flow both begins and ends.'),
            UIHelper.verticalSpace(20.h),
            const BulletText(text: 'It is relaxed and doesn\'t pull to other chords, forming the foundation of tonality.'),
            UIHelper.verticalSpace(20.h),
            const BulletText(text: 'Tonic is a state of pure consonance, giving a sense of balance and rest.'),
            UIHelper.verticalSpace(20.h),
            const BulletText(text: 'Melodic movement often expands or contracts around the tonic area.'),
            UIHelper.verticalSpace(52.h),
            CustomButton(
              name: 'Continue',
              onCallBack: (){},
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}