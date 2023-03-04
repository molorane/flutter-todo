import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo/util/task.type.util.dart';
import 'package:todo_api/todo_api.dart';

import '../../../dataprovider/tasks.dashboard.provider.dart';
import '../../../theme/colors.dart';
import '../../task/grouping/tasks.by.type.page.dart';

class StatCard extends ConsumerWidget {
  final TaskType taskType;
  final int completed;
  final int totalByTaskType;

  const StatCard(
      {required this.taskType,
      required this.completed,
      required this.totalByTaskType,
      super.key});

  Color getColor() {
    double percentage = roundDouble(completed / totalByTaskType, 1);
    if (percentage == 0.1) {
      return Colors.redAccent;
    } else if (percentage == 0.2) {
      return Colors.orange;
    } else if (percentage == 0.3) {
      return Colors.amber;
    } else if (percentage == 0.4) {
      return inProgressTask;
    } else if (percentage == 0.5) {
      return darkGray;
    } else if (percentage == 0.6) {
      return completedTask;
    } else if (percentage == 0.7) {
      return Colors.lightGreenAccent;
    } else if (percentage == 0.8) {
      return Colors.lightGreen;
    } else if (percentage == 0.9) {
      return Colors.green;
    } else {
      return Colors.green;
    }
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
        onTap: () {
          ref.read(tasksDashboardStateProvider.notifier).setTaskType(taskType);
          Navigator.of(context)
              .pushNamed(TasksByType.routeName, arguments: taskType);
        },
        child: Container(
          width: 100,
          margin: const EdgeInsets.only(right: 15),
          padding: const EdgeInsets.only(left: 5, top: 5),
          decoration: BoxDecoration(
            color: Colors.white54,
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    taskType.toString(),
                    style: const TextStyle(
                      color: darkGray,
                      fontSize: 10,
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              CircularPercentIndicator(
                radius: 30,
                lineWidth: 8.0,
                percent: completed /
                    (totalByTaskType < completed ? completed : totalByTaskType),
                circularStrokeCap: CircularStrokeCap.round,
                center: Image.asset(
                    TaskTypeUtil.getTaskImageFromTaskType(taskType),
                    width: 25),
                progressColor: getColor(),
                backgroundColor:
                    Theme.of(context).colorScheme.secondary.withAlpha(15),
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: completed.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      color: getColor(),
                    ),
                  ),
                  TextSpan(
                    text: ' / $totalByTaskType',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ]),
              )
            ],
          ),
        ));
  }
}
