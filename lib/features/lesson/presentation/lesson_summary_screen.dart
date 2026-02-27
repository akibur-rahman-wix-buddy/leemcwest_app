import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/toast.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';
import 'package:leemcwest/networks/api_acess.dart';

class LessonSummaryScreen extends StatefulWidget {
  final int id;
  const LessonSummaryScreen({super.key, required this.id});

  @override
  State<LessonSummaryScreen> createState() => _LessonSummaryScreenState();
}

class _LessonSummaryScreenState extends State<LessonSummaryScreen> {
  bool isNext = false;
  @override
  void initState() {
    super.initState();
    getLessonSummaryRXObj.getLessonSummaryRX(lessonId: widget.id);
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
              ToastUtil.showShortToast(" Congratulations Your Course is completed");

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
      backgroundColor: AppColors.cF9FAFB,
      appBar: const CustomCenterTitleAppbar(
        title: 'Lesson Summary',
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: StreamBuilder(
              stream: getLessonSummaryRXObj.dataFetcher,
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
                  children: [
                    UIHelper.verticalSpace(32.h),
                    Text(
                      data?.summary ?? "",
                      style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                        color: AppColors.c4A5565,
                        fontSize: 16.sp,
                      ),
                    ),
                    // const BulletText(
                    //     text:
                    //         'The tonic (T) chord is the home where musical flow both begins and ends.'),
                    // UIHelper.verticalSpace(20.h),
                    // const BulletText(
                    //     text:
                    //         'It is relaxed and doesn\'t pull to other chords, forming the foundation of tonality.'),
                    // UIHelper.verticalSpace(20.h),
                    // const BulletText(
                    //     text:
                    //         'Tonic is a state of pure consonance, giving a sense of balance and rest.'),
                    // UIHelper.verticalSpace(20.h),
                    // const BulletText(
                    //     text:
                    //         'Melodic movement often expands or contracts around the tonic area.'),
                    UIHelper.verticalSpace(52.h),
                    CustomButton(
                      name: 'Continue',
                      onCallBack: () {
                        nextLessonMethod();
                      },
                      context: context,
                    ),
                  ],
                );
              })),
    );
  }
}
