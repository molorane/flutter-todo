import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../openapi/lib/api.dart';
import '../../../state/task.dart';
import '../../../state/task.notifier.dart';
import '../../../theme/colors.dart';

class TodoDescriptionFormField extends ConsumerWidget {
  final StateNotifierProvider<TaskNotifier, List<Task>> tasksProvider;
  final TodoDTO todo;

  const TodoDescriptionFormField(
      {required this.tasksProvider, required this.todo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tasks = ref.watch(tasksProvider);
    Task description = tasks.where((e) => e.fieldName == "description").first;

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
        ref
            .read(tasksProvider.notifier)
            .changed(description.id, newValue, true);
      },
      initialValue: description.value ?? '',
      validator: (description) {
        if (description!.isEmpty) {
          return "Please enter description";
        }
        return null;
      },
    );
  }
}
