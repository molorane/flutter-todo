import 'package:flutter/material.dart';
import 'package:todo_api/todo_api.dart';

import '../../../widgets/progress.task.card.dart';

class TaskSummaryWidget extends StatelessWidget {
  final List<TaskDTO> tasks;

  TaskSummaryWidget({Key? key, required this.tasks}) : super(key: key);

  int countCompletedTasks() {
    return tasks.where((element) => element.isCompleted!).length;
  }

  int countInProgressTasks() {
    return tasks.where((element) => !element.isCompleted!).length;
  }

  double completedPercentage() {
    if (tasks.isEmpty) return 0;
    return countCompletedTasks() / tasks.length;
  }

  double inProgressPercentage() {
    if (tasks.isEmpty) return 0;
    return countInProgressTasks() / tasks.length;
  }

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
                  child: ProgressTaskCard(
                      percentage: completedPercentage(), isCompleted: true)),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: ProgressTaskCard(
                      percentage: inProgressPercentage(), isCompleted: false))
            ],
          ),
        ],
      ),
    );
  }
}
