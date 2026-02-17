import 'dart:convert';

class NotificationSettingsModel {
    bool? success;
    String? message;
    Data? data;

    NotificationSettingsModel({
        this.success,
        this.message,
        this.data,
    });

    factory NotificationSettingsModel.fromRawJson(String str) => NotificationSettingsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) => NotificationSettingsModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    bool? emailNotifications;
    bool? pushNotifications;

    Data({
        this.emailNotifications,
        this.pushNotifications,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        emailNotifications: json["email_notifications"],
        pushNotifications: json["push_notifications"],
    );

    Map<String, dynamic> toJson() => {
        "email_notifications": emailNotifications,
        "push_notifications": pushNotifications,
    };
}
