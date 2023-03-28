import 'dart:async';

import 'package:dio/dio.dart';
import 'package:todo/service/task.service.dart';
import 'package:todo_api/todo_api.dart';

class TaskServiceImpl extends TaskService {
  TaskApi taskApi = TodoApi().getTaskApi();

  @override
  Future<Response<DefaultResponse>> restoreSoftDeletedTask(int taskId) async {
    return await taskApi.restoreSoftDeletedTask(
        id: taskId, userId: api.getAccountId());
  }

  @override
  Future<Response<DefaultResponse>> deleteTaskByIdAndUserId(int todoId) async {
    return await taskApi.deleteTaskByIdAndUserId(
        id: todoId, userId: api.getAccountId());
  }

  @override
  Future<Response<PageTaskDTO>> findTasksByUserId({Pageable? pageable}) async {
    return await taskApi.findTasksByUserId(
        userId: api.getAccountId(), pageable: pageable);
  }

  @override
  Future<Response<void>> updateEntity(TaskDTO t) async {
    // t.dueDate = t.dueDate?.add(Duration(days: 1));
    return await taskApi.updateTask(userId: api.getAccountId(), taskDTO: t);
  }

  @override
  Future<Response<TaskDTO>> addEntity(TaskDTO t) async {
    return await taskApi.addTask(userId: api.getAccountId(), taskDTO: t);
  }

  @override
  Future<Response<PageTaskDTO>> getAllTasksForToday(
      {Pageable? pageable}) async {
    return await taskApi.findAllTasksForTodayByUserId(
        userId: api.getAccountId(), pageable: pageable);
  }

  @override
  Future<Response<TaskDTO>> findTaskByIdAndUserId(int taskId) async {
    return await taskApi.findTaskByIdAndUserId(
        taskId: taskId, userId: api.getAccountId());
  }

  @override
  Future<Response<PageTaskDTO>> findTasksByUserIdAndTaskType(TaskType taskType,
      {Pageable? pageable}) async {
    return await taskApi.findTasksByUserIdAndTaskType(
        userId: api.getAccountId(), taskType: taskType);
  }

  @override
  Future<Response<PageTaskDTO>> searchTasks(TaskSearchDTO todoSearchDTO,
      {Pageable? pageable}) async {
    return await taskApi.searchTasks(
        userId: api.getAccountId(),
        taskSearchDTO: todoSearchDTO,
        pageable: pageable);
  }

  @override
  Future<Response<DefaultResponse>> makeTaskFavourite(int taskId, bool isFavourite) async {
    return await taskApi.makeTaskFavourite(
        id: taskId,
        userId: api.getAccountId(),
        isFavourite: isFavourite);
  }
}
