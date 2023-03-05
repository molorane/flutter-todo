import 'package:dio/dio.dart';
import 'package:todo/service/task.api.dart';
import 'package:todo_api/todo_api.dart';

import 'abstract.service.dart';

abstract class TaskService extends AbstractService<TaskDTO> {
  TaskAPI api = TaskAPI();

  Future<Response<PageTaskDTO>> getAllTasksForToday({Pageable? pageable});

  Future<Response<TaskDTO>> findTaskByIdAndUserId(int taskId);

  Future<Response<PageTaskDTO>> findTasksByUserIdAndTaskType(TaskType taskType,
      {Pageable? pageable});

  Future<Response<PageTaskDTO>> searchTasks(TaskSearchDTO todoSearchDTO,
      {Pageable? pageable});
}
