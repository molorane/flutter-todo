import '../models/todo.dart';
import '../models/todo.type.stats.dart';

class TodoStats {
  List<Todo>? todos = List.empty(growable: true);

  TodoStats({this.todos});

  int countAllTodos() {
    return todos!.length;
  }

  int countCompletedTodos() {
    return todos!.where((e) => e.completed == true).length;
  }

  double completedTodosPercentage() {
    return countCompletedTodos() / todos!.length;
  }

  List<TodoTypeStats> groupTodos() {
    Map<String, int> maps = <String, int>{};

    todos!.forEach((item) {
      var count = maps[item.todoType.toString()];
      if (count != null) {
        maps.update(item.todoType.toString(), (value) => value + 1);
      } else {
        maps.addEntries({item.todoType.toString(): 1}.entries);
      }
    });

    List<TodoTypeStats> list = List.empty(growable: true);
    maps.forEach((key, value) {
      list.add(TodoTypeStats(key, value));
    });
    return list;
  }
}
