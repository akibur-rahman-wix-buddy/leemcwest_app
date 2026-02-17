import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:leemcwest/helpers/toast.dart';
import 'package:leemcwest/networks/endpoints.dart';
import 'package:leemcwest/networks/exception_handler/data_source.dart';
import '../../../../../networks/dio/dio.dart';

final class UpdateNotificationApi {
  static final UpdateNotificationApi _singleton = UpdateNotificationApi._internal();
  UpdateNotificationApi._internal();
  static UpdateNotificationApi get instance => _singleton;
Future<Map> updateNotificationApi({
  Map<String, int?>? notification,
}) async {
  try {
    final Map<String, dynamic> formMap = {};

    notification?.forEach((key, value) {
      if (value != null) {
        formMap[key] = value; 
      }
    });

    FormData data = FormData.fromMap(formMap);

    Response response = await putHttp(
      Endpoints.notificationSettingsUpdate(), 
      data,
    );

    if (response.statusCode == 200) {
      final resData = json.decode(json.encode(response.data));
      ToastUtil.showShortToast(
        "Notification settings updated successfully.",
      );
      return resData;
    } else {
      throw DataSource.DEFAULT.getFailure();
    }
  } catch (error) {
    rethrow;
  }
}

}
