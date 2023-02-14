enum TodoType {
  prayer('PRAYER'),
  gym('GYM'),
  evangelism('EVANGELISM'),
  flutter('FLUTTER'),
  spring('SPRING'),
  study('STUDY'),
  food('FOOD'),
  entertainment('ENTERTAINMENT');

  final String displayValue; // define a private field

  const TodoType(this.displayValue); // constructor

  static TodoType fromString(String label) {
    // static parser method
    return values.firstWhere((v) => v.displayValue == label);
  }

  static String getTodoImage(TodoType todoType) {
    const String todo = "assets/todo_types";
    switch (todoType) {
      case TodoType.evangelism:
        return "$todo/evangelism.png";
      case TodoType.prayer:
        return "$todo/prayer.png";
      case TodoType.flutter:
        return "$todo/flutter.png";
      case TodoType.study:
        return "$todo/study.jpeg";
      case TodoType.spring:
        return "$todo/spring.png";
      case TodoType.gym:
        return "$todo/gym.png";
      case TodoType.food:
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
