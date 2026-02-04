import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:leemcwest/helpers/toast.dart';
import 'package:leemcwest/networks/endpoints.dart';
import 'package:leemcwest/networks/exception_handler/data_source.dart';
import '../../../../../networks/dio/dio.dart';

final class PostBugReportApi {
  static final PostBugReportApi _singleton = PostBugReportApi._internal();
  PostBugReportApi._internal();
  static PostBugReportApi get instance => _singleton;

  Future<Map> postBugReportApi({
    required String title,
    String? email,
    required String description,
    File? screenshot,
  }) async {
    try {
      FormData data = FormData.fromMap({
        'title': title,
        'email': email,
        'description': description,
      });
      if (screenshot != null && await screenshot.exists()) {
        data.files.add(
          MapEntry(
            'screenshot',
            await MultipartFile.fromFile(
              screenshot.path,
              filename: screenshot.path.split('/').last,
            ),
          ),
        );
      }

      Response response = await postHttp(Endpoints.bugReport(), data);

      if (response.statusCode == 201) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast(
            "Bug report submitted successfully");
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
