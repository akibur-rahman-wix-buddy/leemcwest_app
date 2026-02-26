// // ignore_for_file: camel_case_types

// import 'dart:convert';
// import 'package:dio/dio.dart';
// import '../../../../../networks/dio/dio.dart';
// import '../../../../../networks/endpoints.dart';
// import '../../../../../networks/exception_handler/data_source.dart';

// final class SubmitAnswerApi {
//   static final SubmitAnswerApi _singleton = SubmitAnswerApi._internal();
//   SubmitAnswerApi._internal();
//   static SubmitAnswerApi get instance => _singleton;

//   Future<Map> submitAnswerApi({
//     required int lessonId,
//   }) async {
//     try {
//       var data = {
//         "lesson_id": lessonId,
//       };

//       Response response = await postHttp(Endpoints.submitAnswer(lessonId: lessonId), data);

//       if (response.statusCode == 200) {
//         final data = json.decode(json.encode(response.data));
//         return data;
//       } else {
//         throw DataSource.DEFAULT.getFailure();
//       }
//     } catch (error) {
//       rethrow;
//     }
//   }
// }

// ignore_for_file: camel_case_types

import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class SubmitAnswerApi {
  static final SubmitAnswerApi _singleton = SubmitAnswerApi._internal();
  SubmitAnswerApi._internal();
  static SubmitAnswerApi get instance => _singleton;

  Future<Map<String, dynamic>> submitAnswerApi({
     required int lessonId,
    required List<Map<String, dynamic>> answers,
  }) async {
    try {
      final body = {
        "answers": answers,
      };

      Response response = await postHttp(
        Endpoints.submitAnswer(lessonId: lessonId), 
        body,
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}