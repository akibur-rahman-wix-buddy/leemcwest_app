import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:leemcwest/helpers/toast.dart';
import 'package:leemcwest/networks/endpoints.dart';
import 'package:leemcwest/networks/exception_handler/data_source.dart';
import '../../../../../networks/dio/dio.dart';

final class PostContactSupportApi {
  static final PostContactSupportApi _singleton =
      PostContactSupportApi._internal();
  PostContactSupportApi._internal();
  static PostContactSupportApi get instance => _singleton;

  Future<Map> postContactSupportApi({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      FormData data = FormData.fromMap({
        "name": name,
        "email": email,
        "message": message,
      });

      Response response =
          await postHttp(Endpoints.contactSupport(), data);

      if (response.statusCode == 201) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast("Support request submitted successfully");
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
