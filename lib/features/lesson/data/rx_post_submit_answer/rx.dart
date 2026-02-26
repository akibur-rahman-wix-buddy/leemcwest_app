

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class SubmitAnswerRx extends RxResponseInt<Map<String, dynamic>> {
  final api = SubmitAnswerApi.instance;

  SubmitAnswerRx({
    required super.empty,
    required super.dataFetcher,
  });

  ValueStream<Map<String, dynamic>> get getFileData =>
      dataFetcher.stream;

  Future<bool> submitAnswerRx({
    required int lessonId, // keep if your endpoint needs it
    required List<Map<String, dynamic>> answers,
  }) async {
    try {
      final data = await api.submitAnswerApi(
        lessonId: lessonId,
        answers: answers,
      );

      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      handleErrorWithReturn(error);
      return false;
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        final statusCode = error.response!.statusCode;
        final responseData = error.response!.data;

        if (statusCode == 422) {
          String message = "Validation error";

          if (responseData is Map) {
            if (responseData["error"] is Map) {
              final errorMap = responseData["error"] as Map;

              if (errorMap.isNotEmpty) {
                final firstKey = errorMap.keys.first;
                final firstError = errorMap[firstKey];

                if (firstError is List && firstError.isNotEmpty) {
                  message = firstError.first.toString();
                }
              }
            } else if (responseData["message"] != null) {
              message = responseData["message"].toString();
            }
          }

          ToastUtil.showShortToast(message);
        } else {
          ToastUtil.showShortToast(
            responseData is Map
                ? responseData["message"]?.toString() ??
                    "Something went wrong"
                : "Something went wrong",
          );
        }
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}