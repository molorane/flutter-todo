import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/openapi/lib/api.dart';
import 'package:todo/service/todo.service.dart';

import '../pages/todo/notifier/todo.state.dart';
import '../service/impl/todo.service.impl.dart';

// Creating state notifier provider
final todoAddStateProvider =
    AsyncNotifierProvider<TodoAddStateNotifier, TodoState>(
        TodoAddStateNotifier.new);

// Creating Notifier
class TodoAddStateNotifier extends AsyncNotifier<TodoState> {
  final TodoService todoService = TodoServiceImpl();

  @override
  FutureOr<TodoState> build() async {
    state = AsyncData(TodoState());
    return state.value!;
  }

  resetForm() {
    state = AsyncData(TodoState());
  }

  bool isStateConstructed() {
    return state.value != null;
  }

  // add todo
  Future<TodoDTO?> addTodo(TodoDTO entity) async {
    state = AsyncLoading();
    TodoDTO? todo = await todoService.addEntity(entity);
    state = AsyncData(state.value!.copyWith(
        todoType: null, description: "", isCompleted: false, dueDate: null));
    return todo;
  }

  // update todo
  void updateTodo(TodoDTO entity) async {
    state = AsyncLoading();
    await todoService.updateEntity(entity);
    state = AsyncData(state.value!.copyWith(
        todoType: entity.todoType, description: entity.description!,
        isCompleted: entity.isCompleted, dueDate: entity.dueDate));
  }

  // delete todo by Id And userId
  Future<DefaultResponse> deleteTodoByIdAndUserId(int todoId) async {
    final TodoState todoState = state.value!;
    state = AsyncLoading();
    final todoData = await AsyncValue.guard(() async => todoService.deleteTodoByIdAndUserId(todoId));
    state = AsyncData(todoState);
    return todoData.value!;
  }

  // restore soft deleted todo by Id And userId
  Future<DefaultResponse> restoreSoftDeletedTodo(int todoId) async {
    final TodoState todoState = state.value!;
    state = AsyncLoading();
    final todoData = await AsyncValue.guard(() async => todoService.restoreSoftDeletedTodo(todoId));
    state = AsyncData(todoState);
    return todoData.value!;
  }

  // add todo
   todoAdded() {
    state = AsyncLoading();
    state = AsyncData(TodoState());
  }
}
