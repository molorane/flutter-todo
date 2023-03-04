import '../openapi/lib/api.dart';

class TaskTypeUtil {
  static TaskType fromString(String label) {
    return TaskType.values.firstWhere((v) => v.value == label.toUpperCase());
  }

  static String getTaskImageFromTaskType(TaskType taskType) {
    const String task = "assets/taskTypes";
    switch (taskType) {
      case TaskType.PREACH:
        return "$task/preach.jpeg";
      case TaskType.PRAYER:
        return "$task/prayer.png";
      case TaskType.FLUTTER:
        return "$task/flutter.png";
      case TaskType.STUDY:
        return "$task/study.jpeg";
      case TaskType.SPRING:
        return "$task/spring.png";
      case TaskType.GYM:
        return "$task/gym.png";
      case TaskType.FOOD:
        return "$task/food.jpeg";
      default:
        return "$task/study.jpeg";
    }
  }

  static String getTaskImageFromString(String group) {
    return getTaskImageFromTaskType(fromString(group)).toString();
  }
}
