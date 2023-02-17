import 'dart:async';

import 'package:todo/openapi/lib/api.dart';

import '../todo.dashboard.service.dart';

class TodoDashboardServiceImpl extends TodoDashboardService {
  DashboardApi dashboardApi = DashboardApi(ApiClient());

  TodoDashboardServiceImpl(this.dashboardApi);

  @override
  Future<int?> countSoftDeletedEntitiesByAccountId() {
    return dashboardApi.countDeletedTodosByAccountId(api.getAccountId());
  }
}
