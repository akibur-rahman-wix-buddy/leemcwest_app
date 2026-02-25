// ignore_for_file: camel_case_types

import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class LessonCompletedApi {
  static final LessonCompletedApi _singleton = LessonCompletedApi._internal();
  LessonCompletedApi._internal();
  static LessonCompletedApi get instance => _singleton;

  Future<Map> lessonCompletedApi({
    required String lessonId,
   
  }) async {
    try {
      var data = {
        "lesson_id": lessonId,
        
      };

      Response response = await postHttp(Endpoints.lessonCompleted(), data);

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
