import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/add.todo.page.dart';

class TodoDescriptionFormField extends ConsumerWidget {
  final StateNotifierProvider<TaskNotifier, List<Task>> taskProvider;

  const TodoDescriptionFormField(this.taskProvider, {Key? key})
      : super(key: key);

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
      onChanged: (newValue) {
        ref.read(taskProvider.notifier).changed(task.id, newValue);
      },
      initialValue: task.value,
      validator: (description) {
        if (description!.isEmpty) {
          return "Please enter description";
        }
        return null;
      },
      onSaved: (String? value) {},
    );
  }
}
