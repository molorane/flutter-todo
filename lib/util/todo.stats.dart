import 'package:intl/intl.dart';

import '../openapi/lib/api.dart';

class TodoStats {
  List<TodoDTO>? todos = List.empty(growable: true);

  TodoStats({this.todos});

  int countAllTodos() {
    return todos!.length;
  }

  int countCompletedTodos() {
    return todos!.where((e) => e.completed!).length;
  }

  int countInProgressTodos() {
    return todos!.where((e) => !e.completed!).length;
  }

  int countCompletedTodosToday() {
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return todos!
        .where((e) => e.completed! && e.dueDate == formattedDate)
        .length;
  }

  double completedTodosPercentage() {
    return countCompletedTodos() / todos!.length;
  }

  int countTodosByType(TodoDTOTodoTypeEnum todoType) {
    return todos!.where((e) => e.todoType == todoType).length;
  }

  int countCompletedTodosByType(TodoDTOTodoTypeEnum todoType) {
    return todos!.where((e) => e.todoType == todoType && e.completed!).length;
  }

  Set<TodoDTOTodoTypeEnum> groupTodos() {
    Set<TodoDTOTodoTypeEnum> todoTypes = <TodoDTOTodoTypeEnum>{};

    for (var item in todos!) {
      todoTypes.add(item.todoType!);
    }

    return todoTypes;
  }
}
