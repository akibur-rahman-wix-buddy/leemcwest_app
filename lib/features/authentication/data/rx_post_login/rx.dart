// // ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:leemcwest/constants/app_constants.dart';
import 'package:leemcwest/features/authentication/data/rx_post_login/api.dart';
import 'package:leemcwest/features/authentication/model/login_model.dart';
import 'package:leemcwest/networks/dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../helpers/di.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';

final class LoginRx extends RxResponseInt<LoginModel> {
  final api = LoginApi.instance;

  LoginRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  /// Returns `true` on success and `false` on error
  Future<bool> loginRX({
    required String email,
    required String password,
  }) async {
    try {
      LoginModel data = await api.loginApi(
        email: email,
        password: password,
      );
      handleSuccessWithReturn(data);
      return true; // Return true on success
    } catch (error) {
      handleErrorWithReturn(error);
      return false; // Return false on error
    }
  }

  @override
  handleSuccessWithReturn(LoginModel data) {
    ToastUtil.showShortToast("Sign In Success");
    appData.write(kKeyAccessToken, data.token);
    appData.write(kKeyUserID, data.data?.id);
    appData.write(kKeyIsLoggedIn, true);
    String token = appData.read(kKeyAccessToken);
    DioSingleton.instance.update(token);
    dataFetcher.sink.add(data);
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response?.statusCode == 422) {
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
