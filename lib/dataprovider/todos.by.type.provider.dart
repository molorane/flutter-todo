import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo/dataprovider/todos.dashboard.provider.dart';
import 'package:todo/openapi/lib/api.dart';
import 'package:todo/service/impl/todo.dashboard.service.impl.dart';
import 'package:todo/service/todo.dashboard.service.dart';
import 'package:todo/service/todo.service.dart';

import '../service/impl/todo.service.impl.dart';

// Import freezed file (maybe not yet generated)
part 'todos.by.type.provider.freezed.dart';

// Creating state where the freezed annotation will suggest that boilerplate code needs to be generated
@Freezed()
abstract class TodosByTypeState with _$TodosByTypeState {
  const factory TodosByTypeState(
      {@Default([]) List<TodoDTO> todos,
      @Default([]) List<TodoGroupCount> todoGroupCount,
      @Default([]) List<TodoCountToday> todoCountToday}) = _TodosByTypeState;

  const TodosByTypeState._();
}

// Creating state notifier provider
final todoTypeStateProvider =
    AsyncNotifierProvider<TodosByTypeStateNotifier, TodosByTypeState>(
        TodosByTypeStateNotifier.new);

// () => TodosByTypeStateNotifier(selectedTodoType: TodoType.STUDY));

// Creating Notifier
class TodosByTypeStateNotifier extends AsyncNotifier<TodosByTypeState> {
  final TodoService todoService = TodoServiceImpl();
  final TodoDashboardService todoDashboardService = TodoDashboardServiceImpl();
  final todosDashboardStateProvider =
      AsyncNotifierProvider<TodosDashboardNotifier, TodosDashboardState>(
          TodosDashboardNotifier.new);

  // load todos by type selected
  @override
  FutureOr<TodosByTypeState> build() async {
    state = AsyncLoading();
    loadTodosByTodoTypeData(TodoType.ENTERTAINMENT);
    return state.value!;
  }

  Future<List<TodoDTO>?> getTodosByTodoType(TodoType selectedTodoType) async {
    return await todoService.findTodosByUserIdAndTodoType(selectedTodoType);
  }

  Future<TodosByTypeState> loadTodosByTodoTypeData(
      TodoType selectedTodoType) async {
    state = AsyncLoading();
    AsyncValue<List<TodoDTO>?> todos = await AsyncValue.guard(
        () => todoService.findTodosByUserIdAndTodoType(selectedTodoType));
    AsyncValue<List<TodoGroupCount>?> todoGroupCount =
        await AsyncValue.guard(() => todoGroupCountByUserId(selectedTodoType));
    AsyncValue<List<TodoCountToday>?> todoCountToday =
        await AsyncValue.guard(() => todoCountTodayByUserId(selectedTodoType));

    TodosByTypeState todosByTypeState = TodosByTypeState(
        todos: todos.value!,
        todoGroupCount: todoGroupCount.value!,
        todoCountToday: todoCountToday.value!);
    state = AsyncData(todosByTypeState);

    return todosByTypeState;
  }

  Future<List<TodoGroupCount>?> todoGroupCountByUserId(
      TodoType selectedTodoType) {
    return todoDashboardService.todoGroupCountByUserId(
        todoType: selectedTodoType);
  }

  Future<List<TodoCountToday>?> todoCountTodayByUserId(
      TodoType selectedTodoType) {
    return todoDashboardService.todoCountTodayByUserId(
        todoType: selectedTodoType);
  }
}
