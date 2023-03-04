enum TaskTypeInternal {
  prayer('PRAYER'),
  gym('GYM'),
  preach('PREACH'),
  flutter('FLUTTER'),
  spring('SPRING'),
  study('STUDY'),
  food('FOOD'),
  entertainment('ENTERTAINMENT');

  final String displayValue; // define a private field

  const TaskTypeInternal(this.displayValue); // constructor

  static TaskTypeInternal fromString(String label) {
    // static parser method
    return values.firstWhere((v) => v.displayValue == label.toUpperCase());
  }

  static String getTaskImageFromTaskType(TaskTypeInternal todoType) {
    const String todo = "assets/todo_types";
    switch (todoType) {
      case TaskTypeInternal.preach:
        return "$todo/preach.jpeg";
      case TaskTypeInternal.prayer:
        return "$todo/prayer.png";
      case TaskTypeInternal.flutter:
        return "$todo/flutter.png";
      case TaskTypeInternal.study:
        return "$todo/study.jpeg";
      case TaskTypeInternal.spring:
        return "$todo/spring.png";
      case TaskTypeInternal.gym:
        return "$todo/gym.png";
      case TaskTypeInternal.food:
        return "$todo/food.jpeg";
      default:
        return "$todo/study.jpeg";
    }
  }

  static String getTaskImageFromString(String group) {
    const String todo = "assets/todo_types";
    TaskTypeInternal todoType = fromString(group);
    switch (todoType) {
      case TaskTypeInternal.preach:
        return "$todo/preach.jpeg";
      case TaskTypeInternal.prayer:
        return "$todo/prayer.png";
      case TaskTypeInternal.flutter:
        return "$todo/flutter.png";
      case TaskTypeInternal.study:
        return "$todo/study.jpeg";
      case TaskTypeInternal.spring:
        return "$todo/spring.png";
      case TaskTypeInternal.gym:
        return "$todo/gym.png";
      case TaskTypeInternal.food:
        return "$todo/food.jpeg";
      default:
        return "$todo/study.jpeg";
    }
  }

  @override
  String toString() {
    return displayValue.toUpperCase();
  }
}
