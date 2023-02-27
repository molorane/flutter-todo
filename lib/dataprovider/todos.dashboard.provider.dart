import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo/openapi/lib/api.dart';
import 'package:todo/service/impl/todo.dashboard.service.impl.dart';
import 'package:todo/service/todo.dashboard.service.dart';
import 'package:todo/service/todo.service.dart';

import '../service/impl/todo.service.impl.dart';
import '../util/todo.stats.dart';

// Import freezed file (maybe not yet generated)
part 'todos.dashboard.provider.freezed.dart';

// Creating state where the freezed annotation will suggest that boilerplate code needs to be generated
@Freezed()
abstract class TodosDashboardState with _$TodosDashboardState {
  const factory TodosDashboardState(
          {@Default(TodoStats()) TodoStats todoStats,
          @Default(TodoType.UNKNOWN) TodoType selectedTodoType}) =
      _TodosDashboardState;

  const TodosDashboardState._();
}

// Creating state notifier provider
final todosDashboardStateProvider =
    AsyncNotifierProvider<TodosDashboardNotifier, TodosDashboardState>(
        TodosDashboardNotifier.new);

// Creating Notifier
class TodosDashboardNotifier extends AsyncNotifier<TodosDashboardState> {
  final TodoService todoService = TodoServiceImpl();
  final TodoDashboardService dashboardService = TodoDashboardServiceImpl();

  // loadTodos grouped by todoType, isCompleted
  @override
  FutureOr<TodosDashboardState> build() async {
    state = AsyncLoading();

    final AsyncValue<List<TodoGroupCount>?> todoGroups =
        await AsyncValue.guard(() => todoGroupCountByUserId());

    final AsyncValue<int?> deletedTodos =
        await AsyncValue.guard(() => countDeletedTodosByUserId());

    final AsyncValue<List<TodoCountToday>?> todoCountToday =
        await AsyncValue.guard(() => todoCountTodayByUserId());

    state = AsyncData(TodosDashboardState());

    return state.value!.copyWith(
        todoStats: TodoStats(
            todoGroupCount: todoGroups.value!,
            todoCountToday: todoCountToday.value!,
            deletedCount: deletedTodos.value!));
  }

  void setTodoType(TodoType todoType) {
    state.value!.copyWith(selectedTodoType: todoType);
  }

  TodoType getSelectedTodoType() {
    return state.value!.selectedTodoType;
  }

  Future<int?> countDeletedTodosByUserId() {
    return dashboardService.countDeletedTodosByUserId();
  }

  Future<List<TodoGroupCount>?> todoGroupCountByUserId() {
    return dashboardService.todoGroupCountByUserId();
  }

  Future<List<TodoCountToday>?> todoCountTodayByUserId() {
    return dashboardService.todoCountTodayByUserId();
  }
}
