import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/theme/colors.dart';

import '../../../openapi/lib/api.dart';
import '../../../state/todo.dart';
import '../../../state/todo.notifier.dart';

class TodoCompleted extends ConsumerWidget {
  final StateNotifierProvider<TodoNotifier, List<Todo>> tasksProvider;
  final TodoDTO todo;

  const TodoCompleted(
      {required this.tasksProvider, required this.todo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tasks = ref.watch(tasksProvider);
    Todo completed = tasks.where((e) => e.fieldName == "isCompleted").first;

    return Checkbox(
      checkColor: Colors.greenAccent,
      activeColor: primary,
      value: completed.value,
      onChanged: (newValue) {
        todo.isCompleted = newValue!;
        ref.read(tasksProvider.notifier).changed(completed.id, newValue, true);
      },
    );
  }
}
