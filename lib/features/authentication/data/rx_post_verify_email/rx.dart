// // ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
// // ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:leemcwest/constants/app_constants.dart';
import 'package:leemcwest/features/authentication/data/rx_post_verify_email/api.dart';
import 'package:leemcwest/features/authentication/model/otp_verify_model.dart';
import 'package:leemcwest/helpers/di.dart';
import 'package:leemcwest/networks/dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';

final class VerifyEmailRX extends RxResponseInt<OtpVerifyModel> {
  final api = VerifyEmailApi.instance;

  VerifyEmailRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  /// Returns `true` on success and `false` on error
  Future<bool> verifyEmailRX({
    required String email,
    required String otp,
  }) async {
    try {
      OtpVerifyModel data = await api.verifyEmailApi(
        email: email,
        otp: otp,
      );
      handleSuccessWithReturn(data);
      return true; // Return true on success
    } catch (error) {
      handleErrorWithReturn(error);
      return false; // Return false on error
    }
  }
  
  @override
  handleSuccessWithReturn(OtpVerifyModel data) {
    ToastUtil.showShortToast("Account Successfully Created.");
    appData.write(kKeyAccessToken, data.token);
        String token = appData.read(kKeyAccessToken);
    DioSingleton.instance.update(token);
     dataFetcher.sink.add(data);
  }
  
  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response?.statusCode == 400) {
        ToastUtil.showShortToast(error.response?.data["message"] ?? "Error");
      } else {
        ToastUtil.showShortToast(error.response?.data["message"] ?? "Error");
      }
    } else {
      ToastUtil.showShortToast("An unexpected error occurred.");
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
  }
}