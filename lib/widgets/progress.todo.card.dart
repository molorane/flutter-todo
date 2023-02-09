// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/theme/colors.dart';

class ProgressTodoCard extends StatelessWidget {
  final List<Todo>? todos;
  final bool? completed;

  const ProgressTodoCard(this.todos, this.completed, {Key? key})
      : super(key: key);

  int countProgress() {
    return todos!.where((element) => element.completed == completed).length;
  }

  double todoRatio() {
    return countProgress() / todos!.length;
  }

  int percentage() {
    return ((countProgress() / todos!.length) * 100).round();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: completed! ? completedTodo : inProgressTodo),
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
            progressColor: Colors.green,
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
                    completed! ? "Completed" : "In progress",
                    style: TextStyle(fontFamily: "Cerebri Sans"),
                  )),
              SizedBox(
                height: 5,
              ),
              Text(
                "Looking good",
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
