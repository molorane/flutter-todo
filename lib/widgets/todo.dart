// ignore_for_file: prefer_const_constructors, camel_case_types
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:todo/models/todo.type.dart';
import 'package:todo/theme/colors.dart';

class TodoWidget extends StatelessWidget {
  final TodoType todoType;
  final String title;
  final bool completed;
  final String dueDate;

  const TodoWidget({
    Key? key,
    required this.todoType,
    required this.title,
    required this.completed,
    required this.dueDate,
  }) : super(key: key);

  String getTodoImage(TodoType todoType) {
    switch (todoType) {
      case TodoType.evangelism:
        return "assets/evangelism.png";
      case TodoType.prayer:
        return "assets/prayer.png";
      case TodoType.flutter:
        return "assets/flutter.png";
      case TodoType.study:
        return "assets/study.jpeg";
      case TodoType.spring:
        return "assets/spring.png";
      case TodoType.gym:
        return "assets/gym.png";
      case TodoType.food:
        return "assets/food.jpeg";
      default:
        return "assets/study.jpeg";
    }
  }

  Color getTodoColor(bool completed) {
    return completed ? completedTodoArrow : inProgressTodoArrow;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: GestureDetector(
          onTap: () => {Navigator.of(context).pushNamed('/profile')},
          child: Container(
            padding: EdgeInsets.all(12),
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: todoContainer,
              borderRadius: BorderRadius.circular(17),
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  height: 45,
                  width: 45,
                  padding: EdgeInsets.all(0.2),
                  child: Image.asset(getTodoImage(todoType)),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todoType.toString(),
                      style: TextStyle(
                          fontFamily: "Cerebri Sans",
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Opacity(
                        opacity: 0.5,
                        child: Text(
                          title,
                          style: TextStyle(fontFamily: "Cerebri Sans"),
                        ))
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      completed
                          ? Icons.task_alt_rounded
                          : Icons.incomplete_circle_rounded,
                      color: completed ? Colors.green : Colors.redAccent,
                      size: 30.0,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Opacity(
                        opacity: 0.5,
                        child: Text(
                          dueDate,
                          style: TextStyle(fontFamily: "Cerebri Sans"),
                        )),
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
        ));
  }
}
