import 'dart:convert';

class GetLessonResponseModel {
  Data? data;
  String? message;
  int? status;

  GetLessonResponseModel({
    this.data,
    this.message,
    this.status,
  });

  factory GetLessonResponseModel.fromRawJson(String str) =>
      GetLessonResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetLessonResponseModel.fromJson(Map<String, dynamic> json) =>
      GetLessonResponseModel(
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
  List<Lesson>? lessons;

  Data({
    this.lessons,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        lessons: json["lessons"] == null
            ? []
            : List<Lesson>.from(
                json["lessons"]!.map((x) => Lesson.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lessons": lessons == null
            ? []
            : List<dynamic>.from(lessons!.map((x) => x.toJson())),
      };
}

class Lesson {
  int? id;
  String? title;
  String? slug;
  String? summary;
  int? sortOrder;
  String? thumnailImageUrl;
  bool? isPublished;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Lesson({
    this.id,
    this.title,
    this.slug,
    this.summary,
    this.sortOrder,
    this.thumnailImageUrl,
    this.isPublished,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Lesson.fromRawJson(String str) => Lesson.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        summary: json["summary"],
        sortOrder: json["sort_order"],
        thumnailImageUrl: json["thumnail_image_url"],
        isPublished: json["is_published"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "summary": summary,
        "sort_order": sortOrder,
        "thumnail_image_url": thumnailImageUrl,
        "is_published": isPublished,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
