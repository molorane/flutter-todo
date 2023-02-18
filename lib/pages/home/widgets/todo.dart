// ignore_for_file: prefer_const_constructors, camel_case_types
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/theme/colors.dart';
import 'package:todo/util/todo.type.util.dart';

import '../../../openapi/lib/api.dart';

class TodoWidget extends StatelessWidget {
  final TodoDTO todo;
  final TodoDTOTodoTypeEnumTypeTransformer transformer =
      TodoDTOTodoTypeEnumTypeTransformer();

  TodoWidget({Key? key, required this.todo}) : super(key: key);

  Color getTodoColor() {
    return todo.completed ? completedTodoContainer : inProgressTodoContainer;
  }

  String getSubStringDescription() {
    int length = todo.description!.length;
    if(length > 25)
      return todo.description!.substring(0, 25)+'...';
    return todo.description!.substring(0, length);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: GestureDetector(
          onTap: () =>
              {Navigator.of(context).pushNamed('/updateTodo', arguments: todo)},
          child: Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: getTodoColor(),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  height: 45,
                  width: 45,
                  padding: EdgeInsets.all(0.2),
                  child: Image.asset(TodoTypeUtil.getTodoImageFromString(
                      todo.todoType.toString())),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.todoType.toString(),
                      style: TextStyle(
                          fontFamily: "Cerebri Sans",
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Opacity(
                        opacity: 0.5,
                        child: Text(
                          '${getSubStringDescription()}',
                          style: TextStyle(fontFamily: "Cerebri Sans"),
                        ))
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      todo.completed
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: todo.completed ? Colors.green : Colors.redAccent,
                      size: 30.0,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Opacity(
                        opacity: 0.5,
                        child: Text(
                          DateFormat('yyyy-MM-dd').format(todo.dueDate!),
                          style: TextStyle(fontFamily: "Cerebri Sans"),
                        )),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
