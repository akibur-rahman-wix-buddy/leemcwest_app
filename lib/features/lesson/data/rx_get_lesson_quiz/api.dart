import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:leemcwest/features/lesson/model/get_lesson_quiz_model.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class GetLessonQuizApi {
  static final GetLessonQuizApi _singleton = GetLessonQuizApi._internal();
  GetLessonQuizApi._internal();
  static GetLessonQuizApi get instance => _singleton;

  Future<GetLessonQuizResponseModel> getLessonQuizApi(
      {required int lessonId}) async {
    try {
      Response response =
          await getHttp(Endpoints.getLessonQuiz(lessonId: lessonId));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = GetLessonQuizResponseModel.fromRawJson(
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
