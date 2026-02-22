import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/common_widgets/custom_title_appbar.dart';
import 'package:leemcwest/features/lesson/widget/network_image_widget.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';
import 'package:leemcwest/networks/api_acess.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({super.key});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  @override
  void initState() {
    super.initState();
    getLessonRXObj.getLessonRX();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF9FAFB,
      appBar: const CustomTitleAppbar(
        title: 'Lesson',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: StreamBuilder(
                stream: getLessonRXObj.dataFetcher,
                builder: (context, snapshot) {
                  final data = snapshot.data?.data;
                  // appData.write(kKeyScheduleId, data?.id.toString());

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
                      Text(
                        'All Lessons',
                        style:
                            TextFontStyle.headlineCinzel24w700cFFFFFF.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.c0F1835,
                        ),
                      ),
                      UIHelper.verticalSpace(16.h),
                      ListView.builder(
                        itemCount: data?.lessons?.length ?? 0,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final lesson = data!.lessons![index];
                          return Container(
                            padding: EdgeInsets.all(16.sp),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: AppColors.cFFFFFF,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 6.h),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.r),
                                              color: AppColors.c0F1835
                                                  .withOpacity(0.08),
                                            ),
                                            child: Text(
                                              'Lesson ${lesson.id} ',
                                              style: TextFontStyle
                                                  .textStyle14w400c6A7282
                                                  .copyWith(
                                                color: AppColors.c0F1835,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ),
                                          UIHelper.horizontalSpace(8.w),
                                          Expanded(
                                            child: Text(
                                              "${lesson.title}",
                                              softWrap: true,
                                              maxLines: 2,
                                              style: TextFontStyle
                                                  .headlineCinzel24w500cFFFFFF
                                                  .copyWith(
                                                color: AppColors.c0A0E1A,
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8.sp),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(40.r),
                                        color:
                                            AppColors.c20B80C.withOpacity(0.08),
                                      ),
                                      child: Text(
                                        'Free',
                                        style: TextFontStyle
                                            .textStyle14w400c6A7282
                                            .copyWith(
                                          fontSize: 12.sp,
                                          color: AppColors.c20B80C,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                UIHelper.verticalSpace(18.h),
                                Center(
                                    child: NetworkImageWidget(
                                        imageUrl:
                                            "${lesson.thumnailImageUrl}")),
                                UIHelper.verticalSpace(15.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        NavigationService.navigateToWithArgs(
                                            Routes.lessonDescription,
                                            {'id': lesson.id});
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w, vertical: 10.h),
                                        decoration: BoxDecoration(
                                          color:
                                              AppColors.onboardingButtonColor,
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              AppImages.soundOff,
                                              width: 20.w,
                                            ),
                                            UIHelper.horizontalSpace(4.w),
                                            Text(
                                              'Start Lesson',
                                              style: TextFontStyle
                                                  .headlinePoppins40014
                                                  .copyWith(
                                                color: AppColors.cFFFFFF,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  );
                })),
      ),
    );
  }
}
