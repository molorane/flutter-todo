import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../openapi/lib/api.dart';
import '../pages/task/notifier/task.state.dart';
import '../service/impl/task.service.impl.dart';
import '../service/task.service.dart';

// Creating state notifier provider
final taskAddStateProvider =
    AsyncNotifierProvider<TaskAddStateNotifier, TaskState>(
        TaskAddStateNotifier.new);

// Creating Notifier
class TaskAddStateNotifier extends AsyncNotifier<TaskState> {
  final TaskService taskService = TaskServiceImpl();

  @override
  FutureOr<TaskState> build() async {
    state = AsyncData(TaskState());
    return state.value!;
  }

  resetForm() {
    state = AsyncData(TaskState());
  }

  bool isStateConstructed() {
    return state.value != null;
  }

  // add task
  Future<TaskDTO?> addTask(TaskDTO entity) async {
    state = AsyncLoading();
    TaskDTO? task = await taskService.addEntity(entity);
    state = AsyncData(state.value!.copyWith(
        taskType: null, description: "", isCompleted: false, dueDate: null));
    return task;
  }

  // update task
  Future<void> updateTask(TaskDTO entity) async {
    state = AsyncLoading();
    await taskService.updateEntity(entity);
    // state = AsyncData(state.value!.copyWith(
    //     taskType: entity.taskType, description: entity.description!,
    //     isCompleted: entity.isCompleted, dueDate: entity.dueDate));
  }

  updateComplete() {
    state = AsyncData(TaskState());
  }

  // delete task by Id And userId
  Future<DefaultResponse> deleteTaskByIdAndUserId(int taskId) async {
    final TaskState taskState = state.value!;
    state = AsyncLoading();
    final taskData = await AsyncValue.guard(
        () async => taskService.deleteTaskByIdAndUserId(taskId));
    state = AsyncData(taskState);
    return taskData.value!;
  }

  // restore soft deleted task by Id And userId
  Future<DefaultResponse> restoreSoftDeletedTask(int taskId) async {
    final TaskState taskState = state.value!;
    state = AsyncLoading();
    final taskData = await AsyncValue.guard(
        () async => taskService.restoreSoftDeletedTask(taskId));
    state = AsyncData(taskState);
    return taskData.value!;
  }

  // add task
  taskAdded() {
    state = AsyncLoading();
    state = AsyncData(TaskState());
  }
}
