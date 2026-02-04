import 'package:dio/dio.dart';
import 'package:leemcwest/features/profile/model/profile_data_model.dart';
import 'package:leemcwest/networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '../../../../networks/dio/dio.dart';

final class GetOwnProfileApi {
  static final GetOwnProfileApi _singleton = GetOwnProfileApi._internal();
  GetOwnProfileApi._internal();
  static GetOwnProfileApi get instance => _singleton;

  Future<ProfileDataModel> getOwnProfileApi() async {
    try {
      Response response = await getHttp(Endpoints.getProfile());

      if (response.statusCode == 200) {
        final data = ProfileDataModel.fromJson(response.data);
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
