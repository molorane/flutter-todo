import 'dart:async';

import 'package:todo/service/task.service.dart';

import '../../openapi/lib/api.dart';

class TaskServiceImpl extends TaskService {
  TaskApi taskApi = TaskApi();

  @override
  Future<DefaultResponse?> restoreSoftDeletedTask(int todoId) async {
    return await taskApi.restoreSoftDeletedTask(todoId, api.getAccountId());
  }

  @override
  Future<DefaultResponse?> deleteTaskByIdAndUserId(int todoId) async {
    return await taskApi.deleteTaskByIdAndUserId(todoId, api.getAccountId());
  }

  @override
  Future<PageTaskDTO?> loadTopEntities({Pageable? pageable}) async {
    return await taskApi.loadTopEntitiesByUserId(api.getAccountId(),
        pageable: pageable);
  }

  @override
  Future<void> updateEntity(TaskDTO t) async {
    t.dueDate = t.dueDate?.add(Duration(days: 1));
    await taskApi.updateTask(api.getAccountId(), t);
  }

  @override
  Future<TaskDTO?> addEntity(TaskDTO t) async {
    return await taskApi.addTask(api.getAccountId(), t);
  }

  @override
  Future<PageTaskDTO?> getAllTasksForToday({Pageable? pageable}) async {
    return await taskApi.findAllTasksForTodayByUserId(api.getAccountId(),
        pageable: pageable);
  }

  @override
  Future<TaskDTO?> findTaskByIdAndUserId(int todoId) async {
    return await taskApi.findTaskByIdAndUserId(todoId, api.getAccountId());
  }

  @override
  Future<PageTaskDTO?> findTasksByUserIdAndTaskType(TaskType todoType,
      {Pageable? pageable}) async {
    return await taskApi.findTasksByUserIdAndTaskType(
        api.getAccountId(), todoType);
  }

  @override
  Future<PageTaskDTO?> searchTasks(TaskSearchDTO todoSearchDTO,
      {Pageable? pageable}) async {
    return await taskApi.searchTasks(api.getAccountId(), todoSearchDTO,
        pageable: pageable);
  }
}
