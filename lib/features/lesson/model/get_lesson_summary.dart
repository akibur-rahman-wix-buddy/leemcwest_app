import 'dart:convert';

class GetLessonSummaryResponseModel {
    Data? data;
    String? message;
    int? status;

    GetLessonSummaryResponseModel({
        this.data,
        this.message,
        this.status,
    });

    factory GetLessonSummaryResponseModel.fromRawJson(String str) => GetLessonSummaryResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetLessonSummaryResponseModel.fromJson(Map<String, dynamic> json) => GetLessonSummaryResponseModel(
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
    int? lessonId;
    String? summary;

    Data({
        this.lessonId,
        this.summary,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        lessonId: json["lesson_id"],
        summary: json["summary"],
    );

    Map<String, dynamic> toJson() => {
        "lesson_id": lessonId,
        "summary": summary,
    };
}
