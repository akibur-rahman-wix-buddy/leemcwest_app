// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:leemcwest/helpers/toast.dart';
import 'package:leemcwest/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class SignUpRx extends RxResponseInt<Map> {
  final api = SignUpApi.instance;

  SignUpRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> signUpRx({
     required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required int isAgeVerified,
  }) async {
    try {
      Map data = await api.signUpApi(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        isAgeVerified: isAgeVerified,
      );
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      handleErrorWithReturn(error);
      return false;
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response!.statusCode == 400) {
        ToastUtil.showShortToast(error.response!.data["error"]);
      } else {
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}