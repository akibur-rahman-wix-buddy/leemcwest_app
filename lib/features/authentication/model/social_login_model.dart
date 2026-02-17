import 'dart:convert';

class SocialLoginModel {
    Data? data;
    String? message;
    int? status;

    SocialLoginModel({
        this.data,
        this.message,
        this.status,
    });

    factory SocialLoginModel.fromRawJson(String str) => SocialLoginModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SocialLoginModel.fromJson(Map<String, dynamic> json) => SocialLoginModel(
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
    String? tokenType;
    dynamic expiresIn;
    User? user;

    Data({
        this.token,
        this.tokenType,
        this.expiresIn,
        this.user,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "user": user?.toJson(),
    };
}

class User {
    int? id;
    String? name;
    String? email;
    dynamic phone;
    dynamic dob;
    String? avatar;
    String? socialiteId;
    String? socialiteProvider;
    dynamic socialiteToken;
    dynamic socialiteRefreshToken;
    dynamic socialiteExpiresAt;
    int? isAgeVerified;
    bool? isAgree;
    String? role;
    String? status;
    bool? isOnline;
    dynamic emailVerifiedAt;
    String? avatarUrl;

    User({
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

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
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
        emailVerifiedAt: json["email_verified_at"],
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
        "email_verified_at": emailVerifiedAt,
        "avatar_url": avatarUrl,
    };
}
