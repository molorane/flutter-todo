import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../dto/todo.dto.dart';

class TodoDate extends StatefulWidget {

  const TodoDate({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TodoDateState();
  }
}

class _TodoDateState extends State<TodoDate> {
  TextEditingController dateInput = TextEditingController();

  _TodoDateState();

  @override
  Widget build(BuildContext context) {
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
            setState(() {
              dateInput.text =
                  formattedDate; //set output date to TextField value.
            });
          }
        },
        validator: (description) {
          if (description!.isEmpty) {
            return "Please enter description";
          }
          return null;
        },
        onSaved: (String? value) {
        });
  }
}
