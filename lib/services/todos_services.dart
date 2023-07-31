import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/todos.dart';

class todos_services {
  String url = "https://jsonplaceholder.typicode.com/todos";

  Future<List<Todosmodel>> get_todos() async {
    List<Todosmodel> todos = [];
    Response response = await Dio().get(url);
    var data = response.data;
    data.forEach((Element) {
      Todosmodel todo = Todosmodel.fromJson(Element);
      todos.add(todo);
    });
    return todos;
  }
}
