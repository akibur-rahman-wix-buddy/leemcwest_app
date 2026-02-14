import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:leemcwest/networks/endpoints.dart';
import 'package:leemcwest/networks/exception_handler/data_source.dart';
import '../../../../../networks/dio/dio.dart';

final class PostStoreReviewApi {
  static final PostStoreReviewApi _singleton =
      PostStoreReviewApi._internal();
  PostStoreReviewApi._internal();
  static PostStoreReviewApi get instance => _singleton;

  Future<Map> postStoreReviewApi({
    required int userId,
    required int ratings,
  }) async {
    try {
      FormData data = FormData.fromMap({
        "user_id": userId,
        "ratings": ratings,
      });

      Response response =
          await postHttp(Endpoints.reviewStore(), data);

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
