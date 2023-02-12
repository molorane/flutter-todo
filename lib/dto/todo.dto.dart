import 'package:todo/models/todo.type.dart';

class TodoDTO {
  int? id;
  TodoType? todoType;
  String? title;
  bool? completed;
  String? dueDate;
  String? description;
  String? createdDate;
  bool? deleted;

  TodoDTO(
      {this.id,
      this.todoType,
      this.title,
      this.completed,
      this.dueDate,
      this.description,
      this.createdDate,
      this.deleted});

  factory TodoDTO.fromJson(Map<String, dynamic> json) {
    return TodoDTO(
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

  Map<String, dynamic> toJson() {
    return {
      'id': id?.toString(),
      'todoType': todoType.toString(),
      'title': title,
      'completed': completed?.toString(),
      'dueDate': dueDate,
      'description': description,
      'createdDate': createdDate,
      'deleted': deleted?.toString()
    };
  }

  @override
  String toString() {
    return '[$id, $todoType, $title, $completed, $description]';
  }
}
