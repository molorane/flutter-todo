import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo/entity/todo.search.dart';

import '../../../state/todo.notifier.dart';
import '../../../state/todo.state.dart';

class TodoEndDate extends ConsumerWidget {
  final StateNotifierProvider<TodoNotifier, List<TodoState>> tasksProvider;
  final TodoSearch todo;
  TextEditingController dateInput = TextEditingController();

  TodoEndDate({required this.tasksProvider, required this.todo, super.key});

  String getStringFromDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('yyyy-MM-dd').format(date);
  }

  DateTime getInitialDate(DateTime? startDate, DateTime? endDate) {
    if (startDate != null) {
      return startDate;
    } else if (endDate != null) {
      return endDate;
    } else if (endDate != null) {
      return endDate.add(Duration(days: 1));
    }
    return DateTime.now();
  }

  DateTime getFirstDate(DateTime? startDate, DateTime? endDate) {
    if (startDate != null) {
      return startDate;
    } else if (endDate != null) {
      return endDate;
    } else if (endDate != null) {
      return endDate.add(Duration(days: 1));
    }
    return DateTime.now();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tasks = ref.watch(tasksProvider);
    TodoState endDate = tasks.where((e) => e.fieldName == 'endDate').first;
    TodoState startDate = tasks.where((e) => e.fieldName == 'startDate').first;

    if (startDate.changed) {
      dateInput = TextEditingController();
    } else {
      if (endDate.value != null) {
        dateInput.text = getStringFromDate(endDate.value);
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
              initialDate: getInitialDate(startDate.value, endDate.value),
              firstDate: getFirstDate(startDate.value, endDate.value),
              lastDate: DateTime(2100),
              selectableDayPredicate: (val) {
                return val.weekday != 7;
              });

          if (pickedDate != null) {
            final String formattedDate =
                DateFormat('yyyy-MM-dd').format(pickedDate);
            final DateTime dueDate = DateTime.parse(formattedDate);
            dateInput.text = formattedDate;
            todo.endDate = dueDate;
            ref.read(tasksProvider.notifier).changed(endDate.id, dueDate, true);
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
