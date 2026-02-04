// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:leemcwest/features/support/data/rx_post_bug_report/api.dart';
import 'package:leemcwest/helpers/toast.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';

final class PostBugReportRx extends RxResponseInt<Map> {
  final api = PostBugReportApi.instance;

  PostBugReportRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> postBugReportRx({
   required String title,
    String? email,
    required String description,
    File? screenshot,
  }) async {
    try {
      Map data = await api.postBugReportApi(
        title: title,
        email: email,
        description: description,
        screenshot: screenshot
      );
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response!.statusCode == 400) {
        ToastUtil.showShortToast(error.response?.data["error"]);
      } else {
        ToastUtil.showShortToast(error.response?.data["message"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}
