import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo/provider/tasks.dashboard.provider.dart';
import 'package:todo_api/todo_api.dart';

import '../service/impl/task.dashboard.service.impl.dart';
import '../service/impl/task.service.impl.dart';
import '../service/task.dashboard.service.dart';
import '../service/task.service.dart';

// Import freezed file (maybe not yet generated)
part 'tasks.by.type.provider.freezed.dart';

// Creating state where the freezed annotation will suggest that boilerplate code needs to be generated
@Freezed()
abstract class TasksByTypeState with _$TasksByTypeState {
  const factory TasksByTypeState(
      {@Default([]) List<TaskDTO> tasks,
      @Default([]) List<TaskGroupCount> taskGroupCount,
      @Default([]) List<TaskCountToday> taskCountToday}) = _TasksByTypeState;

  const TasksByTypeState._();
}

// Creating state notifier provider
final taskTypeStateProvider =
    AsyncNotifierProvider<TasksByTypeStateNotifier, TasksByTypeState>(
        TasksByTypeStateNotifier.new);

// () => TasksByTypeStateNotifier(selectedTaskType: TaskType.STUDY));

// Creating Notifier
class TasksByTypeStateNotifier extends AsyncNotifier<TasksByTypeState> {
  final TaskService taskService = TaskServiceImpl();
  final TaskDashboardService taskDashboardService = TaskDashboardServiceImpl();
  final tasksDashboardStateProvider =
      AsyncNotifierProvider<TasksDashboardNotifier, TasksDashboardState>(
          TasksDashboardNotifier.new);

  // load tasks by type selected
  @override
  FutureOr<TasksByTypeState> build() async {
    state = AsyncLoading();
    loadTasksByTaskTypeData(TaskType.ENTERTAINMENT);
    return state.value!;
  }

  Future<BuiltList<TaskDTO>> getTasksByTaskType(
      TaskType selectedTaskType) async {
    Response<PageTaskDTO> pageTaskDTO =
        await taskService.findTasksByUserIdAndTaskType(selectedTaskType);
    return pageTaskDTO.data!.content!;
  }

  Future<TasksByTypeState> loadTasksByTaskTypeData(
      TaskType selectedTaskType) async {
    state = AsyncLoading();
    AsyncValue<Response<PageTaskDTO>> tasks = await AsyncValue.guard(
        () => taskService.findTasksByUserIdAndTaskType(selectedTaskType));
    AsyncValue<List<TaskGroupCount>?> taskGroupCount =
        await AsyncValue.guard(() => taskGroupCountByUserId(selectedTaskType));
    AsyncValue<List<TaskCountToday>?> taskCountToday =
        await AsyncValue.guard(() => taskCountTodayByUserId(selectedTaskType));

    TasksByTypeState tasksByTypeState = TasksByTypeState(
        tasks: tasks.value!.data!.content!.toList(),
        taskGroupCount: taskGroupCount.value!,
        taskCountToday: taskCountToday.value!);
    state = AsyncData(tasksByTypeState);

    return tasksByTypeState;
  }

  Future<List<TaskGroupCount>> taskGroupCountByUserId(
      TaskType selectedTaskType) async {
    Response<BuiltList<TaskGroupCount>> group = await taskDashboardService
        .taskGroupCountByUserId(taskType: selectedTaskType);
    return group.data!.toList();
  }

  Future<List<TaskCountToday>> taskCountTodayByUserId(
      TaskType selectedTaskType) async {
    Response<BuiltList<TaskCountToday>> count = await taskDashboardService
        .taskCountTodayByUserId(taskType: selectedTaskType);
    return count.data!.toList();
  }
}
