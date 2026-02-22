import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:leemcwest/features/lesson/model/get_lesson_model.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class GetLessonApi {
  static final GetLessonApi _singleton = GetLessonApi._internal();
  GetLessonApi._internal();
  static GetLessonApi get instance => _singleton;

  Future<GetLessonResponseModel> getLessonApi(
    ) async {
    try {
      Response response = await getHttp(Endpoints.getLesson());

      if (response.statusCode == 200 || response.statusCode == 201 ) {
        final data = GetLessonResponseModel.fromRawJson(
          json.encode(response.data),
        );
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
