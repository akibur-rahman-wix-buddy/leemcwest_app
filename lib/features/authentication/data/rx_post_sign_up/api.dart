// // ignore_for_file: unused_import
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:leemcwest/networks/dio/dio.dart';
import 'package:leemcwest/networks/endpoints.dart';
import 'package:leemcwest/networks/exception_handler/data_source.dart';

final class SignUpApi {
  static final SignUpApi _singleton = SignUpApi._internal();
  SignUpApi._internal();
  static SignUpApi get instance => _singleton;

  Future<Map> signUpApi({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required int isAgeVerified,
  }) async {
    try {
      FormData data = FormData.fromMap({
         "name": name,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "is_age_verified": isAgeVerified,
      });

      Response response = await postHttp(Endpoints.signUp(), data);

      if (response.statusCode == 201) {
        final data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}