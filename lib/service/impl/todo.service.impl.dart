import 'dart:async';

import 'package:todo/service/todo.service.dart';

import '../../openapi/lib/api.dart';

class TodoServiceImpl extends TodoService {
  TodoApi todoApi = TodoApi();

  @override
  Future<DefaultResponse?> undoSoftDeletedEntity(int todoId) async {
    return todoApi.restoreDeletedTodo(todoId, api.getAccountId());
  }

  @override
  Future<DefaultResponse?> deleteEntityById(int todoId) async {
    return todoApi.deleteTodoById(todoId, api.getAccountId());
  }

  @override
  Future<List<TodoDTO>?> getAllEntities() async {
    return todoApi.findAllTodosByUserId(api.getAccountId());
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
