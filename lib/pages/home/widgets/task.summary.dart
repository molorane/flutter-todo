import 'package:flutter/material.dart';
import 'package:todo_api/todo_api.dart';

import '../../../widgets/progress.task.card.dart';

class TaskSummaryWidget extends StatelessWidget {
  final List<TaskDTO> tasks;

  TaskSummaryWidget({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 25, right: 25),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: ProgressTaskCard(tasks: tasks, isCompleted: true)),
              // check widgets folder for income_card.dart
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: ProgressTaskCard(tasks: tasks, isCompleted: false)),
              // check widgets folder for expense_card.dart
            ],
          ),
        ],
      ),
    );
  }
}
