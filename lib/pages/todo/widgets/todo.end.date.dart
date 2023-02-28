import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../notifier/todo.state.dart';
import '../notifier/todo.state.notifier.dart';

class TodoEndDate extends ConsumerWidget {
  final StateNotifierProvider<TodoStateNotifier, TodoState> todoStateProvider;
  TextEditingController dateInput = TextEditingController();

  TodoEndDate({required this.todoStateProvider, super.key});

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
    return DateTime.now().subtract(Duration(days: 365 * 10));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var provider = ref.watch(todoStateProvider);
    DateTime? endDate = provider.endDate;
    DateTime? startDate = provider.startDate;
    String changed = provider.whatChanged;

    if (changed.isNotEmpty && changed == 'startDate') {
      dateInput = TextEditingController();
    } else {
      if (endDate != null) {
        dateInput.text = getStringFromDate(endDate);
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
                return val.weekday != 7;
              });

          if (pickedDate != null) {
            final String formattedDate =
                DateFormat('yyyy-MM-dd').format(pickedDate);
            final DateTime endDate = DateTime.parse(formattedDate);
            dateInput.text = formattedDate;
            ref.read(todoStateProvider.notifier).setEndDate(endDate);
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