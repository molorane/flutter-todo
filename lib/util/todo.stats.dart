
import '../models/todo.dart';

class TodoStats {

  List<Todo>? todos = List.empty(growable: true);

  TodoStats({this.todos});

  int countAllTodos() {
    return todos!.length;
  }

}