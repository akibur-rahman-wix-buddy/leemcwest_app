// ignore_for_file: unused_import

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:leemcwest/features/authentication/model/login_model.dart';
import 'package:leemcwest/networks/dio/dio.dart';
import 'package:leemcwest/networks/endpoints.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class LoginApi {
  static final LoginApi _singleton = LoginApi._internal();
  LoginApi._internal();
  static LoginApi get instance => _singleton;

  Future<LoginModel> loginApi({
    required String email,
    required String password,
  }) async {
    try {
      Map data = {
        "email": email,
        "password": password,
      };

      Response response = await postHttp(Endpoints.login(), data);

      if (response.statusCode == 200) {
        final data = LoginModel.fromJson((response.data));
        ToastUtil.showShortToast("Sign In Successful");
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      // throw ErrorHandler.handle(error).failure.responseMessage;
      rethrow;
    }
  }
}