import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:leemcwest/networks/endpoints.dart';
import 'package:leemcwest/networks/exception_handler/data_source.dart';
import '../../../../../networks/dio/dio.dart';

final class PostChangePasswordApi {
  static final PostChangePasswordApi _singleton =
      PostChangePasswordApi._internal();
  PostChangePasswordApi._internal();
  static PostChangePasswordApi get instance => _singleton;

  Future<Map> postChangePasswordApi({
    required String currentPassword,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      FormData data = FormData.fromMap({
        "current_password": currentPassword,
        "password": password,
        "password_confirmation": passwordConfirmation,
      });

      Response response =
          await postHttp(Endpoints.changePassWordEndPoint(), data);

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
