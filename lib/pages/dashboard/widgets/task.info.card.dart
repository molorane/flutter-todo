import 'package:flutter/material.dart';
import 'package:todo/pages/dashboard/widgets/task.group.progress.dart';
import 'package:todo_api/todo_api.dart';

import '../../../constants.dart';
import '../../../util/color.util.dart';
import '../../../util/task.type.util.dart';
import '../../task/grouping/tasks.by.type.page.dart';

class TaskInfoCard extends StatelessWidget {
  final TaskType taskType;
  final int completed;
  final int totalByTaskType;

  const TaskInfoCard(
      {required this.taskType,
      required this.completed,
      required this.totalByTaskType,
      super.key});

  Color getColor() {
    return ColorUtil.getColorForCompleted(completed / totalByTaskType);
  }

  int getPercentage() {
    int percentage = 0;
    if (totalByTaskType > 0)
      percentage = ((completed / totalByTaskType) * 100).toInt();
    return percentage;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
              Navigator.of(context)
                  .pushNamed(TasksByType.routeName, arguments: taskType)
            },
        child: Container(
          padding: EdgeInsets.all(ctPadding),
          decoration: BoxDecoration(
            color: ctDarkGray,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Image.asset(
                        TaskTypeUtil.getTaskImageFromTaskType(taskType)),
                  )
                ],
              ),
              Text(taskType.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Bebas',
                      fontWeight: FontWeight.bold)),
              TaskGroupProgress(
                color: getColor(),
                percentage: getPercentage(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${completed} completed",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Bebas',
                          fontWeight: FontWeight.bold)),
                  Text(
                    totalByTaskType.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Bebas',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
