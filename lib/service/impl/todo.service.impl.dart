import 'dart:async';

import 'package:todo/service/todo.service.dart';

import '../../openapi/lib/api.dart';

class TodoServiceImpl extends TodoService {
  TodoApi todoApi = TodoApi();

  @override
  Future<DefaultResponse?> restoreSoftDeletedTodo(int todoId) async {
    return await todoApi.restoreSoftDeletedTodo(todoId, api.getAccountId());
  }

  @override
  Future<DefaultResponse?> deleteTodoByIdAndUserId(int todoId) async {
    return await todoApi.deleteTodoByIdAndUserId(todoId, api.getAccountId());
  }

  @override
  Future<List<TodoDTO>?> loadTopEntities() async {
    return await todoApi.loadTopEntitiesByUserId(api.getAccountId());
  }

  @override
  Future<void> updateEntity(TodoDTO t) async {
    t.dueDate = t.dueDate?.add(Duration(days: 1));
    await todoApi.updateTodo(api.getAccountId(), t);
  }

  @override
  Future<TodoDTO?> addEntity(TodoDTO t) async {
    return await todoApi.addTodo(api.getAccountId(), t);
  }

  @override
  Future<List<TodoDTO>?> getAllTodosForToday() async {
    return await todoApi.findAllTodosForTodayByUserId(api.getAccountId());
  }

  @override
  Future<TodoDTO?> findTodoByIdAndUserId(int todoId) async {
    return await todoApi.findTodoByIdAndUserId(todoId, api.getAccountId());
  }

  @override
  Future<List<TodoDTO>?> findTodosByUserIdAndTodoType(TodoType todoType) async {
    return await todoApi.findTodosByUserIdAndTodoType(
        api.getAccountId(), todoType);
  }

  @override
  Future<List<TodoDTO>?> searchTodos(TodoSearchDTO todoSearchDTO) async {
    return await todoApi.searchTodos(api.getAccountId(), todoSearchDTO);
  }
}
