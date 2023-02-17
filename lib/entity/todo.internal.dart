import 'package:todo/entity/todo.type.internal.dart';

class TodoInternal {
  int? id;
  TodoTypeInternal todoType;
  String? title;
  bool completed;
  String? dueDate;
  String? description;
  String? createdDate;
  bool deleted;

  TodoInternal(
      {this.id,
      this.todoType = TodoTypeInternal.study,
      this.title,
      this.completed = false,
      this.dueDate,
      this.description,
      this.createdDate,
      this.deleted = false});

  factory TodoInternal.fromJson(Map<String, dynamic> json) {
    return TodoInternal(
      id: json['id'],
      todoType: TodoTypeInternal.fromString(json['todoType']),
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
      'completed': completed.toString(),
      'dueDate': dueDate,
      'description': description,
      'createdDate': createdDate,
      'deleted': deleted.toString()
    };
  }

  @override
  String toString() {
    return '[$id , $todoType, $title, $completed, $dueDate, $description, $createdDate, $deleted]';
  }
}
