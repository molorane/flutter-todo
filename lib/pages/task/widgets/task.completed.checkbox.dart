import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/theme/colors.dart';

import '../notifier/task.state.dart';
import '../notifier/task.state.notifier.dart';

class TaskCompleted extends ConsumerWidget {
  final StateNotifierProvider<TaskStateNotifier, TaskState> taskStateProvider;

  const TaskCompleted({required this.taskStateProvider, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var field = ref.watch(taskStateProvider);
    bool completed = field.isCompleted;

    return Checkbox(
      checkColor: Colors.greenAccent,
      activeColor: primary,
      value: completed,
      onChanged: (newValue) {
        ref.read(taskStateProvider.notifier).setIsCompleted(newValue!);
      },
    );
  }
}
