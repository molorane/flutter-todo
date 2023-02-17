import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../openapi/lib/api.dart';
import '../../../state/task.dart';
import '../../../state/task.notifier.dart';

class TodoTypeDropdown extends ConsumerWidget {
  final StateNotifierProvider<TaskNotifier, List<Task>> taskProvider;
  final TodoDTO todo;
  final TodoDTOTodoTypeEnumTypeTransformer transformer =
      TodoDTOTodoTypeEnumTypeTransformer();

  TodoTypeDropdown({required this.taskProvider, required this.todo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tasks = ref.watch(taskProvider);
    Task task = tasks.where((e) => e.fieldName == "todoType").first;

    return DropdownButtonFormField<String>(
      isExpanded: true,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (newValue) {
        todo.todoType = transformer.decode(newValue);
        ref.read(taskProvider.notifier).changed(task.id, newValue);
      },
      value: task.value?.toString(),
      validator: (value) => value == null ? 'Please select type' : null,
      hint: const Text('Please choose todo type'),
      items: TodoDTOTodoTypeEnum.values
          .map<DropdownMenuItem<String>>((TodoDTOTodoTypeEnum todoType) {
        return DropdownMenuItem<String>(
            value: todoType.value, child: Text(todoType.value));
      }).toList(),
    );
  }
}
