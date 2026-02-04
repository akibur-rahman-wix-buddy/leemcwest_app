import 'dart:convert';

class OtpPassModel {
    Data? data;
    String? message;
    int? status;

    OtpPassModel({
        this.data,
        this.message,
        this.status,
    });

    factory OtpPassModel.fromRawJson(String str) => OtpPassModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OtpPassModel.fromJson(Map<String, dynamic> json) => OtpPassModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
        "status": status,
    };
}

class Data {
    String? token;
    String? expiredIn;

    Data({
        this.token,
        this.expiredIn,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        expiredIn: json["expired_in"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "expired_in": expiredIn,
    };
}
