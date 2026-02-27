// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:leemcwest/features/lesson/model/get_lesson_summary.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../../helpers/toast.dart';
import '../../../../../../networks/rx_base.dart';
import 'api.dart';

final class GetLessonSummaryRX extends RxResponseInt<GetLessonSummaryResponseModel> {
  final api = GetLessonSummaryApi.instance;

  GetLessonSummaryRX({required super.empty, required super.dataFetcher});

  ValueStream get articleSteam => dataFetcher.stream;

  Future<void> getLessonSummaryRX({required int lessonId}) async {
    try {
      GetLessonSummaryResponseModel data =
          await api.getLessonSummaryApi(lessonId: lessonId);
      handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response?.statusCode == 422) {
        ToastUtil.showShortToast(error.response!.data["message"]);
      } else {
        // ToastUtil.showShortToast(error.response?.data["message"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    // throw error;
    return false;
  }
}
