import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../util/date.util.dart';
import '../notifier/todo.state.dart';
import '../notifier/todo.state.notifier.dart';

class TodoStartDate extends ConsumerWidget {
  final StateNotifierProvider<TodoStateNotifier, TodoState> todoStateProvider;
  TextEditingController dateInput = TextEditingController();

  TodoStartDate({required this.todoStateProvider, super.key});

  DateTime getInitialDate(DateTime? startDate) {
    if (startDate != null) {
      return startDate;
    }
    return DateTime.now();
  }

  DateTime getFirstDate(DateTime? startDate) {
    return DateTime.now().subtract(Duration(days: 365 * 10));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var provider = ref.watch(todoStateProvider);
    DateTime? startDate = provider.startDate;

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
                return val.weekday != 7;
              });

          if (pickedDate != null) {
            final String formattedDate =
                DateUtil.getStringFormattedDate(pickedDate);
            final DateTime startDate = DateTime.parse(formattedDate);
            dateInput.text = formattedDate;
            ref.read(todoStateProvider.notifier).setStartDate(startDate);
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
