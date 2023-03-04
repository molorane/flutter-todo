import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:todo_api/todo_api.dart';

import '../task.dashboard.service.dart';

class TaskDashboardServiceImpl extends TaskDashboardService {
  final DashboardApi dashboardApi = TodoApi().getDashboardApi();

  TaskDashboardServiceImpl();

  @override
  Future<Response<int>> countDeletedTasksByUserId() {
    return dashboardApi.countDeletedTasksByUserId(userId: api.getAccountId());
  }

  @override
  Future<Response<BuiltList<TaskGroupCount>>> taskGroupCountByUserId(
      {TaskType? taskType}) {
    return dashboardApi.taskGroupCountByUserId(
        userId: api.getAccountId(), taskType: taskType);
  }

  @override
  Future<Response<BuiltList<TaskCountToday>>> taskCountTodayByUserId(
      {TaskType? taskType}) {
    return dashboardApi.taskCountTodayByUserId(
        userId: api.getAccountId(), taskType: taskType);
  }
}
