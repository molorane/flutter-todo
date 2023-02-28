import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/theme/colors.dart';

import '../notifier/todo.state.dart';
import '../notifier/todo.state.notifier.dart';

class TodoCompleted extends ConsumerWidget {
  final StateNotifierProvider<TodoStateNotifier, TodoState> todoStateProvider;

  const TodoCompleted({required this.todoStateProvider, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var field = ref.watch(todoStateProvider);
    bool completed = field.isCompleted;

    return Checkbox(
      checkColor: Colors.greenAccent,
      activeColor: primary,
      value: completed,
      onChanged: (newValue) {
        ref.read(todoStateProvider.notifier).setIsCompleted(newValue!);
      },
    );
  }
}
