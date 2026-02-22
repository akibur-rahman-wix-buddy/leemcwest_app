import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:leemcwest/features/lesson/model/get_lesson_show_model.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class GetLessonShowApi {
  static final GetLessonShowApi _singleton = GetLessonShowApi._internal();
  GetLessonShowApi._internal();
  static GetLessonShowApi get instance => _singleton;

  Future<GetLessonShowResponseModel> getLessonShowApi(
      {required int lessonId}) async {
    try {
      Response response =
          await getHttp(Endpoints.getLessonShow(lessonId: lessonId));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = GetLessonShowResponseModel.fromRawJson(
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
