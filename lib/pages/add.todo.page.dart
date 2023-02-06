// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/dto/todo.dto.dart';
import 'package:todo/theme/colors.dart';
import 'package:todo/widgets/todo.date.dart';
import 'package:todo/widgets/todo.title.form.field.dart';
import 'package:todo/widgets/todo.type.dart';

import '../widgets/todo.description.form.field.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _formKey = GlobalKey<FormState>();
  final TodoDTO todoDTO = TodoDTO();
  final tasksProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
    return TaskNotifier(tasks: [
      Task(id: 1, fieldName: 'todoType'),
      Task(id: 2, fieldName: 'title'),
      Task(id: 3, fieldName: 'description'),
      Task(id: 4, fieldName: 'dueDate'),
    ]);
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            )),
        elevation: 0.2,
        backgroundColor: Colors.white,
        title: const Text("Add Todo",
            style: TextStyle(
                fontFamily: "Cerebri Sans",
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: textfield,
                        borderRadius: BorderRadius.circular(17)),
                    height: 50,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: TodoTypeDropdown(taskProvider: tasksProvider),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: textfield,
                        borderRadius: BorderRadius.circular(17)),
                    height: 50,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TodoTitleFormField(tasksProvider),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: textfield,
                        borderRadius: BorderRadius.circular(17)),
                    height: 100,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TodoDescriptionFormField(tasksProvider),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: textfield,
                        borderRadius: BorderRadius.circular(17)),
                    height: 70,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 20, bottom: 10),
                      child: TodoDate(taskProvider: tasksProvider),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () => {
                            if (_formKey.currentState!.validate()) {}
                            //Navigator.of(context).pushNamed('/profile')
                          },
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color: primary,
                        ),
                        child: Center(
                            child: Text("Add Todo",
                                style: TextStyle(
                                    fontFamily: "Cerebri Sans",
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800))),
                      )),
                ],
              )),
        ),
      ),
    );
  }
}

class Task {
  final int id;
  final String fieldName;
  dynamic value;

  Task({required this.id, required this.fieldName, this.value});

  Task copyWith({int? id, String? fieldName, dynamic? value}) {
    return Task(
        id: id ?? this.id,
        fieldName: fieldName ?? this.fieldName,
        value: value ?? this.value);
  }
}

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier({tasks}) : super(tasks);

  void add(Task task) {
    state = [...state, task];
  }

  void changed(int taskId, dynamic newValue) {
    state = [
      for (final item in state)
        if (taskId == item.id) item.copyWith(value: newValue) else item
    ];

    print("changed$taskId");
  }
}
