import '../openapi/lib/api.dart';

class TodoTypeUtil {
  static TodoType fromString(String label) {
    return TodoType.values.firstWhere((v) => v.value == label.toUpperCase());
  }

  static String getTodoImageFromTodoType(TodoType todoType) {
    const String todo = "assets/todo_types";
    switch (todoType) {
      case TodoType.PREACH:
        return "$todo/preach.jpeg";
      case TodoType.PRAYER:
        return "$todo/prayer.png";
      case TodoType.FLUTTER:
        return "$todo/flutter.png";
      case TodoType.STUDY:
        return "$todo/study.jpeg";
      case TodoType.SPRING:
        return "$todo/spring.png";
      case TodoType.GYM:
        return "$todo/gym.png";
      case TodoType.FOOD:
        return "$todo/food.jpeg";
      default:
        return "$todo/study.jpeg";
    }
  }

  static String getTodoImageFromString(String group) {
    return getTodoImageFromTodoType(fromString(group)).toString();
  }
}
