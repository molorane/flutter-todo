// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo/dto/todo.dto.dart';
import 'package:todo/pages/todo/widgets/todo.date.dart';
import 'package:todo/pages/todo/widgets/todo.description.form.field.dart';
import 'package:todo/pages/todo/widgets/todo.title.form.field.dart';
import 'package:todo/pages/todo/widgets/todo.type.dart';
import 'package:todo/theme/colors.dart';

import '../../models/todo.dart';
import '../../service/todo.api.dart';
import '../../service/todo.service.dart';
import '../../state/task.dart';
import '../../state/task.notifier.dart';

class UpdateTodo extends StatefulWidget {
  const UpdateTodo({Key? key}) : super(key: key);

  @override
  State<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {
  final _formKey = GlobalKey<FormState>();
  final TodoDTO todoDTO = TodoDTO();
  final TodoService todoService = TodoService(TodoAPI.create());

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
    final Todo updateTodo = ModalRoute.of(context)!.settings.arguments as Todo;
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
                    height: 60,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: TodoTypeDropdown(
                          taskProvider: tasksProvider,
                          initValue: updateTodo?.todoType),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: textfield,
                        borderRadius: BorderRadius.circular(17)),
                    height: 60,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TodoTitleFormField(
                          taskProvider: tasksProvider,
                          initValue: updateTodo?.title),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: textfield,
                        borderRadius: BorderRadius.circular(17)),
                    height: 80,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TodoDescriptionFormField(
                          taskProvider: tasksProvider,
                          initValue: updateTodo?.description),
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
                      child: TodoDate(
                        taskProvider: tasksProvider,
                        dueDate: updateTodo?.dueDate,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17),
                        color: textfield),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Iconsax.edit, color: primary),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                  onTap: () => {
                                        if (_formKey.currentState!.validate())
                                          {
                                            _formKey.currentState!.save(),
                                            print(todoDTO)
                                          }
                                        //Navigator.of(context).pushNamed('/profile')
                                      },
                                  child: Text(
                                    "Update",
                                    style: TextStyle(
                                        color: primary,
                                        fontFamily: "Cerebri Sans",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17),
                                  ))
                            ],
                          ),
                        ),
                        Text(
                          "|",
                          style: TextStyle(color: inactiveButton),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete, color: inProgressTodoArrow),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Delete",
                                style: TextStyle(
                                    color: inProgressTodoArrow,
                                    fontFamily: "Cerebri Sans",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
