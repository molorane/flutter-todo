import 'dart:async';

import 'package:todo/service/todo.api.dart';

import '../openapi/lib/api.dart';

abstract class TodoDashboardService {
  TodoAPI api = TodoAPI();

  Future<int?> countDeletedTodosByUserId();

  Future<List<TodoGroupCount>?> todoGroupCountByUserId();

  Future<List<TodoCountToday>?> todoCountTodayByUserId();
}
