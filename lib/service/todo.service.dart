import 'dart:async';

import 'package:todo/models/todo.dart';

import '../models/response.message.dart';

abstract class TodoService {
  Future<List<Todo>> getAllTodos();

  Future<Todo> addTodo(Todo todo);

  Future<Todo> updateTodo(Todo todo);

  Future<ResponseMessage> deleteTodo(String? todoId);

  Future<ResponseMessage> restoreDeletedTodo(String? todoId);
}
