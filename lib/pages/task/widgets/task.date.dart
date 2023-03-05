import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_api/todo_api.dart';

import '../../../util/date.util.dart';
import '../notifier/task.state.dart';
import '../notifier/task.state.notifier.dart';

class TaskDate extends ConsumerWidget {
  final StateNotifierProvider<TaskStateNotifier, TaskState> taskStateProvider;
  final TextEditingController dateInput = TextEditingController();

  TaskDate({required this.taskStateProvider, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var field = ref.watch(taskStateProvider);
    Date? dueDate = field.dueDate;

    if (dueDate != null) {
      dateInput.text = DateUtil.getStringFormattedDate(dueDate);
    }

    return TextFormField(
        controller: dateInput,
        //editing controller of this TextField
        decoration: const InputDecoration(
            icon: Icon(Icons.calendar_today), //icon of text field
            labelText: "Select Date",
            border: InputBorder.none //label text of field
            ),
        readOnly: true,
        //set it true, so that user will not able to edit text
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
              selectableDayPredicate: (val) {
               return true; return val.weekday != 7;
              });

          if (pickedDate != null) {
            final String formattedDate =
                DateUtil.getStringFormattedDate(pickedDate.toDate());
            final DateTime dueDate = DateTime.parse(formattedDate);
            dateInput.text = formattedDate;
            ref.read(taskStateProvider.notifier).setDueDate(dueDate.toDate());
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
