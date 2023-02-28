import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/colors.dart';
import '../notifier/todo.state.dart';
import '../notifier/todo.state.notifier.dart';

class TodoDescriptionFormField extends ConsumerWidget {
  final StateNotifierProvider<TodoStateNotifier, TodoState> todoStateProvider;

  const TodoDescriptionFormField({required this.todoStateProvider, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var field = ref.watch(todoStateProvider);
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
        ref.read(todoStateProvider.notifier).setDescription(newValue!);
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
