import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/colors.dart';
import '../notifier/task.state.dart';
import '../notifier/task.state.notifier.dart';

class TaskTextFormField extends ConsumerWidget {
  final StateNotifierProvider<TaskStateNotifier, TaskState> taskStateProvider;

  const TaskTextFormField({required this.taskStateProvider, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var field = ref.watch(taskStateProvider);
    String description = field.description;

    return TextFormField(
        cursorColor: Colors.black87,
        decoration: const InputDecoration(
            hintText: "Description here",
            hintStyle:
                TextStyle(fontFamily: "Cerebri Sans", color: inactiveButton),
            border: InputBorder.none),
        onSaved: (newValue) {
          ref.read(taskStateProvider.notifier).setDescription(newValue!);
        },
        initialValue: description,
        validator: (title) {
          if (title!.isEmpty) {
            return "Please enter title";
          }
          return null;
        });
  }
}
