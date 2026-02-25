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
    List<Mcq>? mcq;
    List<DragDrop>? dragDrop;
    List<Mcq>? tapOrder;

    Datum({
        this.id,
        this.lessonId,
        this.status,
        this.mcq,
        this.dragDrop,
        this.tapOrder,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        lessonId: json["lesson_id"],
        status: json["status"],
        mcq: json["mcq"] == null ? [] : List<Mcq>.from(json["mcq"]!.map((x) => Mcq.fromJson(x))),
        dragDrop: json["drag_drop"] == null ? [] : List<DragDrop>.from(json["drag_drop"]!.map((x) => DragDrop.fromJson(x))),
        tapOrder: json["tap_order"] == null ? [] : List<Mcq>.from(json["tap_order"]!.map((x) => Mcq.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "lesson_id": lessonId,
        "status": status,
        "mcq": mcq == null ? [] : List<dynamic>.from(mcq!.map((x) => x.toJson())),
        "drag_drop": dragDrop == null ? [] : List<dynamic>.from(dragDrop!.map((x) => x.toJson())),
        "tap_order": tapOrder == null ? [] : List<dynamic>.from(tapOrder!.map((x) => x.toJson())),
    };
}

class DragDrop {
    int? id;
    int? quizId;
    String? type;
    String? questionText;
    Options? options;
    dynamic explanation;
    int? sortOrder;

    DragDrop({
        this.id,
        this.quizId,
        this.type,
        this.questionText,
        this.options,
        this.explanation,
        this.sortOrder,
    });

    factory DragDrop.fromRawJson(String str) => DragDrop.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DragDrop.fromJson(Map<String, dynamic> json) => DragDrop(
        id: json["id"],
        quizId: json["quiz_id"],
        type: json["type"],
        questionText: json["question_text"],
        options: json["options"] == null ? null : Options.fromJson(json["options"]),
        explanation: json["explanation"],
        sortOrder: json["sort_order"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "quiz_id": quizId,
        "type": type,
        "question_text": questionText,
        "options": options?.toJson(),
        "explanation": explanation,
        "sort_order": sortOrder,
    };
}

class Options {
    List<String>? tokens;
    List<String>? slots;

    Options({
        this.tokens,
        this.slots,
    });

    factory Options.fromRawJson(String str) => Options.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Options.fromJson(Map<String, dynamic> json) => Options(
        tokens: json["tokens"] == null ? [] : List<String>.from(json["tokens"]!.map((x) => x)),
        slots: json["slots"] == null ? [] : List<String>.from(json["slots"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "tokens": tokens == null ? [] : List<dynamic>.from(tokens!.map((x) => x)),
        "slots": slots == null ? [] : List<dynamic>.from(slots!.map((x) => x)),
    };
}

class Mcq {
    int? id;
    int? quizId;
    String? type;
    String? questionText;
    List<String>? options;
    dynamic explanation;
    int? sortOrder;

    Mcq({
        this.id,
        this.quizId,
        this.type,
        this.questionText,
        this.options,
        this.explanation,
        this.sortOrder,
    });

    factory Mcq.fromRawJson(String str) => Mcq.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Mcq.fromJson(Map<String, dynamic> json) => Mcq(
        id: json["id"],
        quizId: json["quiz_id"],
        type: json["type"],
        questionText: json["question_text"],
        options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
        explanation: json["explanation"],
        sortOrder: json["sort_order"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "quiz_id": quizId,
        "type": type,
        "question_text": questionText,
        "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
        "explanation": explanation,
        "sort_order": sortOrder,
    };
}
