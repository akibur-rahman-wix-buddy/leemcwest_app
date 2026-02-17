import 'package:dio/dio.dart';
import 'package:leemcwest/features/authentication/model/social_login_model.dart';
import '/networks/endpoints.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/exception_handler/data_source.dart';

class SocialLoginApi {
  static final SocialLoginApi _singleton = SocialLoginApi._internal();
  SocialLoginApi._internal();
  static SocialLoginApi get instance => _singleton;
  Future<SocialLoginModel> googleLogin({
    required String token,
    required String provider,
  }) async {
    try {
      Map<dynamic, dynamic> data = {
        "token": token,
        "provider": provider,
      };
      Response response = await postHttp(Endpoints.socialLogin(), data);
      if (response.statusCode == 200) {
        SocialLoginModel data =
            SocialLoginModel.fromJson(response.data);
        return data;
      } 
      
       else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
