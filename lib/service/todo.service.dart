import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo/dto/todo.dto.dart';
import 'package:todo/service/todo.api.dart';

import '../models/todo.dart';
import '../models/todo.type.dart';
import 'end.point.dart';

class TodoService {
  final TodoAPI api;

  TodoService(this.api);

  Future<List<Todo>?> getAllTodos() async {
    var client = http.Client();
    var url = Uri.parse('${api.hostUri()}/${api.getPath(Endpoint.todos)}');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((e) => Todo(
                id: e['id'],
                todoType: TodoType.fromString(e['todoType']),
                title: e['title'],
                completed: e['completed'],
                dueDate: e['dueDate'],
              ))
          .toList();
    } else {
      throw response;
    }
  }

  Future<TodoDTO?> addTodo(TodoDTO todoDTO) async {
    var client = http.Client();
    var url = Uri.parse('${api.hostUri()}/${api.getPath(Endpoint.todos)}');
    var response = await client.post(url, body: todoDTO);
    if (response.statusCode == 200) {
      dynamic jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((e) => Todo(
        id: e['id'],
        todoType: TodoType.fromString(e['todoType']),
        title: e['title'],
        completed: e['completed'],
        dueDate: e['dueDate'],
      ));
    } else {
      throw response;
    }
  }
}
