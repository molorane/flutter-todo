// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/pages/todo/widgets/todo.date.dart';
import 'package:todo/pages/todo/widgets/todo.title.form.field.dart';
import 'package:todo/pages/todo/widgets/todo.type.dart';
import 'package:todo/theme/colors.dart';

import '../../service/todo.api.dart';
import '../../service/todo.service.dart';
import '../../state/task.dart';
import '../../state/task.notifier.dart';
import '../routes/home.page.route.dart';
import 'widgets/todo.description.form.field.dart';

class AddTodo extends StatelessWidget {
  AddTodo({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final Todo todo = Todo();
  final TodoService todoService = TodoService(TodoAPI.create());

  final TextEditingController dateInput = TextEditingController();

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
                    height: 60,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: TodoTypeDropdown(
                        taskProvider: tasksProvider,
                        todo: todo,
                      ),
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
                        todo: todo,
                      ),
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
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: TodoDescriptionFormField(
                        taskProvider: tasksProvider,
                        todo: todo,
                      ),
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
                        todo: todo,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () => {
                            if (_formKey.currentState!.validate())
                              {
                                _formKey.currentState!.save(),
                                addTodo(todo, context)
                              }
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

  void toHomePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePageRouting(),
      ),
    );
  }

  void addTodo(Todo todo, BuildContext context) {
    todoService.addTodo(todo);
    toHomePage(context);
  }
}
