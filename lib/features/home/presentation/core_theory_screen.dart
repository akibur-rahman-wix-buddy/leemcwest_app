import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
import 'package:leemcwest/features/home/widget/advanced_insight_widget.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class CoreTheoryScreen extends StatefulWidget {
  const CoreTheoryScreen({super.key});

  @override
  State<CoreTheoryScreen> createState() => _CoreTheoryScreenState();
}

class _CoreTheoryScreenState extends State<CoreTheoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF9FAFB,
      appBar: const CustomCenterTitleAppbar(
        title: 'Core Theory',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(32.h),
              const AdvancedInsightWidget(
                title: 'Case Study',
                subTitle: 'Decoding the decline of Schenkerian analysis',
                backgroundImage: AppImages.insightBackOne,
              ),
              UIHelper.verticalSpace(24.h),
              const AdvancedInsightWidget(
                title: 'Songwriting Lab',
                subTitle: 'Rethink the traditional view of functional cycles',
                backgroundImage: AppImages.insightBackTwo,
              ),
              UIHelper.verticalSpace(24.h),
              const AdvancedInsightWidget(
                title: 'Sonata Form in Motion',
                subTitle: 'Functional paths through the sonata structure',
                backgroundImage: AppImages.insightBackThree,
              ),
              UIHelper.verticalSpace(24.h),
              const AdvancedInsightWidget(
                title: 'Advanced Insights',
                subTitle: 'Exploring the core of musical tension',
                backgroundImage: AppImages.insightBackFour,
              ),
              UIHelper.verticalSpace(24.h),
              const AdvancedInsightWidget(
                title: 'Brahms & the ♭VI Chord',
                subTitle: 'How Brahms rewired tension and release',
                backgroundImage: AppImages.insightBackFive,
              ),
            ],
          ),
        ),
      ),
    );
  }
}