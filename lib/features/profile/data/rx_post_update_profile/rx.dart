// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:leemcwest/features/profile/data/rx_post_update_profile/api.dart';
import 'package:leemcwest/helpers/toast.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';

final class  EditProfileRx extends RxResponseInt<Map> {
  final api =  EditProfileApi.instance;

   EditProfileRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool>  editProfileRx({
   String? name,
    String? phone,
    File? avatar,
  }) async {
    try {
      Map data = await api. editProfileApi(
        name: name,
        phone: phone,
        avatar: avatar
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
