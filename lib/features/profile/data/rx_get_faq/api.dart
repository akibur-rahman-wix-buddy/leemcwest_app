import 'package:dio/dio.dart';
import 'package:leemcwest/features/profile/model/faq_model.dart';
import 'package:leemcwest/networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '../../../../networks/dio/dio.dart';

final class GetFaqApi {
  static final GetFaqApi _singleton = GetFaqApi._internal();
  GetFaqApi._internal();
  static GetFaqApi get instance => _singleton;

  Future<FaqModel> getFaqApi() async {
    try {
      Response response = await getHttp(Endpoints.getFaq());

      if (response.statusCode == 200) {
        final data = FaqModel.fromJson(response.data);
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
