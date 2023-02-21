import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/theme/colors.dart';

import '../../../openapi/lib/api.dart';
import '../../../state/task.dart';
import '../../../state/task.notifier.dart';

class TodoCompleted extends ConsumerWidget {
  final StateNotifierProvider<TaskNotifier, List<Task>> tasksProvider;
  final TodoDTO todo;

  const TodoCompleted(
      {required this.tasksProvider, required this.todo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tasks = ref.watch(tasksProvider);
    Task completed = tasks.where((e) => e.fieldName == "completed").first;

    return Checkbox(
      checkColor: Colors.greenAccent,
      activeColor: primary,
      value: completed.value,
      onChanged: (newValue) {
        todo.completed = newValue!;
        ref.read(tasksProvider.notifier).changed(completed.id, newValue, true);
      },
    );
  }
}
