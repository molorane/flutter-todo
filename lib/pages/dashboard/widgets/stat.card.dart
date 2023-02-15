import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo/models/todo.type.dart';

import '../../../theme/colors.dart';

class StatCard extends StatelessWidget {
  final String todoType;
  final int total;
  final int achieved;
  final Color color;

  const StatCard(
      {required this.todoType,
      required this.total,
      required this.achieved,
      required this.color,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
            progressColor: color,
            backgroundColor:
                Theme.of(context).colorScheme.secondary.withAlpha(15),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: achieved.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).accentColor,
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
