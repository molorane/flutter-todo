import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo/models/todo.type.dart';

import '../../../theme/colors.dart';

class StatCard extends StatelessWidget {
  final String todoType;
  final int total;
  final int achieved;

  const StatCard(
      {required this.todoType,
      required this.total,
      required this.achieved,
      super.key});

  Color getColor() {
    double percentage = roundDouble(achieved / total, 1);
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
    }
    if (percentage == 0.6) {
      return completedTodo;
    } else if (percentage == 0.7) {
      return Colors.lightGreenAccent;
    } else if (percentage == 0.8) {
      return Colors.lightGreen;
    } else if (percentage == 0.9) {
      return Colors.green;
    } else if (percentage == 1.0) {
      return Colors.green;
    }

    return Colors.amber;
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                todoType.toUpperCase(),
                style: const TextStyle(
                  color: darkGray,
                  fontSize: 10,
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          CircularPercentIndicator(
            radius: 40,
            lineWidth: 8.0,
            percent: achieved / (total < achieved ? achieved : total),
            circularStrokeCap: CircularStrokeCap.round,
            center: Image.asset(TodoType.getTodoImageFromString(todoType),
                width: 35),
            progressColor: getColor(),
            backgroundColor:
                Theme.of(context).colorScheme.secondary.withAlpha(15),
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: achieved.toString(),
                style: TextStyle(
                  fontSize: 15,
                  color: getColor(),
                ),
              ),
              TextSpan(
                text: ' / $total',
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
    );
  }
}
