import 'dart:convert';

class GetProgressResponseModel {
    bool? status;
    Data? data;

    GetProgressResponseModel({
        this.status,
        this.data,
    });

    factory GetProgressResponseModel.fromRawJson(String str) => GetProgressResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetProgressResponseModel.fromJson(Map<String, dynamic> json) => GetProgressResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    int? totalProgress;
    String? progressFraction;
    String? lessonsDone;
    String? quizzesDone;
    LessonCompleted? lessonCompleted;
    LessonCompleted? quizzesTaken;

    Data({
        this.totalProgress,
        this.progressFraction,
        this.lessonsDone,
        this.quizzesDone,
        this.lessonCompleted,
        this.quizzesTaken,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalProgress: json["total_progress"],
        progressFraction: json["progress_fraction"],
        lessonsDone: json["lessons_done"],
        quizzesDone: json["quizzes_done"],
        lessonCompleted: json["lesson_completed"] == null ? null : LessonCompleted.fromJson(json["lesson_completed"]),
        quizzesTaken: json["quizzes_taken"] == null ? null : LessonCompleted.fromJson(json["quizzes_taken"]),
    );

    Map<String, dynamic> toJson() => {
        "total_progress": totalProgress,
        "progress_fraction": progressFraction,
        "lessons_done": lessonsDone,
        "quizzes_done": quizzesDone,
        "lesson_completed": lessonCompleted?.toJson(),
        "quizzes_taken": quizzesTaken?.toJson(),
    };
}

class LessonCompleted {
    String? summary;
    List<Item>? items;

    LessonCompleted({
        this.summary,
        this.items,
    });

    factory LessonCompleted.fromRawJson(String str) => LessonCompleted.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LessonCompleted.fromJson(Map<String, dynamic> json) => LessonCompleted(
        summary: json["summary"],
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "summary": summary,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class Item {
    int? lessonId;
    String? title;
    int? progressPercentage;
    String? status;
    int? quizId;

    Item({
        this.lessonId,
        this.title,
        this.progressPercentage,
        this.status,
        this.quizId,
    });

    factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        lessonId: json["lesson_id"],
        title: json["title"],
        progressPercentage: json["progress_percentage"],
        status: json["status"],
        quizId: json["quiz_id"],
    );

    Map<String, dynamic> toJson() => {
        "lesson_id": lessonId,
        "title": title,
        "progress_percentage": progressPercentage,
        "status": status,
        "quiz_id": quizId,
    };
}
