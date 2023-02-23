import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/state/todo.state.dart';

class TodoNotifier extends StateNotifier<List<TodoState>> {
  TodoNotifier({tasks}) : super(tasks);

  void add(TodoState task) {
    state = [...state, task];
  }

  void changed(int taskId, dynamic newValue, bool changed) {
    state = [
      for (final item in state)
        if (taskId == item.id)
          item.copyWith(value: newValue, changed: changed)
        else
          item.copyWith()
    ];
  }
}
