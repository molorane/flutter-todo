import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:todo/service/todo.api.dart';
import 'package:todo_api/todo_api.dart';

abstract class TaskDashboardService {
  final TodoAPI api = TodoAPI();

  Future<Response<int>> countDeletedTasksByUserId();

  Future<Response<BuiltList<TaskGroupCount>>> taskGroupCountByUserId(
      {TaskType? taskType});

  Future<Response<BuiltList<TaskCountToday>>> taskCountTodayByUserId(
      {TaskType? taskType});
}
