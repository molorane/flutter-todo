import 'package:http/http.dart' as http;
import 'package:todo/service/api.dart';
import 'dart:convert';

import '../models/todo.dart';
import '../models/todo.type.dart';
import 'end.point.dart';

class TodoService {
  final API api;

  TodoService(this.api);

  Future<List<Todo>?> getAllTodos() async {
    var client = http.Client();
    var url = Uri.parse('${api.hostUri()}/${api.getPath(Endpoint.TODOS)}');
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
}
