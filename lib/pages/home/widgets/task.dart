// ignore_for_file: prefer_const_constructors, camel_case_types
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_api/todo_api.dart';

import '../../../theme/colors.dart';
import '../../../util/task.type.util.dart';

class TaskWidget extends StatelessWidget {
  final TaskDTO task;
  final VoidCallback action;

  TaskWidget({Key? key, required this.task, required this.action})
      : super(key: key);

  Color getTaskColor() {
    return task.isCompleted! ? completedTaskContainer : inProgressTaskContainer;
  }

  String getSubStringDescription() {
    int length = task.description!.length;
    if (length > 20) return task.description!.substring(0, 20) + '...';
    return task.description!.substring(0, length);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: GestureDetector(
          onTap: action,
          child: Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: getTaskColor(),
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
                  child: Image.asset(TaskTypeUtil.getTaskImageFromString(
                      task.taskType.toString())),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.taskType.toString(),
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
                          style: TextStyle(
                              fontFamily: "Cerebri Sans",
                              fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Visibility(
                        visible: task.isFavourite!,
                        child: Icon(
                          Icons.favorite,
                          color: Colors.deepOrangeAccent,
                          size: 30.0,
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Opacity(
                        opacity: 0.5,
                        child: Text(
                          DateFormat('MMM d, yy')
                              .format(task.dueDate!.toDateTime(utc: true)),
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
