import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_api/todo_api.dart';

import '../notifier/task.state.dart';
import '../notifier/task.state.notifier.dart';

class TaskEndDate extends ConsumerWidget {
  final StateNotifierProvider<TaskStateNotifier, TaskState> taskStateProvider;
  TextEditingController dateInput = TextEditingController();

  TaskEndDate({required this.taskStateProvider, super.key});

  String getStringFromDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('yyyy-MM-dd').format(date);
  }

  DateTime getInitialDate(Date? startDate, Date? endDate) {
    if (startDate != null) {
      return startDate.toDateTime(utc: true).add(Duration(days: 1));
    } else if (endDate != null) {
      return endDate.toDateTime(utc: true);
    } else if (endDate != null) {
      return endDate.toDateTime(utc: true).add(Duration(days: 1));
    }
    return DateTime.now();
  }

  DateTime getFirstDate(Date? startDate, Date? endDate) {
    if (startDate != null) {
      return startDate.toDateTime(utc: true).add(Duration(days: 1));
    } else {
      return DateTime.now().subtract(Duration(days: 365 * 10));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var provider = ref.watch(taskStateProvider);
    Date? endDate = provider.endDate;
    Date? startDate = provider.startDate;
    String changed = provider.whatChanged;

    if (changed.isNotEmpty && changed == 'startDate') {
      dateInput = TextEditingController();
    } else {
      if (endDate != null) {
        dateInput.text = getStringFromDate(endDate.toDateTime(utc: true));
      }
    }

    return TextFormField(
        controller: dateInput,
        //editing controller of this TextField
        decoration: const InputDecoration(
            icon: Icon(Icons.calendar_today), //icon of text field
            labelText: "End Date",
            border: InputBorder.none //label text of field
            ),
        readOnly: true,
        //set it true, so that user will not able to edit text
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: getInitialDate(startDate, endDate),
              firstDate: getFirstDate(startDate, endDate),
              lastDate: DateTime(2100),
              selectableDayPredicate: (val) {
                return true;
                return val.weekday != 7;
              });

          if (pickedDate != null) {
            final String formattedDate =
                DateFormat('yyyy-MM-dd').format(pickedDate);
            final DateTime endDate = DateTime.parse(formattedDate);
            dateInput.text = formattedDate;
            ref.read(taskStateProvider.notifier).setEndDate(endDate.toDate());
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
