import 'dart:async';

import 'package:todo/models/todo.dart';

import '../models/default.response.dart';

abstract class TodoService {
  Future<List<Todo>> getAllTodos();

  Future<Todo> addTodo(Todo todo);

  Future<Todo> updateTodo(Todo todo);

  Future<DefaultResponse> deleteTodo(String? todoId);

  Future<DefaultResponse> restoreDeletedTodo(String? todoId);

  Future<int> countDeletedTodosByAccountId();
}
