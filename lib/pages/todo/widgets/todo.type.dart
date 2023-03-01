import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../openapi/lib/api.dart';
import '../notifier/todo.state.dart';
import '../notifier/todo.state.notifier.dart';

class TodoTypeDropdown extends ConsumerWidget {
  final StateNotifierProvider<TodoStateNotifier, TodoState> todoStateProvider;

  TodoTypeDropdown({required this.todoStateProvider, super.key});

  String? getTodoType(TodoType? todoType) {
    if (todoType == null) return null;

    return todoType.toString();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var provider = ref.watch(todoStateProvider);
    TodoType? todoType = provider.todoType;

    return DropdownButtonFormField<String>(
      isExpanded: true,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (newValue) {
        TodoType value = TodoType.fromJson(newValue)!;
        ref.read(todoStateProvider.notifier).setTodoType(value);
      },
      value: getTodoType(todoType),
      validator: (value) => value == null ? 'Select type' : null,
      hint: const Text('Select todo type'),
      items: TodoType.values.map<DropdownMenuItem<String>>((TodoType todoType) {
        //print(todoType);
        return DropdownMenuItem<String>(
            value: todoType.value, child: Text(todoType.value));
      }).toList(),
    );
  }
}
