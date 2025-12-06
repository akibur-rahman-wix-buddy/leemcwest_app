import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
import 'package:leemcwest/common_widgets/custom_textfeild.dart';
import 'package:leemcwest/features/profile/widget/music_name_container.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class SavedWorkScreen extends StatefulWidget {
  const SavedWorkScreen({super.key});

  @override
  State<SavedWorkScreen> createState() => _SavedWorkScreenState();
}

class _SavedWorkScreenState extends State<SavedWorkScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF9FAFB,
      appBar: const CustomCenterTitleAppbar(
        title: 'Saved Work',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(60.h),
              CustomTextField(
                controller: searchController,
                hintText: 'Search by song name or key',
                borderRadius: 8.r,
                borderColor: AppColors.cB6BBCF,
              ),
              UIHelper.verticalSpace(24.h),
              ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: const MusicNameContainer(
                      name: 'Harmonic Resonance',
                      duration: 2,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
