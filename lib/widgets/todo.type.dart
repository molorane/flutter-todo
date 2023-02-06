import 'package:flutter/material.dart';
import 'package:todo/models/todo.type.dart';

class TodoTypeDropdown extends StatefulWidget {
  const TodoTypeDropdown({super.key});

  @override
  State<TodoTypeDropdown> createState() => _TodoTypeDropdownState();
}

class _TodoTypeDropdownState extends State<TodoTypeDropdown> {
  String? selectedTodoType;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedTodoType,
      isExpanded: true,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? value) {
        setState(() {
          selectedTodoType = value!;
        });
      },
      validator: (value) => value == null ? 'Please select type' : null,
      hint: const Text('Please choose todo type'),
      items: TodoType.values.map<DropdownMenuItem<String>>((TodoType value) {
        return DropdownMenuItem<String>(
          value: value.displayValue,
          child: Text(value.displayValue),
        );
      }).toList(),
    );
  }
}
