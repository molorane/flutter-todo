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
part 'todo.dashboard.provider.freezed.dart';

// Creating state where the freezed annotation will suggest that boilerplate code needs to be generated
@Freezed()
abstract class TodoDashboardState with _$TodoDashboardState {
  const factory TodoDashboardState(
      {@Default(TodoStats()) TodoStats todoStats}) = _TodoDashboardState;

  const TodoDashboardState._();
}

// Creating state notifier provider
final todoDashboardStateProvider =
    AsyncNotifierProvider<TodoDashboardNotifier, TodoDashboardState>(
        TodoDashboardNotifier.new);

// Creating Notifier
class TodoDashboardNotifier extends AsyncNotifier<TodoDashboardState> {
  final TodoService todoService = TodoServiceImpl();
  final TodoDashboardService dashboardService = TodoDashboardServiceImpl();

  TodoDashboardNotifier() {
    //state = AsyncData(TodoDashboardState());
  }

  // loadTodos grouped by todoType, isCompleted
  @override
  FutureOr<TodoDashboardState> build() async {
    state = AsyncValue.loading();

    final AsyncValue<List<TodoGroupCount>?> todoGroups =
        await AsyncValue.guard(() => todoGroupCountByUserId());

    final AsyncValue<int?> deletedTodos = await AsyncValue.guard(
        () => countDeletedTodosByUserId());

    final AsyncValue<List<TodoCountToday>?> todoCountToday =
    await AsyncValue.guard(() => todoCountTodayByUserId());

    state = AsyncData(TodoDashboardState());

    return state.value!.copyWith(
        todoStats:
            TodoStats(
                todoGroupCount: todoGroups.value!,
                todoCountToday: todoCountToday.value!,
                deletedCount: deletedTodos.value!));
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
