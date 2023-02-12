import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../dto/todo.dto.dart';
import '../../../state/task.dart';
import '../../../state/task.notifier.dart';

class TodoDate extends ConsumerWidget {
  final StateNotifierProvider<TaskNotifier, List<Task>> taskProvider;
  final TodoDTO todoDTO;
  final TextEditingController dateInput = TextEditingController();

  TodoDate({required this.taskProvider, required this.todoDTO, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tasks = ref.watch(taskProvider);
    Task task = tasks.where((e) => e.fieldName == "dueDate").first;

    if(task.value != null) {
      dateInput.text = task.value;
    }

    return TextFormField(
        controller: dateInput,
        //editing controller of this TextField
        decoration: const InputDecoration(
            icon: Icon(Icons.calendar_today), //icon of text field
            labelText: "Enter Date",
            border: InputBorder.none //label text of field
            ),
        readOnly: true,
        //set it true, so that user will not able to edit text
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100));

          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            dateInput.text = formattedDate;
            todoDTO.dueDate = formattedDate;
            ref.read(taskProvider.notifier).changed(task.id, formattedDate);
          }
        },
        validator: (description) {
          if (description!.isEmpty) {
            return "Please enter description";
          }
          return null;
        },
        onSaved: (String? value) {});
  }
}
