import 'dart:convert';

class GetLessonShowResponseModel {
  Data? data;
  String? message;
  int? status;

  GetLessonShowResponseModel({
    this.data,
    this.message,
    this.status,
  });

  factory GetLessonShowResponseModel.fromRawJson(String str) =>
      GetLessonShowResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetLessonShowResponseModel.fromJson(Map<String, dynamic> json) =>
      GetLessonShowResponseModel(
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
  Lesson? lesson;
  dynamic quiz;

  Data({
    this.lesson,
    this.quiz,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        lesson: json["lesson"] == null ? null : Lesson.fromJson(json["lesson"]),
        quiz: json["quiz"],
      );

  Map<String, dynamic> toJson() => {
        "lesson": lesson?.toJson(),
        "quiz": quiz,
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
  List<Content>? contents;
  List<dynamic>? quizzes;

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
    this.contents,
    this.quizzes,
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
        contents: json["contents"] == null
            ? []
            : List<Content>.from(
                json["contents"]!.map((x) => Content.fromJson(x))),
        quizzes: json["quizzes"] == null
            ? []
            : List<dynamic>.from(json["quizzes"]!.map((x) => x)),
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
        "contents": contents == null
            ? []
            : List<dynamic>.from(contents!.map((x) => x.toJson())),
        "quizzes":
            quizzes == null ? [] : List<dynamic>.from(quizzes!.map((x) => x)),
      };
}

class Content {
  int? id;
  int? lessonId;
  String? content;
  String? imageUrl;
  String? audioUrl;
  int? sortOrder;
  DateTime? createdAt;
  DateTime? updatedAt;

  Content({
    this.id,
    this.lessonId,
    this.content,
    this.imageUrl,
    this.audioUrl,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  factory Content.fromRawJson(String str) => Content.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        lessonId: json["lesson_id"],
        content: json["content"],
        imageUrl: json["image_url"],
        audioUrl: json["audio_url"],
        sortOrder: json["sort_order"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lesson_id": lessonId,
        "content": content,
        "image_url": imageUrl,
        "audio_url": audioUrl,
        "sort_order": sortOrder,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
