import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo/provider/tasks.by.type.provider.dart';
import 'package:todo_api/todo_api.dart';

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

    final AsyncValue<Response<BuiltList<TaskGroupCount>>> taskGroups =
        await AsyncValue.guard(() => taskGroupCountByUserId());

    final AsyncValue<Response<int>> deletedTasks =
        await AsyncValue.guard(() => countDeletedTasksByUserId());

    final AsyncValue<Response<BuiltList<TaskCountToday>>> taskCountToday =
        await AsyncValue.guard(() => taskCountTodayByUserId());

    state = AsyncValue.data(TasksDashboardState(
        taskStats: TaskStats(
            taskGroupCount: taskGroups.value!.data!.toList(),
            taskCountToday: taskCountToday.value!.data!.toList(),
            deletedCount: deletedTasks.value!.data!)));
    return state.value!;
  }

  void refresh() async {
    try {
      state = AsyncLoading();

      final AsyncValue<Response<BuiltList<TaskGroupCount>>> taskGroups =
          await AsyncValue.guard(() => taskGroupCountByUserId());

      final AsyncValue<Response<int>> deletedTasks =
          await AsyncValue.guard(() => countDeletedTasksByUserId());

      final AsyncValue<Response<BuiltList<TaskCountToday>>> taskCountToday =
          await AsyncValue.guard(() => taskCountTodayByUserId());

      state = AsyncValue.data(TasksDashboardState(
          taskStats: TaskStats(
              taskGroupCount: taskGroups.value!.data!.toList(),
              taskCountToday: taskCountToday.value!.data!.toList(),
              deletedCount: deletedTasks.value!.data!)));
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }

  void setTaskType(TaskType taskType) {
    ref.read(taskTypeStateProvider.notifier).setTaskType(taskType);
  }

  TaskType getSelectedTaskType() {
    return state.value!.selectedTaskType!;
  }

  TaskStats getTaskStats() {
    return state.value!.taskStats;
  }

  Future<Response<int>> countDeletedTasksByUserId() {
    return dashboardService.countDeletedTasksByUserId();
  }

  Future<Response<BuiltList<TaskGroupCount>>> taskGroupCountByUserId() {
    return dashboardService.taskGroupCountByUserId();
  }

  Future<Response<BuiltList<TaskCountToday>>> taskCountTodayByUserId() {
    return dashboardService.taskCountTodayByUserId();
  }
}
