// // ignore_for_file: unused_import

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:leemcwest/networks/dio/dio.dart';
import 'package:leemcwest/networks/endpoints.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class ForgotPassApi {
  static final ForgotPassApi _singleton = ForgotPassApi._internal();
  ForgotPassApi._internal();
  static ForgotPassApi get instance => _singleton;

  Future<Map> forgotPassApi({
    required String email,
  }) async {
    try {
      Map data = {
        "email": email,
      };

      Response response = await postHttp(Endpoints.forgotPassEndpoint(), data);

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast("Password reset OTP has been sent to your email.");
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