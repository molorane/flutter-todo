// ignore_for_file: prefer_const_constructors, camel_case_types
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:todo/dto/todo.dto.dart';
import 'package:todo/models/todo.type.dart';
import 'package:todo/theme/colors.dart';

import '../../../models/todo.dart';

class TodoWidget extends StatelessWidget {
  final TodoDTO todo;

  const TodoWidget({Key? key, required this.todo}) : super(key: key);

  String getTodoImage(TodoType todoType) {
    const String todo = "assets/todo_types";
    switch (todoType) {
      case TodoType.evangelism:
        return "$todo/evangelism.png";
      case TodoType.prayer:
        return "$todo/prayer.png";
      case TodoType.flutter:
        return "$todo/flutter.png";
      case TodoType.study:
        return "$todo/study.jpeg";
      case TodoType.spring:
        return "$todo/spring.png";
      case TodoType.gym:
        return "$todo/gym.png";
      case TodoType.food:
        return "$todo/food.jpeg";
      default:
        return "$todo/study.jpeg";
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
          onTap: () =>
              {Navigator.of(context).pushNamed('/updateTodo', arguments: todo)},
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
                  child: Image.asset(getTodoImage(todo.todoType!)),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.todoType.toString(),
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
                          todo.title!,
                          style: TextStyle(fontFamily: "Cerebri Sans"),
                        ))
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      todo.completed!
                          ? Icons.task_alt_rounded
                          : Icons.incomplete_circle_rounded,
                      color: todo.completed! ? Colors.green : Colors.redAccent,
                      size: 30.0,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Opacity(
                        opacity: 0.5,
                        child: Text(
                          todo.dueDate!,
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
