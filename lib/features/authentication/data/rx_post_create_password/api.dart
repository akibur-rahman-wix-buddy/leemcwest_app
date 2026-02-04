import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:leemcwest/networks/endpoints.dart';
import 'package:leemcwest/networks/exception_handler/data_source.dart';
import '../../../../../networks/dio/dio.dart';

final class PostResetPasswordApi {
  static final PostResetPasswordApi _singleton =
      PostResetPasswordApi._internal();
  PostResetPasswordApi._internal();
  static PostResetPasswordApi get instance => _singleton;

  Future<Map> postResetPasswordApi({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String token,
  }) async {
    try {
      FormData data = FormData.fromMap({
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "token": token,
      });

      Response response =
          await postHttp(Endpoints.createPassWordEndPoint(), data);

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      rethrow;
    }
  }
}
