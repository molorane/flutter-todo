import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../openapi/lib/api.dart';
import '../service/impl/task.dashboard.service.impl.dart';
import '../service/impl/task.service.impl.dart';
import '../service/task.dashboard.service.dart';
import '../service/task.service.dart';
import '../util/task.stats.dart';

// Import freezed file (maybe not yet generated)
part 'tasks.dashboard.provider.freezed.dart';

// Creating state where the freezed annotation will suggest that boilerplate code needs to be generated
@Freezed()
abstract class TasksDashboardState with _$TasksDashboardState {
  const factory TasksDashboardState(
      {@Default(TaskStats()) TaskStats taskStats,
      @Default(null) TaskType? selectedTaskType}) = _TasksDashboardState;

  const TasksDashboardState._();
}

// Creating state notifier provider
final tasksDashboardStateProvider =
    AsyncNotifierProvider<TasksDashboardNotifier, TasksDashboardState>(
        TasksDashboardNotifier.new);

// Creating Notifier
class TasksDashboardNotifier extends AsyncNotifier<TasksDashboardState> {
  final TaskService taskService = TaskServiceImpl();
  final TaskDashboardService dashboardService = TaskDashboardServiceImpl();

  // loadTasks grouped by taskType, isCompleted
  @override
  FutureOr<TasksDashboardState> build() async {
    state = AsyncLoading();

    final AsyncValue<List<TaskGroupCount>?> taskGroups =
        await AsyncValue.guard(() => taskGroupCountByUserId());

    final AsyncValue<int?> deletedTasks =
        await AsyncValue.guard(() => countDeletedTasksByUserId());

    final AsyncValue<List<TaskCountToday>?> taskCountToday =
        await AsyncValue.guard(() => taskCountTodayByUserId());

    state = AsyncData(TasksDashboardState());

    return state.value!.copyWith(
        taskStats: TaskStats(
            taskGroupCount: taskGroups.value!,
            taskCountToday: taskCountToday.value!,
            deletedCount: deletedTasks.value!));
  }

  void setTaskType(TaskType taskType) {
    // state.value!.copyWith(selectedTaskType: taskType);
  }

  TaskType getSelectedTaskType() {
    return state.value!.selectedTaskType!;
  }

  Future<int?> countDeletedTasksByUserId() {
    return dashboardService.countDeletedTasksByUserId();
  }

  Future<List<TaskGroupCount>?> taskGroupCountByUserId() {
    return dashboardService.taskGroupCountByUserId();
  }

  Future<List<TaskCountToday>?> taskCountTodayByUserId() {
    return dashboardService.taskCountTodayByUserId();
  }
}
