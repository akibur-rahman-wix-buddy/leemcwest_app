import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/assets_helper/app_icons.dart';
import 'package:leemcwest/common_widgets/custom_button.dart';
import 'package:leemcwest/common_widgets/custom_title_appbar.dart';
import 'package:leemcwest/constants/app_constants.dart';
import 'package:leemcwest/features/profile/widget/profile_options_widget.dart';
import 'package:leemcwest/features/profile/widget/rating_app_widget.dart';
import 'package:leemcwest/features/profile/widget/user_profile_info.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/di.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/toast.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';
import 'package:leemcwest/networks/api_acess.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getOwnProfileRxObj.getOwnProfileRx();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      appBar: const CustomTitleAppbar(
        title: 'Profile',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(24.h),
              Container(
                padding: EdgeInsets.symmetric(vertical: 22.h, horizontal: 16.w),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.c113A6A,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upgrade to Premium',
                      style: TextFontStyle.headlineCinzel24w700cFFFFFF.copyWith(
                        fontSize: 18.sp,
                      ),
                    ),
                    UIHelper.verticalSpace(8.h),
                    Text(
                      'Unlock full access to all lessons,\n tools, and creative features',
                      style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                        color: AppColors.cFFFFFF,
                      ),
                    ),
                  ],
                ),
              ),
              UIHelper.verticalSpace(32.h),
              StreamBuilder(
                  stream: getOwnProfileRxObj.dataFetcher,
                  builder: (context, snapshot) {
                    final data = snapshot.data;
                    return UserProfileInfo(
                      url: data?.data?.personalInformation?.avatarUrl ??
                          'https://static.vecteezy.com/system/resources/previews/002/002/257/non_2x/beautiful-woman-avatar-character-icon-free-vector.jpg',
                      name: data?.data?.personalInformation?.name ?? 'N/A',
                      email: data?.data?.personalInformation?.email ?? 'N/A',
                    );
                  }),
              UIHelper.verticalSpace(34.h),
              Text(
                'Application',
                style: TextFontStyle.headlineCinzel18w600c141313,
              ),
              UIHelper.verticalSpace(40.h),
              const ProfileOptionsWidget(
                iconPath: Icons.home,
                text: 'Home',
              ),
              UIHelper.verticalSpace(26.h),
              const ProfileOptionsWidget(
                iconPath: Icons.card_membership,
                text: 'My Membership',
              ),
              UIHelper.verticalSpace(26.h),
              ProfileOptionsWidget(
                iconPath: Icons.work_history,
                text: 'Saved Work',
                onTap: () {
                  NavigationService.navigateTo(Routes.savedWork);
                },
              ),
              UIHelper.verticalSpace(26.h),
              ProfileOptionsWidget(
                iconPath: Icons.notifications,
                text: 'Notifications',
                onTap: () {
                  NavigationService.navigateTo(Routes.pushNotification);
                },
              ),
              UIHelper.verticalSpace(26.h),
              ProfileOptionsWidget(
                iconPath: Icons.people,
                text: 'User Guide',
                onTap: () {
                  NavigationService.navigateTo(Routes.userGuide);
                },
              ),
              UIHelper.verticalSpace(26.h),
              ProfileOptionsWidget(
                iconPath: Icons.book,
                text: 'Glossary',
                onTap: () {
                  NavigationService.navigateTo(Routes.glossary);
                },
              ),
              UIHelper.verticalSpace(26.h),
              ProfileOptionsWidget(
                iconPath: Icons.query_builder,
                text: 'FAQ',
                onTap: () {
                  NavigationService.navigateTo(Routes.faq);
                },
              ),
              UIHelper.verticalSpace(26.h),
              ProfileOptionsWidget(
                iconPath: Icons.account_box_outlined,
                text: 'About FHT',
                onTap: () {
                  NavigationService.navigateTo(Routes.aboutFht);
                },
              ),
              UIHelper.verticalSpace(26.h),
              ProfileOptionsWidget(
                iconPath: Icons.settings,
                text: 'Settings',
                onTap: () {
                  NavigationService.navigateTo(Routes.support);
                },
              ),
              UIHelper.verticalSpace(26.h),
              ProfileOptionsWidget(
                iconPath: Icons.manage_accounts,
                text: 'Manage Account',
                onTap: () {
                  NavigationService.navigateTo(Routes.manageAccount);
                },
              ),
              UIHelper.verticalSpace(26.h),
              ProfileOptionsWidget(
                iconPath: Icons.rate_review,
                text: 'Rate the App',
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16.r)),
                    ),
                    builder: (context) {
                      return RatingAppWidget(
                        onTapSubmit: (rating){},
                        onRatingChanged: (value) {
                          
                        },
                      );
                    },
                  );
                },
              ),
              UIHelper.verticalSpace(26.h),
              const ProfileOptionsWidget(
                iconPath: Icons.share,
                text: 'Share the App',
              ),
              UIHelper.verticalSpace(26.h),
              isLoading
                  ? const Center(
                      child: SpinKitCircle(
                        color: AppColors.primaryColor2,
                      ),
                    )
                  : ProfileOptionsWidget(
                      iconPath: Icons.logout,
                      text: 'Log out',
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        logoutRxObj.logoutRx().then(
                          (value) async {
                            if (value) {
                              ToastUtil.showShortToast("Logout successfully.");
                              await appData.write(kKeyIsLoggedIn, false);
                              await appData.write(kKeyAccessToken, '');
                              setState(() {
                                isLoading = false;
                              });
                              NavigationService.navigateToReplacement(
                                Routes.signIn,
                              );
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              ToastUtil.showShortToast("Failed to logout.");
                            }
                          },
                        );
                      },
                    ),
              UIHelper.verticalSpace(12.h),
            ],
          ),
        ),
      ),
    );
  }
}