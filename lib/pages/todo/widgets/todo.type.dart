import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/models/todo.type.dart';

import '../../../models/todo.dart';
import '../../../state/task.dart';
import '../../../state/task.notifier.dart';

class TodoTypeDropdown extends ConsumerWidget {
  final StateNotifierProvider<TaskNotifier, List<Task>> taskProvider;
  final Todo todo;

  const TodoTypeDropdown(
      {required this.taskProvider, required this.todo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tasks = ref.watch(taskProvider);
    Task task = tasks.where((e) => e.fieldName == "todoType").first;

    return DropdownButtonFormField<String>(
      isExpanded: true,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (newValue) {
        todo.todoType = TodoType.fromString(newValue!);
        ref.read(taskProvider.notifier).changed(task.id, newValue);
      },
      value: task.value?.toString(),
      validator: (value) => value == null ? 'Please select type' : null,
      hint: const Text('Please choose todo type'),
      items: TodoType.values.map<DropdownMenuItem<String>>((TodoType value) {
        return DropdownMenuItem<String>(
            value: value.displayValue, child: Text(value.displayValue));
      }).toList(),
    );
  }
}
