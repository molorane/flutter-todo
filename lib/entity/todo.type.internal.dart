enum TodoTypeInternal {
  prayer('PRAYER'),
  gym('GYM'),
  preach('PREACH'),
  flutter('FLUTTER'),
  spring('SPRING'),
  study('STUDY'),
  food('FOOD'),
  entertainment('ENTERTAINMENT');

  final String displayValue; // define a private field

  const TodoTypeInternal(this.displayValue); // constructor

  static TodoTypeInternal fromString(String label) {
    // static parser method
    return values.firstWhere((v) => v.displayValue == label.toUpperCase());
  }

  static String getTodoImageFromTodoType(TodoTypeInternal todoType) {
    const String todo = "assets/todo_types";
    switch (todoType) {
      case TodoTypeInternal.preach:
        return "$todo/preach.jpeg";
      case TodoTypeInternal.prayer:
        return "$todo/prayer.png";
      case TodoTypeInternal.flutter:
        return "$todo/flutter.png";
      case TodoTypeInternal.study:
        return "$todo/study.jpeg";
      case TodoTypeInternal.spring:
        return "$todo/spring.png";
      case TodoTypeInternal.gym:
        return "$todo/gym.png";
      case TodoTypeInternal.food:
        return "$todo/food.jpeg";
      default:
        return "$todo/study.jpeg";
    }
  }

  static String getTodoImageFromString(String group) {
    const String todo = "assets/todo_types";
    TodoTypeInternal todoType = fromString(group);
    switch (todoType) {
      case TodoTypeInternal.preach:
        return "$todo/preach.jpeg";
      case TodoTypeInternal.prayer:
        return "$todo/prayer.png";
      case TodoTypeInternal.flutter:
        return "$todo/flutter.png";
      case TodoTypeInternal.study:
        return "$todo/study.jpeg";
      case TodoTypeInternal.spring:
        return "$todo/spring.png";
      case TodoTypeInternal.gym:
        return "$todo/gym.png";
      case TodoTypeInternal.food:
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
