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
    Task task = tasks.where((e) => e.fieldName == "completed").first;
    print(task.value);
    return Checkbox(
      checkColor: Colors.greenAccent,
      activeColor: primary,
      value: task.value,
      onChanged: (newValue) {
        print('${task.id} $newValue in onChange');
        ref.read(taskProvider.notifier).changed(task.id, newValue);
      },
    );
  }
}
