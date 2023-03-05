import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_api/todo_api.dart';

import '../../../util/date.util.dart';
import '../notifier/task.state.dart';
import '../notifier/task.state.notifier.dart';

class TaskStartDate extends ConsumerWidget {
  final StateNotifierProvider<TaskStateNotifier, TaskState> taskStateProvider;
  TextEditingController dateInput = TextEditingController();

  TaskStartDate({required this.taskStateProvider, super.key});

  DateTime getInitialDate(Date? startDate) {
    if (startDate != null) {
      return startDate.toDateTime(utc: true);
    }
    return DateTime.now();
  }

  DateTime getFirstDate(Date? startDate) {
    return DateTime.now().subtract(Duration(days: 365 * 10));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var provider = ref.watch(taskStateProvider);
    Date? startDate = provider.startDate;

    if (startDate != null) {
      dateInput = TextEditingController();
      dateInput.text = DateUtil.getStringFormattedDate(startDate);
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
              initialDate: getInitialDate(startDate),
              firstDate: getFirstDate(startDate),
              lastDate: DateTime(2100),
              selectableDayPredicate: (val) {
                print(val.weekday);
                return true; return val.weekday != 7;
              });

          if (pickedDate != null) {
            final String formattedDate =
                DateUtil.getStringFormattedDate(pickedDate.toDate());
            final DateTime startDate = DateTime.parse(formattedDate);
            dateInput.text = formattedDate;
            ref
                .read(taskStateProvider.notifier)
                .setStartDate(startDate.toDate());
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
