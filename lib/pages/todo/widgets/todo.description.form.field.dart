import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/todo.dart';
import '../../../state/task.dart';
import '../../../state/task.notifier.dart';
import '../../../theme/colors.dart';

class TodoDescriptionFormField extends ConsumerWidget {
  final StateNotifierProvider<TaskNotifier, List<Task>> taskProvider;
  final Todo todo;

  const TodoDescriptionFormField(
      {required this.taskProvider, required this.todo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tasks = ref.watch(taskProvider);
    Task task = tasks.where((e) => e.fieldName == "description").first;

    return TextFormField(
      textInputAction: TextInputAction.done,
      minLines: 6,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        hintText: "Description here",
        hintStyle: TextStyle(fontFamily: "Cerebri Sans", color: inactiveButton),
        alignLabelWithHint: true,
        border: InputBorder.none,
      ),
      onSaved: (newValue) {
        todo.description = newValue;
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
