import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../entity/page.data.dart';
import '../openapi/lib/api.dart';
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

  // loadTasks top 40 tasks
  @override
  FutureOr<TasksState> build() async {
    final AsyncValue<PageTaskDTO?> av = await getTop40Tasks();
    final List<TaskDTO> list = av.value!.content;
    state = AsyncValue.data(TasksState());
    return state.value!.copyWith(tasks: list);
  }

  loadTop40Tasks() async {
    final AsyncValue<PageTaskDTO?> av = await getTop40Tasks();
    state = AsyncData(state.value!.copyWith(tasks: av.value!.content));
  }

  Future<AsyncValue<PageTaskDTO?>> getTop40Tasks() async {
    state = AsyncLoading();
    return AsyncValue.guard(() async => taskService.loadTopEntities());
  }

  // get all tasks for today
  getAllTasksForToday() async {
    state = AsyncLoading();
    AsyncValue<PageTaskDTO?> av =
        await AsyncValue.guard(() => taskService.getAllTasksForToday());
    state = AsyncData(state.value!.copyWith(tasks: av.value!.content));
  }

  // load task by id
  Future<TaskDTO> findTaskById(int taskId) async {
    final taskData = await taskService.findTaskByIdAndUserId(taskId);
    return taskData!;
  }

  // add task
  addTask(TaskDTO task) async {
    final List<TaskDTO> list = List.from(state.value!.tasks);
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
  Future<TaskDTO> findTaskByIdAndUserId(int taskId) async {
    final task = await taskService.findTaskByIdAndUserId(taskId);
    return task!;
  }

  // find task by id and user id
  Future<TaskDTO> findTasksByUserIdAndTaskType(int taskId) async {
    final task = await taskService.findTaskByIdAndUserId(taskId);
    return task!;
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