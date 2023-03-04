import 'package:todo/service/impl/task.dashboard.service.impl.dart';
import 'package:todo/service/impl/task.service.impl.dart';

import '../service/task.dashboard.service.dart';
import '../service/task.service.dart';

class IocFactory {
  static TaskService? todoService;
  static TaskDashboardService? todoDashboardService;

  static TaskService getTaskService() {
    return todoService = TaskServiceImpl();
  }

  static TaskDashboardService getTaskDashboardService() {
    return todoDashboardService = TaskDashboardServiceImpl();
  }
}
