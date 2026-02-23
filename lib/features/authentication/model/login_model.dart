import 'dart:convert';

class LoginModel {
  bool? status;
  String? message;
  String? tokenType;
  String? token;
  Data? data;

  LoginModel({
    this.status,
    this.message,
    this.tokenType,
    this.token,
    this.data,
  });

  factory LoginModel.fromRawJson(String str) =>
      LoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
  int? id;
  String? name;
  String? email;
  dynamic phone;
  dynamic dob;
  dynamic avatar;
  dynamic socialiteId;
  dynamic socialiteProvider;
  dynamic socialiteToken;
  dynamic socialiteRefreshToken;
  dynamic socialiteExpiresAt;
  int? isAgeVerified;
  bool? isAgree;
  String? role;
  String? status;
  bool? isOnline;
  DateTime? emailVerifiedAt;
  String? avatarUrl;

  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.dob,
    this.avatar,
    this.socialiteId,
    this.socialiteProvider,
    this.socialiteToken,
    this.socialiteRefreshToken,
    this.socialiteExpiresAt,
    this.isAgeVerified,
    this.isAgree,
    this.role,
    this.status,
    this.isOnline,
    this.emailVerifiedAt,
    this.avatarUrl,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        dob: json["dob"],
        avatar: json["avatar"],
        socialiteId: json["socialite_id"],
        socialiteProvider: json["socialite_provider"],
        socialiteToken: json["socialite_token"],
        socialiteRefreshToken: json["socialite_refresh_token"],
        socialiteExpiresAt: json["socialite_expires_at"],
        isAgeVerified: json["is_age_verified"],
        isAgree: json["is_agree"],
        role: json["role"],
        status: json["status"],
        isOnline: json["is_online"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        avatarUrl: json["avatar_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "dob": dob,
        "avatar": avatar,
        "socialite_id": socialiteId,
        "socialite_provider": socialiteProvider,
        "socialite_token": socialiteToken,
        "socialite_refresh_token": socialiteRefreshToken,
        "socialite_expires_at": socialiteExpiresAt,
        "is_age_verified": isAgeVerified,
        "is_agree": isAgree,
        "role": role,
        "status": status,
        "is_online": isOnline,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "avatar_url": avatarUrl,
      };
}
