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
final todoDashboardStateProvider = StateNotifierProvider<TodoDashboardNotifier,
    AsyncValue<TodoDashboardState>>((ref) => TodoDashboardNotifier());

// Creating Notifier
class TodoDashboardNotifier
    extends StateNotifier<AsyncValue<TodoDashboardState>> {
  final TodoService todoService = TodoServiceImpl();
  final TodoDashboardService dashboardService = TodoDashboardServiceImpl();

  // Notifier constructor - call functions on provider initialization
  TodoDashboardNotifier() : super(const AsyncLoading()) {
    loadTodoGroups();
  }

  // loadTodos grouped by todoType, isCompleted
  void loadTodoGroups() async {
    state = const AsyncLoading();
    final AsyncValue<List<TodoGroupCount>?> todoGroups =
        await AsyncValue.guard(() => dashboardService.todoGroupCountByUserId());
    final AsyncValue<int?> deletedTodos = await AsyncValue.guard(
        () => dashboardService.countSoftDeletedEntitiesByAccountId());
    final List<TodoGroupCount> list = todoGroups.value!;
    state = AsyncData(TodoDashboardState());
    state = AsyncData(state.value!.copyWith(
        todoStats: TodoStats(
            todoGroupCount: list, deletedCount: deletedTodos.value!)));
  }

  Future<int?> countSoftDeletedEntitiesByAccountId() {
    return dashboardService.countSoftDeletedEntitiesByAccountId();
  }
}
