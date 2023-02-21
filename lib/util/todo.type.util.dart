import '../openapi/lib/api.dart';

class TodoTypeUtil {
  static TodoDTOTodoTypeEnum fromString(String label) {
    return TodoDTOTodoTypeEnum.values
        .firstWhere((v) => v.value == label.toUpperCase());
  }

  static String getTodoImageFromTodoType(TodoDTOTodoTypeEnum todoType) {
    const String todo = "assets/todo_types";
    switch (todoType) {
      case TodoDTOTodoTypeEnum.PREACH:
        return "$todo/preach.jpeg";
      case TodoDTOTodoTypeEnum.PRAYER:
        return "$todo/prayer.png";
      case TodoDTOTodoTypeEnum.FLUTTER:
        return "$todo/flutter.png";
      case TodoDTOTodoTypeEnum.STUDY:
        return "$todo/study.jpeg";
      case TodoDTOTodoTypeEnum.SPRING:
        return "$todo/spring.png";
      case TodoDTOTodoTypeEnum.GYM:
        return "$todo/gym.png";
      case TodoDTOTodoTypeEnum.FOOD:
        return "$todo/food.jpeg";
      default:
        return "$todo/study.jpeg";
    }
  }

  static String getTodoImageFromString(String group) {
    TodoDTOTodoTypeEnum todoType = fromString(group);
    return getTodoImageFromTodoType(todoType).toString();
  }
}
