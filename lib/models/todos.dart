// To parse this JSON data, do
//
//     final todosmodel = todosmodelFromJson(jsonString);

import 'dart:convert';

List<Todosmodel> todosmodelFromJson(String str) =>
    List<Todosmodel>.from(json.decode(str).map((x) => Todosmodel.fromJson(x)));

String todosmodelToJson(List<Todosmodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Todosmodel {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  Todosmodel({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  factory Todosmodel.fromJson(Map<String, dynamic> json) => Todosmodel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };
}
