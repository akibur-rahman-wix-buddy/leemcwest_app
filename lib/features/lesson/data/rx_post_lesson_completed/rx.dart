import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class LessonCompletedRx extends RxResponseInt<Map> {
  final api = LessonCompletedApi.instance;

  LessonCompletedRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> lessonCompletedRx({
    required String lessonId,
    
  }) async {
    try {
      Map data = await api.lessonCompletedApi(
        lessonId: lessonId,
    
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
        final data = error.response!.data;

        if (statusCode == 422) {
          String message = "Validation error";

          if (data["error"] != null && data["error"] is Map) {
            final errorMap = data["error"] as Map;

            if (errorMap.isNotEmpty) {
              final firstKey = errorMap.keys.first;
              final firstError = errorMap[firstKey];

              if (firstError is List && firstError.isNotEmpty) {
                message = firstError.first.toString();
              }
            }
          } else if (data["message"] != null) {
            message = data["message"].toString();
          }

          ToastUtil.showShortToast(message);
        } else {
          ToastUtil.showShortToast(
            data["message"]?.toString() ?? "Something went wrong",
          );
        }
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}
