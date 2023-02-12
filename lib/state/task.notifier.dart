import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/state/task.dart';

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier({tasks}) : super(tasks);

  void add(Task task) {
    state = [...state, task];
  }

  void changed(int taskId, dynamic newValue) {
    state = [
      for (final item in state)
        if (taskId == item.id) item.copyWith(value: newValue) else item
    ];

    for (final item in state) print(state);
    print('$taskId $newValue in changed');
  }
}
