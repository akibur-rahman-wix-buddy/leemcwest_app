import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/common_widgets/custom_navigation_appbar.dart';
import 'package:leemcwest/features/lesson/widget/bullet_text_widget.dart';
import 'package:leemcwest/features/lesson/widget/lesson_audio_player.dart';
import 'package:leemcwest/features/lesson/widget/lesson_complete_dialogue.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';
import 'package:leemcwest/networks/api_acess.dart';

class LessonDescriptionScreen extends StatefulWidget {
  final int id;
  const LessonDescriptionScreen({super.key, required this.id});

  @override
  State<LessonDescriptionScreen> createState() =>
      _LessonDescriptionScreenState();
}

class _LessonDescriptionScreenState extends State<LessonDescriptionScreen> {
  @override
  void initState() {
    super.initState();
    getLessonShowRXObj.getLessonShowRX(lessonId: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      appBar: const CustomNavigationAppbar(
        title: 'Lesson',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: StreamBuilder(
                stream: getLessonShowRXObj.dataFetcher,
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
                      Image.asset(
                        AppImages.classicalSheet,
                      ),
                      UIHelper.verticalSpace(8.h),
                      Image.asset(
                        AppImages.classicalSheet,
                      ),
                      UIHelper.verticalSpace(24.h),
                      UIHelper.customDivider(),
                      UIHelper.verticalSpace(32.h),
                      Text(
                        "${data?.lesson?.title}",
                        style:
                            TextFontStyle.headlineCinzel24w500cFFFFFF.copyWith(
                          color: AppColors.c0A0E1A,
                          fontSize: 18.sp,
                        ),
                      ),
                      UIHelper.verticalSpace(16.h),
                       ListView.builder(
                        itemCount: data?.lesson?.contents?.length ?? 0,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final text = data?.lesson?.contents?[index];
                          return BulletTextWidget(
                            text:
                                '${text?.content}',
                          );}),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BulletTextWidget(
                            text:
                                'Notice that the subdominant is the same distance below the tonic as the dominant is above it (a generic fifth).',
                          ),
                          UIHelper.verticalSpace(12.h),
                          const BulletTextWidget(
                            text:
                                'The prefix sub is Latin for “under” or “beneath.”',
                          ),
                          UIHelper.verticalSpace(12.h),
                          const BulletTextWidget(
                            text:
                                'The third note is called the mediant since it is in the middle of the tonic and dominant.',
                          ),
                          UIHelper.verticalSpace(12.h),
                          const BulletTextWidget(
                            text:
                                'Likewise, the sixth note is called the submediant since it is in the middle of the upper tonic and subdominant.',
                          ),
                          UIHelper.verticalSpace(12.h),
                          const BulletTextWidget(
                            text:
                                'The second note is called the supertonic. Super is Latin for “above.”',
                          ),
                        ],
                      ),
                      UIHelper.verticalSpace(32.h),
                      UIHelper.customDivider(),
                      UIHelper.verticalSpace(32.h),
                      CustomButton(
                        name: 'Mark as complete',
                        color: AppColors.c3DC699,
                        borderColor: AppColors.c3DC699,
                        onCallBack: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return const LessonCompleteDialogue();
                            },
                          );
                        },
                        context: context,
                      ),
                      UIHelper.verticalSpace(20.h),
                      GestureDetector(
                        onTap: () {
                          NavigationService.navigateTo(Routes.quiz);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.h, horizontal: 32.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: AppColors.onboardingButtonColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Start Quiz',
                                style: TextFontStyle.headlinePoppins50014
                                    .copyWith(
                                        color: AppColors.cFFFFFF,
                                        fontSize: 16.sp),
                              ),
                              UIHelper.horizontalSpace(10.w),
                              Image.asset(
                                AppImages.quizBook,
                                width: 20.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                      UIHelper.verticalSpace(64.h)
                    ],
                  );
                })),
      ),
      bottomNavigationBar: const LessonAudioPlayer(
        currentTime: "1:25",
        totalTime: "3:15",
      ),
    );
  }
}
