import 'package:intl/intl.dart';
import 'package:todo/models/todo.type.dart';

import '../models/todo.dart';

class TodoStats {
  List<Todo>? todos = List.empty(growable: true);

  TodoStats({this.todos});

  int countAllTodos() {
    return todos!.length;
  }

  int countCompletedTodos() {
    return todos!.where((e) => e.completed).length;
  }

  int countInProgressTodos() {
    return todos!.where((e) => !e.completed).length;
  }

  int countCompletedTodosToday() {
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return todos!
        .where((e) => e.completed && e.dueDate == formattedDate)
        .length;
  }

  double completedTodosPercentage() {
    return countCompletedTodos() / todos!.length;
  }

  int countTodosByType(TodoType todoType) {
    return todos!.where((e) => e.todoType == todoType).length;
  }

  int countCompletedTodosByType(TodoType todoType) {
    return todos!.where((e) => e.todoType == todoType && e.completed).length;
  }

  Set<TodoType> groupTodos() {
    Set<TodoType> todoTypes = <TodoType>{};

    for (var item in todos!) {
      todoTypes.add(item.todoType);
    }

    return todoTypes;
  }
}
