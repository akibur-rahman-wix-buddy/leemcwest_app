// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:leemcwest/helpers/toast.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class UpdateNotificationRx extends RxResponseInt<Map> {
  final api = UpdateNotificationApi.instance;

  UpdateNotificationRx({
    required super.empty,
    required super.dataFetcher,
  });

  ValueStream<Map> get getFileData => dataFetcher.stream;

  Future<bool> updateNotificationRx({
    Map<String, int?>? notification,
  }) async {
    try {
      Map data = await api.updateNotificationApi(
        notification: notification,
      );

      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      handleErrorWithReturn(error);
      return false;
    }
  }

  @override
  bool handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response?.statusCode == 400) {
        ToastUtil.showShortToast(
          error.response?.data["error"] ?? "Bad Request",
        );
      } else {
        ToastUtil.showShortToast(
          error.response?.data["message"] ?? "Something went wrong",
        );
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}

