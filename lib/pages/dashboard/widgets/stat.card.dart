import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo/pages/todo/grouping/page.args.dart';
import 'package:todo/pages/todo/grouping/todos.by.type.page.dart';
import 'package:todo/util/todo.stats.dart';
import 'package:todo/util/todo.type.util.dart';

import '../../../openapi/lib/api.dart';
import '../../../theme/colors.dart';

class StatCard extends StatelessWidget {
  final TodoDTOTodoTypeEnum todoType;
  final int completed;
  final int totalByTodoType;
  final TodoStats todoStats;

  const StatCard(
      {required this.todoType,
      required this.completed,
      required this.totalByTodoType,
      required this.todoStats,
      super.key});

  Color getColor() {
    double percentage = roundDouble(completed / totalByTodoType, 1);
    if (percentage == 0.1) {
      return Colors.redAccent;
    } else if (percentage == 0.2) {
      return Colors.orange;
    } else if (percentage == 0.3) {
      return Colors.amber;
    } else if (percentage == 0.4) {
      return inProgressTodo;
    } else if (percentage == 0.5) {
      return darkGray;
    } else if (percentage == 0.6) {
      return completedTodo;
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
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(TodosByType.routeName,
              arguments: ScreenArguments(todoStats, todoType));
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
                    todoType.toString(),
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
                    (totalByTodoType < completed ? completed : totalByTodoType),
                circularStrokeCap: CircularStrokeCap.round,
                center: Image.asset(
                    TodoTypeUtil.getTodoImageFromTodoType(todoType),
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
                    text: ' / $totalByTodoType',
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
