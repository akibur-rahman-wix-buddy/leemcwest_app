import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_icons.dart';
import 'package:leemcwest/assets_helper/app_image.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/common_widgets/custom_navigation_appbar.dart';
import 'package:leemcwest/features/lesson/widget/audio_player_widget.dart';
import 'package:leemcwest/features/lesson/widget/bullet_text_widget.dart';
import 'package:leemcwest/features/lesson/widget/lesson_complete_dialogue.dart';
import 'package:leemcwest/features/lesson/widget/network_image_widget.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/toast.dart';
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
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    getLessonShowRXObj.getLessonShowRX(lessonId: widget.id);
  }

  bool isLoading = false;
  bool isNext = false;

  Future<void> lessonCompletedMethod() async {
    try {
      setState(() {
        isLoading = true;
      });
      await lessonCompletedRxObj
          .lessonCompletedRx(lessonId: widget.id.toString())
          .then((value) async {
        if (value) {
          setState(() {
            isLoading = false;
          });
          ToastUtil.showShortToast('Mark as complete Lesson ${widget.id}');

          // patientProfileShortInfoRXOObj.patientProfileShortInfoRX();
        } else {
          setState(() {
            isLoading = false;
          });
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ToastUtil.showShortToast(e.toString());
    }
  }

  Future<void> nextLessonMethod() async {
    try {
      setState(() {
        isNext = true;
      });
      await nextLessonRxObj
          .nextLessonRx(lessonId: widget.id.toString())
          .then((value) async {
        if (value) {
          setState(() {
            isNext = false;
          });

          if (value) {
            final nextLesson =
                nextLessonRxObj.getFileData.value?['data']?['next_lesson'];

            // ✅ Check if next lesson is null
            if (nextLesson == null) {
              ToastUtil.showShortToast(
                  "Congratulations Your Course is completed");

              // ✅ Go back
              NavigationService.goBack;

              return;
            }

            // ✅ If exists, navigate
            final nextLessonId = nextLesson['id'];

            ToastUtil.showShortToast("Next Lesson Start");

            NavigationService.navigateToWithArgs(
              Routes.lessonDescription,
              {'id': nextLessonId},
            );
          }
          // final nextLessonId =
          //     nextLessonRxObj.getFileData.value['data']['next_lesson']['id'];

          // print("Next Lesson ID: $nextLessonId");

          // NavigationService.navigateToWithArgs(
          //     Routes.lessonDescription, {'id': nextLessonId});
        } else {
          setState(() {
            isNext = false;
          });
        }
      });
    } catch (e) {
      setState(() {
        isNext = false;
      });
      ToastUtil.showShortToast(e.toString());
    }
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
                    // UIHelper.verticalSpace(22.h),
                    // Image.asset(
                    //   AppImages.classicalSheet,
                    // ),
                    UIHelper.verticalSpace(8.h),
                    Center(
                        child: NetworkImageWidget(
                      imageUrl:
                          data?.lesson?.contents?[selectedIndex].imageUrl ?? '',
                    )),
                    UIHelper.verticalSpace(24.h),
                    UIHelper.customDivider(),
                    UIHelper.verticalSpace(32.h),
                    Text(
                      "${data?.lesson?.title}",
                      style: TextFontStyle.headlineCinzel24w500cFFFFFF.copyWith(
                        color: AppColors.c0A0E1A,
                        fontSize: 18.sp,
                      ),
                    ),
                    UIHelper.verticalSpace(16.h),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.47,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: data?.lesson?.contents?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final text = data?.lesson?.contents?[index];
                                  return BulletTextWidget(
                                    svg: selectedIndex == index
                                        ? SvgPicture.asset(AppIcons.audio)
                                        : Padding(
                                            padding: EdgeInsets.only(top: 8.h),
                                            child:
                                                SvgPicture.asset(AppIcons.dot),
                                          ),
                                    text: '${text?.content}',
                                    ontap: () {
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                    },
                                    textColor: selectedIndex == index
                                        ? AppColors.primaryColor2
                                        : Colors.black,
                                    textBackgroundColor: selectedIndex == index
                                        ? Colors.yellow.withAlpha(40)
                                        : Colors.transparent,
                                  );
                                }),
                            UIHelper.verticalSpace(32.h),
                            UIHelper.customDivider(),
                            UIHelper.verticalSpace(32.h),
                            isLoading
                                ? Center(
                                    child: SizedBox(
                                      height: 80.h,
                                      width: 60.w,
                                      child: SpinKitCircle(
                                        color: AppColors.primaryColor,
                                        size: 60.h,
                                      ),
                                    ),
                                  )
                                : customButton(
                                    name: 'Mark as complete',
                                    color: AppColors.c3DC699,
                                    borderColor: AppColors.c3DC699,
                                    onCallBack: () {
                                      lessonCompletedMethod();
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return LessonCompleteDialogue(
                                            text:
                                                "You've Completed Lesson ${widget.id} !",
                                            nextlesson: () {
                                              nextLessonMethod();
                                            },
                                            startQuiz: () {
                                              NavigationService
                                                  .navigateToWithArgs(
                                                Routes.quiz,
                                                {'id': widget.id},
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                    context: context,
                                  ),
                            UIHelper.verticalSpace(20.h),
                            isLoading
                                ? Center(
                                    child: SizedBox(
                                      height: 80.h,
                                      width: 60.w,
                                      child: SpinKitCircle(
                                        color: AppColors.primaryColor,
                                        size: 60.h,
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      NavigationService.navigateToWithArgs(
                                        Routes.quiz,
                                        {'id': widget.id},
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15.h, horizontal: 32.w),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        color: AppColors.onboardingButtonColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Start Quiz',
                                            style: TextFontStyle
                                                .headlinePoppins50014
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
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
        bottomNavigationBar: StreamBuilder(
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

              return NetworkAudioPlayerWidget(
                key: ValueKey(selectedIndex),
                audioUrl: data?.lesson?.contents?[selectedIndex].audioUrl ?? '',
                farwordOntap: () {
                  nextLessonMethod();
                },
                backOntap: () {},
              );
            }));
  }
}
