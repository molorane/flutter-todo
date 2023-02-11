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

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      todoType: TodoType.fromString(json['todoType']),
      title: json['title'],
      completed: json['completed'],
      dueDate: json['dueDate'],
      description: json['description'],
      createdDate: json['createdDate'],
      deleted: json['deleted'],
    );
  }

  @override
  String toString() {
    return '[$id , $todoType, $title, $completed, $dueDate, $description, $createdDate, $deleted]';
  }
}
