// ignore_for_file: unused_import

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:leemcwest/networks/dio/dio.dart';
import 'package:leemcwest/networks/endpoints.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class ResendOtpApi {
  static final ResendOtpApi _singleton = ResendOtpApi._internal();
  ResendOtpApi._internal();
  static ResendOtpApi get instance => _singleton;

  Future<Map> resendOtpApi({
    required String email,
  }) async {
    try {
      Map data = {
        "email": email,
      };

      Response response = await postHttp(Endpoints.resendOtpEndPoint(), data);

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast("A new OTP has been sent to your email.");
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