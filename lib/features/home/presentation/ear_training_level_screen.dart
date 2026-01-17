import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
import 'package:leemcwest/features/home/widget/ear_training_level_widget.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class EarTrainingLevelScreen extends StatefulWidget {
  const EarTrainingLevelScreen({super.key});

  @override
  State<EarTrainingLevelScreen> createState() => _EarTrainingLevelScreenState();
}

class _EarTrainingLevelScreenState extends State<EarTrainingLevelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF9FAFB,
      appBar: const CustomCenterTitleAppbar(
        title: 'Functional ear training',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIHelper.verticalSpace(32.h),
            EarTrainingLevelWidget(
              title: 'Beginner',
              subTitle: 'Short progressions with basic functional movement',
              onTap: () {
                NavigationService.navigateTo(Routes.beginerEarTraining);
              },
              
            ),
            UIHelper.verticalSpace(24.h),
            const EarTrainingLevelWidget(
              title: 'Intermediate',
              subTitle: 'Longer progressions with a mixture of functional movements',
            ),
            UIHelper.verticalSpace(24.h),
            const EarTrainingLevelWidget(
              title: 'Advanced',
              subTitle: 'Complex progressions with advanced functional movement',
            ),
          ],
        ),
      ),
    );
  }
}