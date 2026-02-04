import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:leemcwest/helpers/toast.dart';
import 'package:leemcwest/networks/endpoints.dart';
import 'package:leemcwest/networks/exception_handler/data_source.dart';
import '../../../../../networks/dio/dio.dart';

final class EditProfileApi {
  static final EditProfileApi _singleton = EditProfileApi._internal();
  EditProfileApi._internal();
  static EditProfileApi get instance => _singleton;

  Future<Map> editProfileApi({
    String? name,
    String? phone,
    File? avatar,
  }) async {
    try {
      FormData data = FormData.fromMap({
        'name': name,
        'phone': phone,
      });
      if (avatar != null && await avatar.exists()) {
        data.files.add(
          MapEntry(
            'avatar',
            await MultipartFile.fromFile(
              avatar.path,
              filename: avatar.path.split('/').last,
            ),
          ),
        );
      }

      Response response = await postHttp(Endpoints.editProfile(), data);

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast(
            "Profile updated successfully");
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      rethrow;
    }
  }
}
