import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/colors.dart';
import '../notifier/todo.state.dart';
import '../notifier/todo.state.notifier.dart';

class TodoTextFormField extends ConsumerWidget {
  final StateNotifierProvider<TodoStateNotifier, TodoState> todoStateProvider;

  const TodoTextFormField({required this.todoStateProvider, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var field = ref.watch(todoStateProvider);
    String description = field.description;

    return TextFormField(
        cursorColor: Colors.black87,
        decoration: const InputDecoration(
            hintText: "Description here",
            hintStyle:
                TextStyle(fontFamily: "Cerebri Sans", color: inactiveButton),
            border: InputBorder.none),
        onSaved: (newValue) {
          ref.read(todoStateProvider.notifier).setDescription(newValue!);
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
