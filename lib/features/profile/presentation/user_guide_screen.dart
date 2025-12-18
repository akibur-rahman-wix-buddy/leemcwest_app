import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
import 'package:leemcwest/features/profile/widget/welcome_fht_widget.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';

class UserGuideScreen extends StatefulWidget {
  const UserGuideScreen({super.key});

  @override
  State<UserGuideScreen> createState() => _UserGuideScreenState();
}

class _UserGuideScreenState extends State<UserGuideScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF9FAFB,
      appBar: const CustomCenterTitleAppbar(
        title: 'User Guide',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIHelper.verticalSpace(30.h),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TabBar(
                        indicator: BoxDecoration(
                          color: AppColors.c134074,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: Colors.white,
                        unselectedLabelColor: AppColors.c134074,
                        dividerColor: Colors.transparent,
                        tabs: const [
                          Tab(
                            text: "Welcome to FHT",
                          ),
                          Tab(
                            text: "Tier 2 Composition",
                          ),
                        ],
                      ),
                    ),

                    UIHelper.verticalSpace(20.h),

                    /// Your Contents
                    Expanded(
                      child: TabBarView(
                        children: [
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: WelcomeFhtWidget(),
                          ),
                          Center(child: Text("Tier 2 Composition Content")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}