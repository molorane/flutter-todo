import 'package:todo/models/todo.type.dart';

class Todo {
  int? id;
  TodoType todoType;
  String title;
  bool completed;
  String dueDate;
  String? description;
  String? createdDate;
  bool? deleted;

  Todo({
    this.id,
    required this.todoType,
    required this.title,
    required this.completed,
    required this.dueDate,
    this.description,
    this.createdDate,
    this.deleted,
  });

  @override
  String toString() {
    return '[$id , $todoType, $title, $completed, $dueDate, $description, $createdDate, $deleted]';
  }
}
