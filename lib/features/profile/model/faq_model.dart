import 'dart:convert';

class FaqModel {
    List<Datum>? data;
    String? message;
    int? status;

    FaqModel({
        this.data,
        this.message,
        this.status,
    });

    factory FaqModel.fromRawJson(String str) => FaqModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
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
    String? question;
    String? answer;
    String? status;

    Datum({
        this.id,
        this.question,
        this.answer,
        this.status,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        question: json["question"],
        answer: json["answer"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answer": answer,
        "status": status,
    };
}
