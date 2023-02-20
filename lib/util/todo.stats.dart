import 'package:intl/intl.dart';

import '../openapi/lib/api.dart';

class TodoStats {
  List<TodoDTO>? todos = List.empty(growable: true);

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

  String getStringDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  int countCompletedTodosToday() {
    String formattedDateToday = getStringDate(DateTime.now());
    return todos!
        .where((e) =>
            e.completed && getStringDate(e.dueDate!) == formattedDateToday)
        .length;
  }

  int countTodosForToday() {
    String formattedDateToday = getStringDate(DateTime.now());
    return todos!.where((e) => getStringDate(e.dueDate!) == formattedDateToday).length;
  }

  double completedTodosPercentage() {
    return countCompletedTodos() / todos!.length;
  }

  int countTodosByType(TodoDTOTodoTypeEnum todoType) {
    return todos!.where((e) => e.todoType == todoType).length;
  }

  int countCompletedTodosByType(TodoDTOTodoTypeEnum todoType) {
    return todos!.where((e) => e.todoType == todoType && e.completed).length;
  }

  int countInProgressTodosByType(TodoDTOTodoTypeEnum todoType) {
    return todos!.where((e) => e.todoType == todoType && !e.completed).length;
  }

  List<TodoDTO> getTodosByType(TodoDTOTodoTypeEnum todoType) {
    return todos!.where((e) => e.todoType == todoType).toList();
  }

  List<TodoDTO> getTodosForToday() {
    String formattedDateToday = getStringDate(DateTime.now());
    return todos!.where((e) => getStringDate(e.dueDate!) == formattedDateToday).toList();
  }

  List<TodoDTO> getTodosForTodayByType(TodoDTOTodoTypeEnum todoType) {
    String formattedDateToday = getStringDate(DateTime.now());
    return todos!.where((e) => e.todoType == todoType && getStringDate(e.dueDate!) == formattedDateToday).toList();
  }

  List<TodoDTO> getCompletedTodosForTodayByType(TodoDTOTodoTypeEnum todoType) {
    String formattedDateToday = getStringDate(DateTime.now());
    return todos!.where((e) => e.completed && e.todoType == todoType && getStringDate(e.dueDate!) == formattedDateToday).toList();
  }

  int countTodosForTodayByType(TodoDTOTodoTypeEnum todoType) {
    return getTodosForTodayByType(todoType).length;
  }

  int countCompletedTodosForTodayByType(TodoDTOTodoTypeEnum todoType) {
    return getCompletedTodosForTodayByType(todoType).length;
  }

  Set<TodoDTOTodoTypeEnum> groupTodos() {
    Set<TodoDTOTodoTypeEnum> todoTypes = <TodoDTOTodoTypeEnum>{};

    for (var item in todos!) {
      todoTypes.add(item.todoType);
    }

    return todoTypes;
  }
}
