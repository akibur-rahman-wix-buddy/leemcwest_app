// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, body_might_complete_normally_nullable

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:leemcwest/features/profile/data/rx_get_profile_data/api.dart';
import 'package:leemcwest/features/profile/model/profile_data_model.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';

final class GetOwnProfileRx extends RxResponseInt<ProfileDataModel> {
  final api = GetOwnProfileApi.instance;

  GetOwnProfileRx({required super.empty, required super.dataFetcher});

  ValueStream get commentSteam => dataFetcher.stream;

  Future<ProfileDataModel?> getOwnProfileRx() async {
    try {
      final ProfileDataModel data = await api.getOwnProfileApi();
      handleSuccessWithReturn(data);
      return data;
    } catch (error) {
      // Handle the error locally and return a fallback response
      if (error is DioException) {
        ToastUtil.showShortToast(
            error.response?.data["message"] ?? "Unknown error");
      }
      log(error.toString());
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response!.statusCode == 422) {
        ToastUtil.showShortToast(error.response?.data["message"]);
      } else {
        ToastUtil.showShortToast(error.response?.data["message"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    // throw error;
    return false;
  }
}
