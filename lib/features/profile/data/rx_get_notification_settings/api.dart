import 'package:dio/dio.dart';
import 'package:leemcwest/features/profile/model/notification_settings_model.dart';
import 'package:leemcwest/networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '../../../../networks/dio/dio.dart';

final class GetNotificationSettingsApi {
  static final GetNotificationSettingsApi _singleton = GetNotificationSettingsApi._internal();
  GetNotificationSettingsApi._internal();
  static GetNotificationSettingsApi get instance => _singleton;

  Future<NotificationSettingsModel> getNotificationSettingsApi() async {
    try {
      Response response = await getHttp(Endpoints.getNotificationSettings());

      if (response.statusCode == 200) {
        final data = NotificationSettingsModel.fromJson(response.data);
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
