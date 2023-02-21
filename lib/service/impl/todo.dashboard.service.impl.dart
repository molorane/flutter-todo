import 'dart:async';

import '../../openapi/lib/api.dart';
import '../todo.dashboard.service.dart';

class TodoDashboardServiceImpl extends TodoDashboardService {
  DashboardApi dashboardApi = DashboardApi(ApiClient());

  TodoDashboardServiceImpl(this.dashboardApi);

  @override
  Future<int?> countSoftDeletedEntitiesByAccountId() {
    return dashboardApi.countDeletedTodosByUserId(api.getAccountId());
  }
}
