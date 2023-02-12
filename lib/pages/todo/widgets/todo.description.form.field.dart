import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../state/task.dart';
import '../../../state/task.notifier.dart';

class TodoDescriptionFormField extends ConsumerWidget {
  final StateNotifierProvider<TaskNotifier, List<Task>> taskProvider;

  const TodoDescriptionFormField({required this.taskProvider, super.key});

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
