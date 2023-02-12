import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo/dto/todo.dto.dart';
import 'package:todo/service/todo.api.dart';

import '../models/response.message.dart';
import '../models/todo.dart';
import 'end.point.dart';

class TodoService {
  final TodoAPI api;

  TodoService(this.api);

  Future<List<TodoDTO>> getAllTodos() async {
    var client = http.Client();
    var url = Uri.parse('${api.hostUri()}/${api.getPath(Endpoint.todos)}');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((e) => TodoDTO.fromJson(e))
          .toList();
    } else {
      throw response;
    }
  }

  Future<TodoDTO> addTodo(TodoDTO todoDTO) async {
    var client = http.Client();
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
    };
    var url = Uri.parse('${api.hostUri()}/${api.getPath(Endpoint.addTodo)}');
    var response = await client.post(url, headers: headers, body: jsonEncode(todoDTO.toJson()));
    if (response.statusCode == 200) {
      return jsonDecode(response.body).map((e) => TodoDTO.fromJson(e));
    } else {
      throw response;
    }
  }

  Future<TodoDTO> updateTodo(TodoDTO todoDTO) async {
    var client = http.Client();
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
    };
    var url = Uri.parse('${api.hostUri()}/${api.getPath(Endpoint.updateTodo)}');
    var response = await client.put(url, headers: headers, body: jsonEncode(todoDTO.toJson()));

    if (response.statusCode == 200) {
      return jsonDecode(response.body).map((e) => TodoDTO.fromJson(e));
    } else {
      throw response;
    }
  }

  Future<ResponseMessage> deleteTodo(String? todoId) async {
    var client = http.Client();
    var url = Uri.parse('${api.hostUri()}/${api.getPath(Endpoint.deleteTodo)}')
        .replace(queryParameters: {'id': todoId, 'userId': api.getAccountId()});
    var response = await client.delete(url);
    if (response.statusCode == 200) {
      return ResponseMessage.fromJson(jsonDecode(response.body));
    } else {
      throw response;
    }
  }

  Future<ResponseMessage> restoreDeletedTodo(String? todoId) async {
    var client = http.Client();
    var url = Uri.parse(
            '${api.hostUri()}/${api.getPath(Endpoint.restoreDeletedTodo)}')
        .replace(queryParameters: {'id': todoId, 'userId': api.getAccountId()});
    var response = await client.put(url);
    if (response.statusCode == 200) {
      return ResponseMessage.fromJson(jsonDecode(response.body));
    } else {
      throw response;
    }
  }
}
