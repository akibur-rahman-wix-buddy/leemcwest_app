import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';
import 'package:leemcwest/common_widgets/custom_center_title_appbar.dart';
import 'package:leemcwest/constants/app_constants.dart';
import 'package:leemcwest/features/authentication/verification/widget/dialogue_widget.dart';
import 'package:leemcwest/features/profile/widget/account_control_widget.dart';
import 'package:leemcwest/features/profile/widget/information_btn.dart';
import 'package:leemcwest/features/profile/widget/personal_information_widget.dart';
import 'package:leemcwest/features/profile/widget/subscription_status_widget.dart';
import 'package:leemcwest/helpers/all_routes.dart';
import 'package:leemcwest/helpers/di.dart';
import 'package:leemcwest/helpers/navigation_service.dart';
import 'package:leemcwest/helpers/toast.dart';
import 'package:leemcwest/helpers/ui_helpers.dart';
import 'package:leemcwest/networks/api_acess.dart';

class ManageAccountScreen extends StatefulWidget {
  const ManageAccountScreen({super.key});

  @override
  State<ManageAccountScreen> createState() => _ManageAccountScreenState();
}

class _ManageAccountScreenState extends State<ManageAccountScreen> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getOwnProfileRxObj.getOwnProfileRx();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF9FAFB,
      appBar: const CustomCenterTitleAppbar(
        title: 'Manage Account',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(20.h),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Text(
                    'Control your profile, subscription, and privacy settings',
                    style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                      color: AppColors.c4A5565,
                      fontSize: 16.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              UIHelper.verticalSpace(22.h),
              StreamBuilder(
                stream: getOwnProfileRxObj.dataFetcher,
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  appData.write(kKeyName, data?.data?.personalInformation?.name);
                  appData.write(kKeyEmail, data?.data?.personalInformation?.email);
                  appData.write(kKeyPhoneVerifiedAt, data?.data?.personalInformation?.phone);
                  return PersonalInformationWidget(
                    url:
                      data?.data?.personalInformation?.avatarUrl ??  'https://w7.pngwing.com/pngs/129/292/png-transparent-female-avatar-girl-face-woman-user-flat-classy-users-icon.png',
                    name: data?.data?.personalInformation?.name ?? 'N/A',
                    email: data?.data?.personalInformation?.email ?? 'N/A',
                    onTapEdit: () {
                      NavigationService.navigateTo(Routes.editProfile);
                    },
                    onTapChangePassword: () {
                      NavigationService.navigateTo(Routes.changePassword);
                    },
                  );
                }
              ),
              UIHelper.verticalSpace(32.h),
              StreamBuilder(
                stream: getOwnProfileRxObj.dataFetcher,
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  return SubscriptionStatusWidget(
                    plan: data?.data?.subscriptionStatus?.currentPlan ?? 'N/A',
                    billingDate: data?.data?.subscriptionStatus?.nextBillingDate ?? 'N/A',
                    onTapSubscription: () {},
                  );
                }
              ),
              UIHelper.verticalSpace(32.h),
              Text(
                'Data & Privacy',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c101828,
                ),
              ),
              UIHelper.verticalSpace(24.h),
              InformationBtn(
                icon: Icons.download,
                text: 'Download My Data',
                onTap: () {},
              ),
              UIHelper.verticalSpace(13.h),
              InformationBtn(
                icon: Icons.privacy_tip,
                text: 'Privacy Policy',
                onTap: () {
                  NavigationService.navigateTo(Routes.termsUse);
                },
              ),
              UIHelper.verticalSpace(32.h),
              AccountControlWidget(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) =>  DialogueWidget(
                      onTapDelete: () async {
                        setState(() {
                          isLoading = true;
                        });
                        deleteAccountRxObj.deleteAccountRx().then(
                          (value) async {
                            if (value) {
                              ToastUtil.showShortToast("Delete Account successfully.");
                              await appData.write(kKeyIsLoggedIn, false);
                              await appData.write(kKeyAccessToken, '');
                              setState(() {
                                isLoading = false;
                              });

                              NavigationService.navigateToReplacement(
                                  Routes.signUp);
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              ToastUtil.showShortToast("Failed to delete account.");
                            }
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              UIHelper.verticalSpace(32.h),
              Text(
                'You can return to your learning progress at any time by reactivating your account using the same email.',
                style: TextFontStyle.textStyle14w400c6A7282.copyWith(
                  color: AppColors.c4A5565,
                ),
                textAlign: TextAlign.center,
              ),
              UIHelper.verticalSpace(48.h)
            ],
          ),
        ),
      ),
    );
  }
}
