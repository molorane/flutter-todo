import 'dart:async';

import '../../openapi/lib/api.dart';
import '../todo.dashboard.service.dart';

class TodoDashboardServiceImpl extends TodoDashboardService {
  final DashboardApi dashboardApi = DashboardApi();

  TodoDashboardServiceImpl();

  @override
  Future<int?> countDeletedTodosByUserId() {
    return dashboardApi.countDeletedTodosByUserId(api.getAccountId());
  }

  @override
  Future<List<TodoGroupCount>?> todoGroupCountByUserId({TodoType? todoType}) {
    return dashboardApi.todoGroupCountByUserId(api.getAccountId(),
        todoType: todoType);
  }

  @override
  Future<List<TodoCountToday>?> todoCountTodayByUserId({TodoType? todoType}) {
    return dashboardApi.todoCountTodayByUserId(api.getAccountId(),
        todoType: todoType);
  }
}
