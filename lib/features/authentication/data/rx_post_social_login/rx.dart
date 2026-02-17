// ignore_for_file: unrelated_type_equality_checks

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:leemcwest/constants/app_constants.dart';
import 'package:leemcwest/features/authentication/data/rx_post_social_login/api.dart';
import 'package:leemcwest/features/authentication/model/social_login_model.dart';
import 'package:leemcwest/helpers/di.dart';
import 'package:leemcwest/helpers/toast.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/rx_base.dart';

class SocialLoginRX extends RxResponseInt<SocialLoginModel> {
  final api = SocialLoginApi.instance;

  bool success = false;

  SocialLoginRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  String message = "";

  Future<bool> socialLoginFunc({
    required String token,
    required String provider,
  }) async {
    try {
      SocialLoginModel data = await api
          .googleLogin(token: token, provider: provider)
          ;
      log("--------------------token---$token-----------------------------------------------");
      await handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) {
    // ToastUtil.showShortToast("Sign In Success");
    String accesstoken = data.data?.token ?? '';
    log("--------------------------------------token---$accesstoken-------------------------------------------------------------");
    appData.write(kKeyAccessToken, data.data?.token);
   // appData.write(kKeyUserID, data.data?.user?.id);
    appData.write(kKeyIsLoggedIn, true);
    String token = appData.read(kKeyAccessToken);
    DioSingleton.instance.update(token);
    dataFetcher.sink.add(data);
  }

  @override
  handleErrorWithReturn(error) {
    DioException exception = error as DioException;
    if (exception.type == DioExceptionType.connectionError) {
      message = "Check Your Network Connection";
    } else if (exception.response?.statusCode == 403) {
      message = exception.response?.data["message"] ??
          "Email not verified. OTP sent to your email.";
      ToastUtil.showLongToast(message);
      //NavigationService.navigateTo(Routes.signUpScreen);
    } else {
      message = exception.response!.data["message"] ?? "Unknown error occurred";
      ToastUtil.showLongToast(message);
    }

    dataFetcher.sink.addError(error);
    return false;
  }
}
