import 'dart:math';
import 'dart:ui';
import 'package:todo_api/todo_api.dart';

class TaskStats {
  final List<TaskGroupCount> taskGroupCount;
  final List<TaskCountToday> taskCountToday;
  final int deletedCount;
  static final Map<TaskType, Color> colors = {};
  static final List<Color> usedColors = [];

  const TaskStats(
      {this.taskGroupCount = const [],
      this.taskCountToday = const [],
      this.deletedCount = 0
      });

  int countAllTasks() {
    return safeReduce(taskGroupCount.map((e) => e.totalTasks!).toList(),
        (value, element) => value + element);
  }

  int safeReduce(List<int> list, Function function) {
    if (list.isEmpty) return 0;
    return list.reduce((v, e) => function(v, e));
  }

  int countCompletedTasks() {
    final List<TaskGroupCount> countCompletedTasks =
        taskGroupCount.where((element) => element.isCompleted!).toList();

    return safeReduce(countCompletedTasks.map((e) => e.totalTasks!).toList(),
        (value, element) => value + element);
  }

  int countInProgressTasks() {
    final List<TaskGroupCount> countInProgressTasks =
        taskGroupCount.where((element) => !element.isCompleted!).toList();

    return safeReduce(countInProgressTasks.map((e) => e.totalTasks!).toList(),
        (value, element) => value + element);
  }

  int countCompletedTasksToday() {
    final List<TaskCountToday> countCompletedTasksToday =
        taskCountToday.where((element) => element.isCompleted!).toList();

    return safeReduce(
        countCompletedTasksToday.map((e) => e.totalTasks!).toList(),
        (value, element) => value + element);
  }

  int countTasksForToday() {
    return safeReduce(taskCountToday.map((e) => e.totalTasks!).toList(),
        (value, element) => value + element);
  }

  double completedTasksPercentage() {
    int completed = countCompletedTasks();
    if (completed == 0) return 0;
    return countCompletedTasks() / countAllTasks();
  }

  int countTasksByType(TaskType taskType) {
    final List<TaskGroupCount> countTasksByType = taskGroupCount
        .where((element) => element.taskType == taskType)
        .toList();

    return safeReduce(countTasksByType.map((e) => e.totalTasks!).toList(),
        (value, element) => value + element);
  }

  int countCompletedTasksByType(TaskType taskType) {
    final List<TaskGroupCount> countCompletedTasksByType = taskGroupCount
        .where((e) => e.taskType == taskType && e.isCompleted!)
        .toList();

    return safeReduce(
        countCompletedTasksByType.map((e) => e.totalTasks!).toList(),
        (value, element) => value + element);
  }

  int countInProgressTasksByType(TaskType taskType) {
    final List<TaskGroupCount> countInProgressTasksByType = taskGroupCount
        .where((e) => e.taskType == taskType && !e.isCompleted!)
        .toList();

    return safeReduce(
        countInProgressTasksByType.map((e) => e.totalTasks!).toList(),
        (value, element) => value + element);
  }

  int getPercentage(TaskType taskType) {
    return (countCompletedTasksByType(taskType) /
            countTasksByType(taskType) *
            100)
        .round();
  }

  double getCompletedRatio(TaskType taskType) {
    return countCompletedTasksByType(taskType) / countTasksByType(taskType);
  }

  Set<TaskType> groupTasks() {
    Set<TaskType> taskTypes = <TaskType>{};
    for (var item in taskGroupCount) {
      taskTypes.add(item.taskType!);
      if(colors[item.taskType!] == null) {
        colors[item.taskType!] = randomColor();
      }
    }

    return taskTypes;
  }

  Color randomColor() {
    Color newColor = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    while (usedColors.contains(newColor))
      newColor = Color((Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0);
    usedColors.add(newColor);
    return newColor;
  }

  Color getColor(TaskType taskType) {
    return colors[taskType]!;
  }
}
