import 'dart:async';
import 'package:todo/service/task.api.dart';

import '../openapi/lib/api.dart';

abstract class TaskDashboardService {
  TaskAPI api = TaskAPI();

  Future<int?> countDeletedTasksByUserId();

  Future<List<TaskGroupCount>?> taskGroupCountByUserId({TaskType? taskType});

  Future<List<TaskCountToday>?> taskCountTodayByUserId({TaskType? taskType});
}
