import '../openapi/lib/api.dart';

class TodoStats {
  final List<TodoGroupCount> todoGroupCount;
  final int completedToday;
  final int todosToday;
  final int deletedCount;

  const TodoStats(
      {this.todoGroupCount = const [],
      this.completedToday = 0,
      this.todosToday = 0,
      this.deletedCount = 0});

  int countAllTodos() {
    return todoGroupCount
        .map((e) => e.totalTodos)
        .reduce((value, element) => value + element);
  }

  int countCompletedTodos() {
    final List<TodoGroupCount> countCompletedTodos =
        todoGroupCount.where((element) => element.isCompleted).toList();

    return countCompletedTodos
        .map((e) => e.totalTodos)
        .reduce((value, element) => value + element);
  }

  int countInProgressTodos() {
    final List<TodoGroupCount> countInProgressTodos =
        todoGroupCount.where((element) => !element.isCompleted).toList();

    return countInProgressTodos
        .map((e) => e.totalTodos)
        .reduce((value, element) => value + element);
  }

  int countCompletedTodosToday() {
    return completedToday;
  }

  int countTodosForToday() {
    return todosToday;
  }

  double completedTodosPercentage() {
    int completed = countCompletedTodos();
    if (completed == 0) return 0;
    return countCompletedTodos() / countAllTodos();
  }

  int countTodosByType(TodoType todoType) {
    final List<TodoGroupCount> countTodosByType = todoGroupCount
        .where((element) => element.todoType == todoType)
        .toList();

    if (countTodosByType.isEmpty) return 0;

    return countTodosByType
        .map((e) => e.totalTodos)
        .reduce((value, element) => value + element);
  }

  int countCompletedTodosByType(TodoType todoType) {
    final List<TodoGroupCount> countCompletedTodosByType = todoGroupCount
        .where((e) => e.todoType == todoType && e.isCompleted)
        .toList();

    if (countCompletedTodosByType.isEmpty) return 0;

    return countCompletedTodosByType
        .map((e) => e.totalTodos)
        .reduce((value, element) => value + element);
  }

  int countInProgressTodosByType(TodoType todoType) {
    final List<TodoGroupCount> countInProgressTodosByType = todoGroupCount
        .where((e) => e.todoType == todoType && !e.isCompleted)
        .toList();
    return countInProgressTodosByType
        .map((e) => e.totalTodos)
        .reduce((value, element) => value + element);
  }

  List<TodoDTO> getTodosByType(TodoType todoType) {
    return [];
  }

  List<TodoDTO> getTodosForToday() {
    return [];
  }

  List<TodoDTO> getTodosForTodayByType(TodoType todoType) {
    return [];
  }

  List<TodoDTO> getCompletedTodosForTodayByType(TodoType todoType) {
    return [];
  }

  int countTodosForTodayByType(TodoType todoType) {
    return 0;
  }

  int countCompletedTodosForTodayByType(TodoType todoType) {
    return getCompletedTodosForTodayByType(todoType).length;
  }

  Set<TodoType> groupTodos() {
    Set<TodoType> todoTypes = <TodoType>{};

    for (var item in todoGroupCount) {
      todoTypes.add(item.todoType!);
    }

    return todoTypes;
  }
}
