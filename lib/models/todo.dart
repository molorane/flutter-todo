import 'package:todo/models/todo.type.dart';

class Todo {
  int id;
  int userId;
  TodoType todoType;
  String title;
  bool completed;
  String dueDate;
  String? description;
  bool? deleted;

  Todo(
      {required this.id,
      required this.todoType,
      required this.userId,
      required this.title,
      required this.completed,
      required this.dueDate,
      this.description});

  @override
  String toString() {
    return '[$id , $userId , $title, $completed, $description]';
  }
}
