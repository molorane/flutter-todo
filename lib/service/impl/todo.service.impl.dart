import 'dart:async';

import 'package:todo/models/todo.dart';
import 'package:todo/service/repository/todo.repository.dart';
import 'package:todo/service/todo.service.dart';

import '../../models/default.response.dart';

class TodoServiceImpl extends TodoService {
  final TodoRepository todoRepository;

  TodoServiceImpl(this.todoRepository);

  @override
  Future<List<Todo>> getAllTodos() async {
    return todoRepository.getAllTodos();
  }

  @override
  Future<Todo> addTodo(Todo todo) async {
    return todoRepository.addTodo(todo);
  }

  @override
  Future<Todo> updateTodo(Todo todo) async {
    return todoRepository.updateTodo(todo);
  }

  @override
  Future<DefaultResponse> deleteTodo(String? todoId) async {
    return todoRepository.deleteTodo(todoId);
  }

  @override
  Future<DefaultResponse> restoreDeletedTodo(String? todoId) async {
    return todoRepository.restoreDeletedTodo(todoId);
  }

  @override
  Future<int> countDeletedTodosByAccountId() {
    return todoRepository.countDeletedTodosByAccountId();
  }
}
