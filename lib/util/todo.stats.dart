import '../openapi/lib/api.dart';

class TodoStats {
  final List<TodoGroupCount> todoGroupCount;
  final List<TodoCountToday> todoCountToday;
  final int deletedCount;

  const TodoStats(
      {this.todoGroupCount = const [],
      this.todoCountToday = const [],
      this.deletedCount = 0});

  int countAllTodos() {
    return safeReduce(todoGroupCount.map((e) => e.totalTodos).toList(),
        (value, element) => value + element);
  }

  int safeReduce(List<int> list, Function function) {
    if (list.isEmpty) return 0;
    return list.reduce((v, e) => function(v, e));
  }

  int countCompletedTodos() {
    final List<TodoGroupCount> countCompletedTodos =
        todoGroupCount.where((element) => element.isCompleted).toList();

    return safeReduce(countCompletedTodos.map((e) => e.totalTodos).toList(),
        (value, element) => value + element);
  }

  int countInProgressTodos() {
    final List<TodoGroupCount> countInProgressTodos =
        todoGroupCount.where((element) => !element.isCompleted).toList();

    return safeReduce(countInProgressTodos.map((e) => e.totalTodos).toList(),
        (value, element) => value + element);
  }

  int countCompletedTodosToday() {
    final List<TodoCountToday> countCompletedTodosToday =
        todoCountToday.where((element) => element.isCompleted).toList();

    return safeReduce(countCompletedTodosToday.map((e) => e.totalTodos).toList(),
        (value, element) => value + element);
  }

  int countTodosForToday() {
    return safeReduce(todoCountToday.map((e) => e.totalTodos).toList(),
        (value, element) => value + element);
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

    return safeReduce(countTodosByType.map((e) => e.totalTodos).toList(),
        (value, element) => value + element);
  }

  int countCompletedTodosByType(TodoType todoType) {
    final List<TodoGroupCount> countCompletedTodosByType = todoGroupCount
        .where((e) => e.todoType == todoType && e.isCompleted)
        .toList();

    return safeReduce(countCompletedTodosByType.map((e) => e.totalTodos).toList(),
        (value, element) => value + element);
  }

  int countInProgressTodosByType(TodoType todoType) {
    final List<TodoGroupCount> countInProgressTodosByType = todoGroupCount
        .where((e) => e.todoType == todoType && !e.isCompleted)
        .toList();

    return safeReduce(countInProgressTodosByType.map((e) => e.totalTodos).toList(),
        (value, element) => value + element);
  }

  Set<TodoType> groupTodos() {
    Set<TodoType> todoTypes = <TodoType>{};
    for (var item in todoGroupCount) {
      todoTypes.add(item.todoType!);
    }
    return todoTypes;
  }
}
