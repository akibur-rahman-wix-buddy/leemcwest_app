import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
import 'package:leemcwest/common_widgets/custom_textfeild.dart';
import 'package:leemcwest/features/profile/widget/faq_tile_widget.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';
import 'package:leemcwest/networks/api_acess.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getFaqRxObj.getFaqRx();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF9FAFB,
      appBar: const CustomCenterTitleAppbar(
        title: 'FAQ',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(22.h),
              CustomTextField(
                controller: searchController,
                hintText: 'Search by song name or key',
                borderRadius: 8.r,
                borderColor: AppColors.cB6BBCF,
              ),
              UIHelper.verticalSpace(32.h),
              Text(
                'Welcome to FHT',
                style: TextFontStyle.headlineCinzel18w600c141313.copyWith(
                  color: AppColors.c1E2939,
                ),
              ),
              UIHelper.verticalSpace(32.h),
              Text(
                'Getting Started',
                style: TextFontStyle.headlineCinzel24w700cFFFFFF.copyWith(
                  fontSize: 18.sp,
                  color: AppColors.c0A1437,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                'Help you out identifying what you need faster.',
                style: TextFontStyle.textStyle12w400c64748B.copyWith(
                  color: AppColors.c0A1437,
                ),
              ),
              UIHelper.verticalSpace(24.h),
              StreamBuilder(
                stream: getFaqRxObj.dataFetcher,
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: SpinKitCircle(color: AppColors.primaryColor2),
                            );
                          }

                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error: ${snapshot.error}"),
                            );
                          }

                          final faq = snapshot.data?.data ?? [];


                          if (faq.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.all(20.h),
                                child: Text(
                                  'No Data',
                                  style: TextFontStyle.headline18w500cFFFFFF
                                      .copyWith(color: AppColors.c000000),
                                ),
                              ),
                            );
                          }
                  return ListView.builder(
                    itemCount: data?.data?.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final list = data?.data?[index];
                      return FaqTileWidget(
                        question: list?.question ?? "N/A",
                        answer:
                            list?.answer ?? "N/A",
                      );
                    },
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
