// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:leemcwest/helpers/toast.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class PostFeatureSuggestionRx extends RxResponseInt<Map> {
  final api = PostFeatureSuggestionApi.instance;

  PostFeatureSuggestionRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> postFeatureSuggestionRx({
    required String description,
    String? email,
    required String title,
    required String improvement,
  }) async {
    try {
      Map data = await api.postFeatureSuggestionApi(
        description: description,
        email: email,
        title: title,
        improvement: improvement
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
      if (error.response?.statusCode == 400) {
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
