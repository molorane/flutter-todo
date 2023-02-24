import 'dart:async';

import 'package:todo/service/todo.service.dart';

import '../../openapi/lib/api.dart';

class TodoServiceImpl extends TodoService {
  TodoApi todoApi = TodoApi();

  @override
  Future<DefaultResponse?> restoreSoftDeletedTodo(int todoId) async {
    return todoApi.restoreSoftDeletedTodo(todoId, api.getAccountId());
  }

  @override
  Future<DefaultResponse?> deleteTodoByIdAndUserId(int todoId) async {
    return todoApi.deleteTodoByIdAndUserId(todoId, api.getAccountId());
  }

  @override
  Future<List<TodoDTO>?> loadTopEntities() async {
    return todoApi.loadTopEntitiesByUserId(api.getAccountId());
  }

  @override
  Future<void> updateEntity(TodoDTO t) async {
    t.dueDate = t.dueDate?.add(Duration(days: 1));
    todoApi.updateTodo(api.getAccountId(), t);
  }

  @override
  Future<TodoDTO?> addEntity(TodoDTO t) async {
    return todoApi.addTodo(api.getAccountId(), t);
  }

  @override
  Future<List<TodoDTO>?> getAllTodosForToday() async {
    return todoApi.findAllTodosForTodayByUserId(api.getAccountId());
  }

  @override
  Future<TodoDTO?> findTodoByIdAndUserId(int todoId) {
    return todoApi.findTodoByIdAndUserId(todoId, api.getAccountId());
  }
}
