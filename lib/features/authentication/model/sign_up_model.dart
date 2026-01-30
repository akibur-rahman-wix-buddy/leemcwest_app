import 'dart:convert';

class SignUpModel {
    bool? status;
    String? message;
    String? tokenType;
    String? token;
    Data? data;

    SignUpModel({
        this.status,
        this.message,
        this.tokenType,
        this.token,
        this.data,
    });

    factory SignUpModel.fromRawJson(String str) => SignUpModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        status: json["status"],
        message: json["message"],
        tokenType: json["token_type"],
        token: json["token"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token_type": tokenType,
        "token": token,
        "data": data?.toJson(),
    };
}

class Data {
    String? name;
    String? email;
    int? id;

    Data({
        this.name,
        this.email,
        this.id,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        email: json["email"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "id": id,
    };
}
