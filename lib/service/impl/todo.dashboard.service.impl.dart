import 'dart:async';

import '../../openapi/lib/api.dart';
import '../todo.dashboard.service.dart';

class TodoDashboardServiceImpl extends TodoDashboardService {
  final DashboardApi dashboardApi = DashboardApi();

  TodoDashboardServiceImpl();

  @override
  Future<int?> countSoftDeletedEntitiesByAccountId() {
    return dashboardApi.countDeletedTodosByUserId(api.getAccountId());
  }

  @override
  Future<List<TodoGroupCount>?> todoGroupCountByUserId() {
    return dashboardApi.todoGroupCountByUserId(api.getAccountId());
  }
}
