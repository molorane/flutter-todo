import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dto/todo.dto.dart';
import '../../../state/task.dart';
import '../../../state/task.notifier.dart';

class TodoDescriptionFormField extends ConsumerWidget {
  final StateNotifierProvider<TaskNotifier, List<Task>> taskProvider;
  final TodoDTO todoDTO;

  const TodoDescriptionFormField({required this.taskProvider, required this.todoDTO, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tasks = ref.watch(taskProvider);
    Task task = tasks.where((e) => e.fieldName == "description").first;

    return TextFormField(
      minLines: 6,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        alignLabelWithHint: true,
        border: InputBorder.none,
      ),
      onSaved: (newValue) {
        todoDTO.description = newValue;
        ref.read(taskProvider.notifier).changed(task.id, newValue);
      },
      initialValue: task.value ?? '',
      validator: (description) {
        if (description!.isEmpty) {
          return "Please enter description";
        }
        return null;
      },
    );
  }
}
