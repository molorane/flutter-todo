import 'dart:async';

import 'package:todo/service/todo.api.dart';

abstract class TodoDashboardService {
  TodoAPI api = TodoAPI();

  Future<int?> countSoftDeletedEntitiesByAccountId();
}
