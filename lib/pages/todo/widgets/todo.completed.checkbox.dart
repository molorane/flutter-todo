import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/theme/colors.dart';

import '../../../state/task.dart';
import '../../../state/task.notifier.dart';

class TodoCompleted extends ConsumerWidget {
  final StateNotifierProvider<TaskNotifier, List<Task>> taskProvider;

  const TodoCompleted({required this.taskProvider, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tasks = ref.watch(taskProvider);
    print(tasks);
    Task task = tasks.where((e) => e.fieldName == "completed").first;

    return Checkbox(
      checkColor: Colors.greenAccent,
      activeColor: primary,
      value: task.value,
      onChanged: (newValue) {
        ref.read(taskProvider.notifier).changed(task.id, newValue);
      },
    );
  }
}
