import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:leemcwest/features/progress/model/get_progress_model.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class GetProgressApi {
  static final GetProgressApi _singleton = GetProgressApi._internal();
  GetProgressApi._internal();
  static GetProgressApi get instance => _singleton;

  Future<GetProgressResponseModel> getProgressApi() async {
    try {
      Response response = await getHttp(Endpoints.getProgress());

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = GetProgressResponseModel.fromRawJson(
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
