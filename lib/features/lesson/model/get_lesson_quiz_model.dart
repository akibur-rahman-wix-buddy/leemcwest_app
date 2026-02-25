import 'dart:convert';

class GetLessonQuizResponseModel {
    List<Datum>? data;
    String? message;
    int? status;

    GetLessonQuizResponseModel({
        this.data,
        this.message,
        this.status,
    });

    factory GetLessonQuizResponseModel.fromRawJson(String str) => GetLessonQuizResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetLessonQuizResponseModel.fromJson(Map<String, dynamic> json) => GetLessonQuizResponseModel(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "status": status,
    };
}

class Datum {
    int? id;
    int? lessonId;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    List<Question>? questions;
    Lesson? lesson;

    Datum({
        this.id,
        this.lessonId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.questions,
        this.lesson,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        lessonId: json["lesson_id"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        questions: json["questions"] == null ? [] : List<Question>.from(json["questions"]!.map((x) => Question.fromJson(x))),
        lesson: json["lesson"] == null ? null : Lesson.fromJson(json["lesson"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "lesson_id": lessonId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toJson())),
        "lesson": lesson?.toJson(),
    };
}

class Lesson {
    int? id;

    Lesson({
        this.id,
    });

    factory Lesson.fromRawJson(String str) => Lesson.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}

class Question {
    int? id;
    int? quizId;
    String? type;
    String? questionText;
    dynamic options;
    dynamic correctAnswer;
    dynamic explanation;
    int? sortOrder;
    DateTime? createdAt;
    DateTime? updatedAt;

    Question({
        this.id,
        this.quizId,
        this.type,
        this.questionText,
        this.options,
        this.correctAnswer,
        this.explanation,
        this.sortOrder,
        this.createdAt,
        this.updatedAt,
    });

    factory Question.fromRawJson(String str) => Question.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        quizId: json["quiz_id"],
        type: json["type"],
        questionText: json["question_text"],
        options: json["options"],
        correctAnswer: json["correct_answer"],
        explanation: json["explanation"],
        sortOrder: json["sort_order"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "quiz_id": quizId,
        "type": type,
        "question_text": questionText,
        "options": options,
        "correct_answer": correctAnswer,
        "explanation": explanation,
        "sort_order": sortOrder,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class OptionsClass {
    List<String>? tokens;
    List<String>? slots;

    OptionsClass({
        this.tokens,
        this.slots,
    });

    factory OptionsClass.fromRawJson(String str) => OptionsClass.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OptionsClass.fromJson(Map<String, dynamic> json) => OptionsClass(
        tokens: json["tokens"] == null ? [] : List<String>.from(json["tokens"]!.map((x) => x)),
        slots: json["slots"] == null ? [] : List<String>.from(json["slots"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "tokens": tokens == null ? [] : List<dynamic>.from(tokens!.map((x) => x)),
        "slots": slots == null ? [] : List<dynamic>.from(slots!.map((x) => x)),
    };
}
