// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:todo_api/todo_api.dart';


class ProgressTaskCard extends StatelessWidget {
  final List<TaskDTO> tasks;
  final bool isCompleted;
  final Color cardColor;

  ProgressTaskCard(
      {required this.tasks,
      this.isCompleted = true,
      this.cardColor = const Color(0xFFB4B6B9),
      Key? key})
      : super(key: key);

  int countCompletedTasks() {
    return tasks.where((element) => element.isCompleted!).length;
  }

  int countInProgressTasks() {
    return tasks.where((element) => !element.isCompleted!).length;
  }

  int percentage() {
    if (tasks.isEmpty) return 0;
    return ((isCompleted
                ? countCompletedTasks() / tasks.length
                : countInProgressTasks() / tasks.length) *
            100)
        .round();
  }

  double todoRatio() {
    if (tasks.isEmpty) return 0;
    if (isCompleted) {
      return countCompletedTasks() / tasks.length;
    }
    return countInProgressTasks() / tasks.length;
  }

  String getPerformanceStatus(int percentage) {
    if (percentage == 0) {
      return "Very poor";
    } else if (percentage < 40) {
      return "Poor";
    } else if (percentage < 50) {
      return "Almost half";
    } else if (percentage < 60) {
      return "Can do better";
    } else if (percentage < 70) {
      return "Looking good";
    } else if (percentage < 80) {
      return "Excellent work!";
    } else {
      return "Keep it up!!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      width: 200,
      height: 75,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Color(0xFFE4E5E8)),
      child: Row(
        children: [
          CircularPercentIndicator(
            radius: 30.0,
            lineWidth: 5.0,
            percent: todoRatio(),
            center: Text("${percentage()}%",
                style: TextStyle(
                    fontFamily: "Cerebri Sans",
                    fontWeight: FontWeight.w600,
                    fontSize: 14)),
            progressColor: todoRatio() <= 0.5 ? Colors.redAccent : Colors.green,
          ),
          SizedBox(
            width: 4,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Opacity(
                  opacity: 0.5,
                  child: Text(
                    isCompleted ? "Completed" : "In progress",
                    style: TextStyle(fontFamily: "Cerebri Sans"),
                  )),
              SizedBox(
                height: 5,
              ),
              Text(
                getPerformanceStatus(percentage()),
                style: TextStyle(
                    fontFamily: "Cerebri Sans",
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
