import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_api/todo_api.dart';

import '../entity/page.data.dart';
import '../service/impl/task.service.impl.dart';
import '../service/task.service.dart';

// Import freezed file (maybe not yet generated)
part 'tasks.provider.freezed.dart';

// Creating state where the freezed annotation will suggest that boilerplate code needs to be generated
@Freezed()
abstract class TasksState with _$TasksState {
  const factory TasksState(
      {@Default([]) List<TaskDTO> tasks,
      @Default(PageData()) PageData pageData,
      @Default([]) List<TaskDTO> pageDataList}) = _TasksState;

  const TasksState._();
}

// Creating state notifier provider
final tasksStateProvider =
    AsyncNotifierProvider<TasksStateNotifier, TasksState>(
        TasksStateNotifier.new);

// Creating Notifier
class TasksStateNotifier extends AsyncNotifier<TasksState> {
  final TaskService taskService = TaskServiceImpl();

  // loadTasks top 20 tasks
  @override
  FutureOr<TasksState> build() async {
    state = AsyncLoading();
    final AsyncValue<Response<PageTaskDTO>> av =
        await AsyncValue.guard(() => taskService.findTasksByUserId());
    final List<TaskDTO> list = av.value!.data!.content!.toList();
    state = AsyncValue.data(TasksState(tasks: list));
    return state.value!;
  }

  Future<void> findTasksByUserId() async {
    state = AsyncLoading();
    final AsyncValue<Response<PageTaskDTO>> av =
        await AsyncValue.guard(() => taskService.findTasksByUserId());
    state = AsyncData(
        state.value!.copyWith(tasks: av.value!.data!.content!.toList()));
  }

  // get all tasks for today
  Future<void> loadTasksForToday() async {
    state = AsyncLoading();
    AsyncValue<Response<PageTaskDTO>> av =
        await AsyncValue.guard(() => taskService.getAllTasksForToday());
    if (av.value!.data!.content != null) {
      state = AsyncData(
          state.value!.copyWith(tasks: av.value!.data!.content!.toList()));
    } else {
      state = AsyncData(TasksState());
    }
  }

  // load task by id
  Future<TaskDTO> findTaskById(int taskId) async {
    final Response<TaskDTO> taskData =
        await taskService.findTaskByIdAndUserId(taskId);
    return taskData.data!;
  }

  // add task
  addTask(TaskDTO task) async {
    final List<TaskDTO> list = List.from(state.value!.tasks);
    list.insert(0, task);
    state = AsyncData(state.value!.copyWith(tasks: list));
  }

  // update task
  updateTask(TaskDTO task) async {
    final List<TaskDTO> list =
        state.value!.tasks.where((element) => element.id != task.id).toList();
    list.insert(0, task);
    state = AsyncData(state.value!.copyWith(tasks: list));
  }

  void taskDeleted(int taskId) {
    final List<TaskDTO> list =
        state.value!.tasks.where((element) => element.id != taskId).toList();
    state = AsyncData(state.value!.copyWith(tasks: list));
  }

  void taskRestored(int taskId) {
    final List<TaskDTO> list =
        state.value!.tasks.where((element) => element.id != taskId).toList();
    state = AsyncData(state.value!.copyWith(tasks: list));
  }

  // find task by id and user id
  Future<Response<TaskDTO>> findTaskByIdAndUserId(int taskId) async {
    return await taskService.findTaskByIdAndUserId(taskId);
  }

  // find task by id and user id
  Future<Response<TaskDTO>> findTasksByUserIdAndTaskType(int taskId) async {
    return await taskService.findTaskByIdAndUserId(taskId);
  }

  restoredTask(TaskDTO restored) {
    final List<TaskDTO> list = List.from(state.value!.tasks);
    list.insert(0, restored);
    state = AsyncData(state.value!.copyWith(tasks: list));
  }

  TaskDTO? getDeletedTask(int taskId) {
    final List<TaskDTO> list =
        state.value!.tasks.where((element) => element.id == taskId).toList();

    if (list.isNotEmpty) return list.first;

    return null;
  }
}
