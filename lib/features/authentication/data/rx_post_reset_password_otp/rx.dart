// // // // ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

// // // ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
// // ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
// // ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:leemcwest/constants/app_constants.dart';
import 'package:leemcwest/features/authentication/data/rx_post_reset_password_otp/api.dart';
import 'package:leemcwest/features/authentication/model/otp_pass_model.dart';
import 'package:leemcwest/helpers/di.dart';
import 'package:leemcwest/networks/dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';

final class ResetPassOtpRx extends RxResponseInt<OtpPassModel> {
  final api = ResetPassOtpApi.instance;

  ResetPassOtpRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  /// Returns `true` on success and `false` on error
  Future<bool> resetPassOtpRx({
    required String email,
    required String otp,
  }) async {
    try {
      OtpPassModel data = await api.resetPassOtpApi(
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
  handleSuccessWithReturn(OtpPassModel data) {
    ToastUtil.showShortToast("OTP verified successfully");
    appData.write(kKeyAccessToken, data.data?.token);
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









// import 'dart:developer';
// import 'package:dio/dio.dart';
// import 'package:leemcwest/features/authentication/data/rx_post_reset_password_otp/api.dart';
// import 'package:rxdart/rxdart.dart';
// import '../../../../../helpers/toast.dart';
// import '../../../../../networks/rx_base.dart';

// final class ResetPassOtpRx extends RxResponseInt<Map> {
//   final api = ResetPassOtpApi.instance;

//   ResetPassOtpRx({required super.empty, required super.dataFetcher});

//   ValueStream get getFileData => dataFetcher.stream;

//   /// Returns `true` on success and `false` on error
//   Future<bool> resetPassOtpRx({
//     required String email,
//     required String otp,
//   }) async {
//     try {
//       Map data = await api.resetPassOtpApi(
//         email: email,
//         otp: otp,
//       );
//       handleSuccessWithReturn(data);
//       return true; // Return true on success
//     } catch (error) {
      
//       handleErrorWithReturn(error);
//       return false; // Return false on error
//     }
//   }

  
//   @override
//   handleErrorWithReturn(dynamic error) {
//     if (error is DioException) {
//       if (error.response?.statusCode == 400) {
//         ToastUtil.showShortToast(error.response?.data["message"] ?? "Error");
//       } else {
//         ToastUtil.showShortToast(error.response?.data["message"] ?? "Error");
//       }
//     } else {
//       ToastUtil.showShortToast("An unexpected error occurred.");
//     }
//     log(error.toString());
//     dataFetcher.sink.addError(error);
//   }
// }
