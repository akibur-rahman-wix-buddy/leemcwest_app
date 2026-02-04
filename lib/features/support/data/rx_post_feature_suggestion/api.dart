import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:leemcwest/helpers/toast.dart';
import 'package:leemcwest/networks/endpoints.dart';
import 'package:leemcwest/networks/exception_handler/data_source.dart';
import '../../../../../networks/dio/dio.dart';

final class PostFeatureSuggestionApi {
  static final PostFeatureSuggestionApi _singleton =
      PostFeatureSuggestionApi._internal();
  PostFeatureSuggestionApi._internal();
  static PostFeatureSuggestionApi get instance => _singleton;

  Future<Map> postFeatureSuggestionApi({
    required String description,
    String? email,
    required String title,
    required String improvement,
  }) async {
    try {
      FormData data = FormData.fromMap({
        "description": description,
        "email": email,
        "title": title,
        "improvement": improvement,
      });

      Response response =
          await postHttp(Endpoints.featureSuggestion(), data);

      if (response.statusCode == 201) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast("Feature suggestion submitted successfully");
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
