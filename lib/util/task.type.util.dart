import 'package:todo_api/todo_api.dart';

class TaskTypeUtil {
  static TaskType fromString(String label) {
    return TaskType.values.firstWhere((v) => v.name == label.toUpperCase());
  }

  static String getTaskImageFromTaskType(TaskType taskType) {
    const String task = "assets/taskTypes";
    switch (taskType) {
      case TaskType.PRAY:
        return "$task/pray.png";
      case TaskType.FLUTTER:
        return "$task/flutter.png";
      case TaskType.STUDY:
        return "$task/study.png";
      case TaskType.SPRING:
        return "$task/spring.png";
      case TaskType.WORKOUT:
        return "$task/workout.png";
      case TaskType.FOOD:
        return "$task/food.png";
      default:
        return "$task/study.png";
    }
  }

  static String getTaskImageFromString(String group) {
    return getTaskImageFromTaskType(fromString(group)).toString();
  }
}
