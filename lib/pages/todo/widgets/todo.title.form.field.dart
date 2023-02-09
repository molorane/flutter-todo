import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../state/task.dart';
import '../../../state/task.notifier.dart';
import '../../../theme/colors.dart';

class TodoTitleFormField extends ConsumerWidget {
  final StateNotifierProvider<TaskNotifier, List<Task>> taskProvider;
  final String? initValue;

  const TodoTitleFormField(
      {required this.taskProvider, this.initValue, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tasks = ref.watch(taskProvider);
    Task task = tasks.where((e) => e.fieldName == "title").first;

    return TextFormField(
        cursorColor: Colors.black87,
        decoration: const InputDecoration(
            hintText: "Title here",
            hintStyle:
                TextStyle(fontFamily: "Cerebri Sans", color: inactiveButton),
            border: InputBorder.none),
        onSaved: (newValue) {
          ref.read(taskProvider.notifier).changed(task.id, newValue);
        },
        initialValue: initValue ?? task.value,
        validator: (title) {
          if (title!.isEmpty) {
            return "Please enter title";
          }
          return null;
        });
  }
}
