import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_api/todo_api.dart';

import '../notifier/task.state.dart';
import '../notifier/task.state.notifier.dart';

class TaskTypeDropdown extends ConsumerWidget {
  final StateNotifierProvider<TaskStateNotifier, TaskState> taskStateProvider;

  TaskTypeDropdown({required this.taskStateProvider, super.key});

  String? getTaskType(TaskType? taskType) {
    if (taskType == null) return null;

    return taskType.toString();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var provider = ref.watch(taskStateProvider);
    TaskType? taskType = provider.taskType;

    return DropdownButtonFormField<String>(
      isExpanded: true,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (newValue) {
        TaskType value = TaskType.valueOf(newValue!);
        ref.read(taskStateProvider.notifier).setTaskType(value);
      },
      value: getTaskType(taskType),
      validator: (value) => value == null ? 'Select type' : null,
      hint: const Text('Select task type'),
      items: TaskType.values.map<DropdownMenuItem<String>>((TaskType taskType) {
        //print(taskType);
        return DropdownMenuItem<String>(
            value: taskType.name, child: Text(taskType.name));
      }).toList(),
    );
  }
}
