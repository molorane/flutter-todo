import 'package:flutter/material.dart';
import 'package:todo_api/todo_api.dart';

import '../../../constants.dart';
import '../../../util/task.type.util.dart';

class TaskTypeCard extends StatelessWidget {
  const TaskTypeCard({
    Key? key,
    required this.taskType,
    required this.completed,
    required this.color,
  }) : super(key: key);

  final TaskType taskType;
  final int completed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ctPadding),
      padding: EdgeInsets.all(ctPadding),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(ctPadding),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: Image.asset(
                TaskTypeUtil.getTaskImageFromString(taskType.toString())),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: ctPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(taskType.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          ),
          Text(completed.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
