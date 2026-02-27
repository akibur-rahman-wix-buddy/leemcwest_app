import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:leemcwest/features/lesson/model/get_lesson_summary.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class GetLessonSummaryApi {
  static final GetLessonSummaryApi _singleton = GetLessonSummaryApi._internal();
  GetLessonSummaryApi._internal();
  static GetLessonSummaryApi get instance => _singleton;

  Future<GetLessonSummaryResponseModel> getLessonSummaryApi(
      {required int lessonId}) async {
    try {
      Response response =
          await getHttp(Endpoints.getLessonSummary(lessonId: lessonId));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = GetLessonSummaryResponseModel.fromRawJson(
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
