// ignore_for_file: unused_import

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:leemcwest/features/authentication/model/otp_verify_model.dart';
import 'package:leemcwest/networks/dio/dio.dart';
import 'package:leemcwest/networks/endpoints.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class VerifyEmailApi {
  static final VerifyEmailApi _singleton = VerifyEmailApi._internal();
  VerifyEmailApi._internal();
  static VerifyEmailApi get instance => _singleton;

  Future<OtpVerifyModel> verifyEmailApi({
    required String email,
     required String otp,
  }) async {
    try {
      Map data = {
        "email": email,
        "otp": otp,
      };

      Response response = await postHttp(Endpoints.verifyEmail(), data);

      if (response.statusCode == 200) {
           final data = OtpVerifyModel.fromJson((response.data));
        ToastUtil.showShortToast("Verify Successful");
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      // throw ErrorHandler.handle(error).failure.responseMessage;
      rethrow;
    }
  }
}




// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:leemcwest/networks/endpoints.dart';
// import 'package:leemcwest/networks/exception_handler/data_source.dart';
// import '../../../../../networks/dio/dio.dart';

// final class VerifyEmailApi {
//   static final VerifyEmailApi _singleton = VerifyEmailApi._internal();
//   VerifyEmailApi._internal();
//   static VerifyEmailApi get instance => _singleton;

//   Future<Map> verifyEmailApi({
//     required String email,
//     required String otp,
//   }) async {
//     try {
//       Map data = {"email": email, "otp": otp};

//       Response response = await postHttp(Endpoints.verifyEmail(), data);

//       if (response.statusCode == 200) {
//         final data = json.decode(json.encode(response.data));
//         return data;
//       } else {
//         throw DataSource.DEFAULT.getFailure();
//       }
//     } catch (error) {
//       // Handle generic errors
//       // throw ErrorHandler.handle(error).failure.responseMessage;
//       rethrow;
//     }
//   }
// }
