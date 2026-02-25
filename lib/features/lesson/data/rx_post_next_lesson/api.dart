// ignore_for_file: camel_case_types

import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class NextLessonApi {
  static final NextLessonApi _singleton = NextLessonApi._internal();
  NextLessonApi._internal();
  static NextLessonApi get instance => _singleton;

  Future<Map> nextLessonApi({
    required String lessonId,
  }) async {
    try {
      var data = {
        "lesson_id": lessonId,
      };

      Response response = await postHttp(Endpoints.nextLesson(), data);

      if (response.statusCode == 200) {
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
