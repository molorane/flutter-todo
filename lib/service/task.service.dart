import 'package:todo/service/task.api.dart';

import '../openapi/lib/api.dart';
import 'abstract.service.dart';

abstract class TaskService extends AbstractService<TaskDTO> {
  TaskAPI api = TaskAPI();

  Future<PageTaskDTO?> getAllTasksForToday({Pageable? pageable});

  Future<TaskDTO?> findTaskByIdAndUserId(int todoId);

  Future<PageTaskDTO?> findTasksByUserIdAndTaskType(TaskType todoType,
      {Pageable? pageable});

  Future<PageTaskDTO?> searchTasks(TaskSearchDTO todoSearchDTO,
      {Pageable? pageable});
}
