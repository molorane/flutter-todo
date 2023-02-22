import '../openapi/lib/api.dart';
import 'date.util.dart';

class TodoStats {
  List<TodoDTO>? todos = List.empty(growable: true);

  TodoStats({this.todos});

  int countAllTodos() {
    return todos!.length;
  }

  int countCompletedTodos() {
    return todos!.where((e) => e.isCompleted).length;
  }

  int countInProgressTodos() {
    return todos!.where((e) => !e.isCompleted).length;
  }

  int countCompletedTodosToday() {
    String formattedDateToday = DateUtil.getStringFormattedDate(DateTime.now());
    return todos!
        .where((e) =>
            e.isCompleted &&
            DateUtil.getStringFormattedDate(e.dueDate!) == formattedDateToday)
        .length;
  }

  int countTodosForToday() {
    String formattedDateToday = DateUtil.getStringFormattedDate(DateTime.now());
    return todos!
        .where((e) =>
            DateUtil.getStringFormattedDate(e.dueDate!) == formattedDateToday)
        .length;
  }

  double completedTodosPercentage() {
    return countCompletedTodos() / todos!.length;
  }

  int countTodosByType(TodoType todoType) {
    return todos!.where((e) => e.todoType == todoType).length;
  }

  int countCompletedTodosByType(TodoType todoType) {
    return todos!.where((e) => e.todoType == todoType && e.isCompleted).length;
  }

  int countInProgressTodosByType(TodoType todoType) {
    return todos!.where((e) => e.todoType == todoType && !e.isCompleted).length;
  }

  List<TodoDTO> getTodosByType(TodoType todoType) {
    return todos!.where((e) => e.todoType == todoType).toList();
  }

  List<TodoDTO> getTodosForToday() {
    String formattedDateToday = DateUtil.getStringFormattedDate(DateTime.now());
    return todos!
        .where((e) =>
            DateUtil.getStringFormattedDate(e.dueDate!) == formattedDateToday)
        .toList();
  }

  List<TodoDTO> getTodosForTodayByType(TodoType todoType) {
    String formattedDateToday = DateUtil.getStringFormattedDate(DateTime.now());
    return todos!
        .where((e) =>
            e.todoType == todoType &&
            DateUtil.getStringFormattedDate(e.dueDate!) == formattedDateToday)
        .toList();
  }

  List<TodoDTO> getCompletedTodosForTodayByType(TodoType todoType) {
    String formattedDateToday = DateUtil.getStringFormattedDate(DateTime.now());
    return todos!
        .where((e) =>
            e.isCompleted &&
            e.todoType == todoType &&
            DateUtil.getStringFormattedDate(e.dueDate!) == formattedDateToday)
        .toList();
  }

  int countTodosForTodayByType(TodoType todoType) {
    return getTodosForTodayByType(todoType).length;
  }

  int countCompletedTodosForTodayByType(TodoType todoType) {
    return getCompletedTodosForTodayByType(todoType).length;
  }

  Set<TodoType> groupTodos() {
    Set<TodoType> todoTypes = <TodoType>{};

    for (var item in todos!) {
      todoTypes.add(item.todoType!);
    }

    return todoTypes;
  }
}
