import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../openapi/lib/api.dart';
import '../../../state/task.dart';
import '../../../state/task.notifier.dart';

class TodoTypeDropdown extends ConsumerWidget {
  final StateNotifierProvider<TaskNotifier, List<Task>> tasksProvider;
  final TodoDTO todo;

  TodoTypeDropdown(
      {required this.tasksProvider, required this.todo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tasks = ref.watch(tasksProvider);
    Task todoType = tasks.where((e) => e.fieldName == "todoType").first;

    return DropdownButtonFormField<String>(
      isExpanded: true,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (newValue) {
        todo.todoType = TodoType.fromJson(newValue)!;
        ref.read(tasksProvider.notifier).changed(todoType.id, newValue, true);
      },
      value: todoType.value?.toString(),
      validator: (value) => value == null ? 'Select type' : null,
      hint: const Text('Select todo type'),
      items: TodoType.values.map<DropdownMenuItem<String>>((TodoType todoType) {
        return DropdownMenuItem<String>(
            value: todoType.value, child: Text(todoType.value));
      }).toList(),
    );
  }
}
