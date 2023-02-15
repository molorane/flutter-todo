import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:todo/service/todo.api.dart';

import '../../models/response.message.dart';
import '../../models/todo.dart';
import '../end.point.dart';
import '../exceptions/bad.request.exception.dart';
import '../exceptions/fetch.data.exception.dart';
import '../exceptions/no.response.exception.dart';
import '../exceptions/unauthorised.exception.dart';

class TodoRepository {
  final TodoAPI api = TodoAPI();
  final Client httpClient;

  TodoRepository({
    required this.httpClient,
  });

  Future<List<Todo>> getAllTodos() async {
    var url = Uri.parse('${api.hostUri()}/${api.getPath(Endpoint.todos)}');
    try {
      var response = await httpClient
          .get(url)
          .timeout(const Duration(seconds: TodoAPI.TIME_OUT_DURATION));
      return (processResponse(response) as List)
          .map((e) => Todo.fromJson(e))
          .toList();
    } on SocketException {
      throw FetchDataException('No Internet connection', url.toString());
    } on TimeoutException {
      throw NoResponseException('API not responded in time', url.toString());
    }
  }

  Future<Todo> addTodo(Todo todo) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
    };
    var url = Uri.parse('${api.hostUri()}/${api.getPath(Endpoint.addTodo)}');
    try {
      var response = await httpClient
          .post(url, headers: headers, body: jsonEncode(todo.toJson()))
          .timeout(const Duration(seconds: TodoAPI.TIME_OUT_DURATION));
      return Todo.fromJson(processResponse(response));
    } on SocketException {
      throw FetchDataException('No Internet connection', url.toString());
    } on TimeoutException {
      throw NoResponseException('API not responded in time', url.toString());
    }
  }

  Future<Todo> updateTodo(Todo todo) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
    };
    var url = Uri.parse('${api.hostUri()}/${api.getPath(Endpoint.updateTodo)}');
    try {
      var response = await httpClient
          .put(url, headers: headers, body: jsonEncode(todo.toJson()))
          .timeout(const Duration(seconds: TodoAPI.TIME_OUT_DURATION));
      return Todo.fromJson(processResponse(response));
    } on SocketException {
      throw FetchDataException('No Internet connection', url.toString());
    } on TimeoutException {
      throw NoResponseException('API not responded in time', url.toString());
    }
  }

  Future<ResponseMessage> deleteTodo(String? todoId) async {
    var url = Uri.parse('${api.hostUri()}/${api.getPath(Endpoint.deleteTodo)}')
        .replace(queryParameters: {'id': todoId, 'userId': api.getAccountId()});
    try {
      var response = await httpClient
          .delete(url)
          .timeout(const Duration(seconds: TodoAPI.TIME_OUT_DURATION));
      return ResponseMessage.fromJson(processResponse(response));
    } on SocketException {
      throw FetchDataException('No Internet connection', url.toString());
    } on TimeoutException {
      throw NoResponseException('API not responded in time', url.toString());
    }
  }

  Future<ResponseMessage> restoreDeletedTodo(String? todoId) async {
    var url = Uri.parse(
            '${api.hostUri()}/${api.getPath(Endpoint.restoreDeletedTodo)}')
        .replace(queryParameters: {'id': todoId, 'userId': api.getAccountId()});
    try {
      var response = await httpClient
          .put(url)
          .timeout(const Duration(seconds: TodoAPI.TIME_OUT_DURATION));
      return ResponseMessage.fromJson(processResponse(response));
    } on SocketException {
      throw FetchDataException('No Internet connection', url.toString());
    } on TimeoutException {
      throw NoResponseException('API not responded in time', url.toString());
    }
  }

  dynamic processResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
        break;
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
        break;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}
