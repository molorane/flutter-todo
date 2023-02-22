import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../entity/todo.search.dart';
import '../../../state/task.dart';
import '../../../state/task.notifier.dart';
import '../../../util/date.util.dart';

class TodoStartDate extends ConsumerWidget {
  final StateNotifierProvider<TaskNotifier, List<Task>> tasksProvider;
  final TodoSearch todo;
  TextEditingController dateInput = TextEditingController();

  TodoStartDate({required this.tasksProvider, required this.todo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tasks = ref.watch(tasksProvider);
    Task startDate = tasks.where((e) => e.fieldName == 'startDate').first;

    if (startDate.value != null) {
      dateInput = TextEditingController();
      dateInput.text = DateUtil.getStringFormattedDate(startDate.value);
    } else {
      dateInput = TextEditingController();
    }

    return TextFormField(
        controller: dateInput,
        //editing controller of this TextField
        decoration: const InputDecoration(
            icon: Icon(Icons.calendar_today), //icon of text field
            labelText: "Start Date",
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
                return val.weekday != 7;
              });

          if (pickedDate != null) {
            final String formattedDate =
                DateUtil.getStringFormattedDate(pickedDate);
            final DateTime dueDate = DateTime.parse(formattedDate);
            dateInput.text = formattedDate;
            todo.startDate = dueDate;
            ref
                .read(tasksProvider.notifier)
                .changed(startDate.id, dueDate, true);
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
