import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:leemcwest/networks/exception_handler/data_source.dart';
import '/networks/endpoints.dart';
import '../../../../../../networks/dio/dio.dart';

final class LogoutApi {
  static final LogoutApi _singleton = LogoutApi._internal();
  LogoutApi._internal();
  static LogoutApi get instance => _singleton;

  Future<Map> logoutApi() async {
    try {
      FormData data = FormData.fromMap({});

      Response response = await postHttp(Endpoints.logOut(), data);

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        // ToastUtil.showShortToast("Updated Successfully");
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
