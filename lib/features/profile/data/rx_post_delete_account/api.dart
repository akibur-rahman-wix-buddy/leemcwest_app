import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:leemcwest/helpers/toast.dart';
import 'package:leemcwest/networks/exception_handler/data_source.dart';
import '/networks/endpoints.dart';
import '../../../../../../networks/dio/dio.dart';

final class DeleteAccountApi {
  static final DeleteAccountApi _singleton = DeleteAccountApi._internal();
  DeleteAccountApi._internal();
  static DeleteAccountApi get instance => _singleton;

  Future<Map> deleteAccountApi() async {
    
    try {
      FormData data = FormData.fromMap({});

      Response response = await postHttp(Endpoints.deleteAccount(), data);

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
         ToastUtil.showShortToast("Your account has been deleted successfully.");
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
