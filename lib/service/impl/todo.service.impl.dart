import 'dart:async';

import 'package:todo/openapi/lib/api.dart';
import 'package:todo/service/todo.service.dart';

class TodoServiceImpl extends TodoService {
  TodoApi todoApi = TodoApi(ApiClient());

  TodoServiceImpl(this.todoApi);

  @override
  Future<DefaultResponse?> undoSoftDeletedEntity(int todoId) async {
    return todoApi.restoreDeletedTodo(todoId, api.getAccountId());
  }

  @override
  Future<DefaultResponse?> deleteEntityById(int todoId) {
    return todoApi.deleteTodoById(todoId, api.getAccountId());
  }

  @override
  Future<List<TodoDTO>?> getAllEntities() async {
    return todoApi.findAllTodosByAccountId(api.getAccountId());
  }

  @override
  Future<void> updateEntity(TodoDTO t) async {
    todoApi.updateTodo(api.getAccountId(), t);
  }

  @override
  Future<TodoDTO?> addEntity(TodoDTO t) async {
    return todoApi.addTodo(api.getAccountId(), t);
  }
}
