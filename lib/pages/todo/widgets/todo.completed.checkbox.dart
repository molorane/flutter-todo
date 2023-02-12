import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/theme/colors.dart';

import '../../../dto/todo.dto.dart';
import '../../../state/task.dart';
import '../../../state/task.notifier.dart';

class TodoCompleted extends ConsumerWidget {
  final StateNotifierProvider<TaskNotifier, List<Task>> taskProvider;
  final TodoDTO todoDTO;

  const TodoCompleted({required this.taskProvider, required this.todoDTO, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tasks = ref.watch(taskProvider);
    Task task = tasks.where((e) => e.fieldName == "completed").first;

    return Checkbox(
      checkColor: Colors.greenAccent,
      activeColor: primary,
      value: task.value,
      onChanged: (newValue) {
        todoDTO.completed = newValue;
        ref.read(taskProvider.notifier).changed(task.id, newValue);
      },
    );
  }
}
