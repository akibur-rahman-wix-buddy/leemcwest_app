// // // ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

// // ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:leemcwest/features/authentication/data/rx_post_forget_password/api.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';

final class ForgotPassRx extends RxResponseInt<Map> {
  final api = ForgotPassApi.instance;

  ForgotPassRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> forgotPassRx({
    required String email,
  }) async {
    try {
      Map data = await api.forgotPassApi(
        email: email,
      );
      handleSuccessWithReturn(data);
      return true; // Return true on success
    } catch (error) {
      
      handleErrorWithReturn(error);
      return false; // Return false on error
    }
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
