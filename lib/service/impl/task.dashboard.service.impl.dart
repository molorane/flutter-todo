import 'dart:async';

import '../../openapi/lib/api.dart';
import '../task.dashboard.service.dart';

class TaskDashboardServiceImpl extends TaskDashboardService {
  final DashboardApi dashboardApi = DashboardApi();

  TaskDashboardServiceImpl();

  @override
  Future<int?> countDeletedTasksByUserId() {
    return dashboardApi.countDeletedTasksByUserId(api.getAccountId());
  }

  @override
  Future<List<TaskGroupCount>?> taskGroupCountByUserId({TaskType? taskType}) {
    return dashboardApi.taskGroupCountByUserId(api.getAccountId(),
        taskType: taskType);
  }

  @override
  Future<List<TaskCountToday>?> taskCountTodayByUserId({TaskType? taskType}) {
    return dashboardApi.taskCountTodayByUserId(api.getAccountId(),
        taskType: taskType);
  }
}
