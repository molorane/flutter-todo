import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/colors.dart';
import '../notifier/task.state.dart';
import '../notifier/task.state.notifier.dart';

class TaskDescriptionFormField extends ConsumerWidget {
  final StateNotifierProvider<TaskStateNotifier, TaskState> taskStateProvider;

  const TaskDescriptionFormField({required this.taskStateProvider, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var field = ref.watch(taskStateProvider);
    String description = field.description;

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
        ref.read(taskStateProvider.notifier).setDescription(newValue!);
      },
      initialValue: description,
      validator: (description) {
        if (description!.isEmpty) {
          return "Please enter description";
        }
        return null;
      },
    );
  }
}
