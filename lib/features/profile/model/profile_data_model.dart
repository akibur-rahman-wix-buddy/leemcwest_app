import 'dart:convert';

class ProfileDataModel {
    Data? data;
    String? message;
    int? status;

    ProfileDataModel({
        this.data,
        this.message,
        this.status,
    });

    factory ProfileDataModel.fromRawJson(String str) => ProfileDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProfileDataModel.fromJson(Map<String, dynamic> json) => ProfileDataModel(
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
    PersonalInformation? personalInformation;
    SubscriptionStatus? subscriptionStatus;
    DataPrivacy? dataPrivacy;

    Data({
        this.personalInformation,
        this.subscriptionStatus,
        this.dataPrivacy,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        personalInformation: json["personal_information"] == null ? null : PersonalInformation.fromJson(json["personal_information"]),
        subscriptionStatus: json["subscription_status"] == null ? null : SubscriptionStatus.fromJson(json["subscription_status"]),
        dataPrivacy: json["data_privacy"] == null ? null : DataPrivacy.fromJson(json["data_privacy"]),
    );

    Map<String, dynamic> toJson() => {
        "personal_information": personalInformation?.toJson(),
        "subscription_status": subscriptionStatus?.toJson(),
        "data_privacy": dataPrivacy?.toJson(),
    };
}

class DataPrivacy {
    String? downloadMyDataUrl;
    PrivacyPolicyUrl? privacyPolicyUrl;

    DataPrivacy({
        this.downloadMyDataUrl,
        this.privacyPolicyUrl,
    });

    factory DataPrivacy.fromRawJson(String str) => DataPrivacy.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DataPrivacy.fromJson(Map<String, dynamic> json) => DataPrivacy(
        downloadMyDataUrl: json["download_my_data_url"],
        privacyPolicyUrl: json["privacy_policy_url"] == null ? null : PrivacyPolicyUrl.fromJson(json["privacy_policy_url"]),
    );

    Map<String, dynamic> toJson() => {
        "download_my_data_url": downloadMyDataUrl,
        "privacy_policy_url": privacyPolicyUrl?.toJson(),
    };
}

class PrivacyPolicyUrl {
    int? id;
    String? pageTitle;
    String? pageSlug;
    String? pageContent;
    String? status;

    PrivacyPolicyUrl({
        this.id,
        this.pageTitle,
        this.pageSlug,
        this.pageContent,
        this.status,
    });

    factory PrivacyPolicyUrl.fromRawJson(String str) => PrivacyPolicyUrl.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PrivacyPolicyUrl.fromJson(Map<String, dynamic> json) => PrivacyPolicyUrl(
        id: json["id"],
        pageTitle: json["page_title"],
        pageSlug: json["page_slug"],
        pageContent: json["page_content"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "page_title": pageTitle,
        "page_slug": pageSlug,
        "page_content": pageContent,
        "status": status,
    };
}

class PersonalInformation {
    int? id;
    String? name;
    String? email;
    dynamic phone;
    dynamic dob;
    String? role;
    String? status;
    bool? isOnline;
    String? avatarUrl;

    PersonalInformation({
        this.id,
        this.name,
        this.email,
        this.phone,
        this.dob,
        this.role,
        this.status,
        this.isOnline,
        this.avatarUrl,
    });

    factory PersonalInformation.fromRawJson(String str) => PersonalInformation.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PersonalInformation.fromJson(Map<String, dynamic> json) => PersonalInformation(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        dob: json["dob"],
        role: json["role"],
        status: json["status"],
        isOnline: json["is_online"],
        avatarUrl: json["avatar_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "dob": dob,
        "role": role,
        "status": status,
        "is_online": isOnline,
        "avatar_url": avatarUrl,
    };
}

class SubscriptionStatus {
    String? currentPlan;
    dynamic nextBillingDate;
    bool? isActive;

    SubscriptionStatus({
        this.currentPlan,
        this.nextBillingDate,
        this.isActive,
    });

    factory SubscriptionStatus.fromRawJson(String str) => SubscriptionStatus.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SubscriptionStatus.fromJson(Map<String, dynamic> json) => SubscriptionStatus(
        currentPlan: json["current_plan"],
        nextBillingDate: json["next_billing_date"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "current_plan": currentPlan,
        "next_billing_date": nextBillingDate,
        "is_active": isActive,
    };
}
