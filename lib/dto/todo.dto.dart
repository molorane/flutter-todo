import 'package:todo/models/todo.type.dart';

class TodoDTO {
  int? id;
  TodoType? todoType;
  String? title;
  bool? completed;
  String? dueDate;
  String? description;
  bool? deleted;

  TodoDTO(
      {this.id,
      this.todoType,
      this.title,
      this.completed,
      this.dueDate,
      this.description});

  @override
  String toString() {
    return '[$id , $title, $completed, $description]';
  }
}
