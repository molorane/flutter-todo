import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_api/todo_api.dart';

import '../pages/task/notifier/task.state.dart';
import '../service/impl/task.service.impl.dart';
import '../service/task.service.dart';

// Creating state notifier provider
final viewTaskStateProvider =
    AsyncNotifierProvider<ViewTaskStateNotifier, TaskDTO>(
        ViewTaskStateNotifier.new);

// Creating Notifier
class ViewTaskStateNotifier extends AsyncNotifier<TaskDTO> {
  final TaskService taskService = TaskServiceImpl();

  @override
  FutureOr<TaskDTO> build() async {
    state = AsyncData(TaskDTO());
    return state.value!;
  }

  // make task favourite
  Future<Response<DefaultResponse>> makeTaskFavourite(int taskId, bool isFavourite) async {
    final TaskDTO task = state.value!;
    state = AsyncLoading();
    final taskData = await AsyncValue.guard(
        () async => taskService.makeTaskFavourite(taskId, isFavourite));
    state = AsyncData(task);
    return taskData.value!;
  }
}
