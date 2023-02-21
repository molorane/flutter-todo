import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/entity/todo.search.dart';

import '../../../state/task.dart';
import '../../../state/task.notifier.dart';
import '../../../theme/colors.dart';

class TodoTextFormField extends ConsumerWidget {
  final StateNotifierProvider<TaskNotifier, List<Task>> tasksProvider;
  final TodoSearch todo;

  const TodoTextFormField(
      {required this.tasksProvider, required this.todo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tasks = ref.watch(tasksProvider);
    Task task = tasks.where((e) => e.fieldName == "description").first;

    return TextFormField(
        cursorColor: Colors.black87,
        decoration: const InputDecoration(
            hintText: "Description here",
            hintStyle:
                TextStyle(fontFamily: "Cerebri Sans", color: inactiveButton),
            border: InputBorder.none),
        onSaved: (newValue) {
          todo.description = newValue;
          ref.read(tasksProvider.notifier).changed(task.id, newValue, true);
        },
        initialValue: task.value ?? '',
        validator: (title) {
          if (title!.isEmpty) {
            return "Please enter title";
          }
          return null;
        });
  }
}
