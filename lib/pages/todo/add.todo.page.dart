// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/pages/todo/widgets/todo.date.dart';
import 'package:todo/pages/todo/widgets/todo.type.dart';
import 'package:todo/theme/colors.dart';

import '../../ioc/ioc.factory.dart';
import '../../openapi/lib/api.dart';
import '../../service/todo.service.dart';
import '../../state/todo.notifier.dart';
import '../../state/todo.state.dart';
import '../../util/route.navigator.util.dart';
import '../../util/snack.bar.util.dart';
import '../home/home.page.dart';
import 'widgets/todo.description.form.field.dart';

class AddTodo extends StatefulWidget {
  static const String routeName = "/addTodo";

  const AddTodo({Key? key}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodo();
}

class _AddTodo extends State<AddTodo> {
  final _formKey = GlobalKey<FormState>();
  final TodoDTO todo = TodoDTO();
  bool addTodoButtonPressed = false;
  final TodoService todoService = IocFactory.getTodoService();

  final TextEditingController dateInput = TextEditingController();

  final tasksProvider =
      StateNotifierProvider<TodoNotifier, List<TodoState>>((ref) {
    return TodoNotifier(tasks: [
      TodoState(id: 1, fieldName: 'todoType'),
      TodoState(id: 2, fieldName: 'description'),
      TodoState(id: 3, fieldName: 'dueDate'),
    ]);
  });

  void onAddTodoButtonPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        addTodoButtonPressed = true;
      });
      addTodo(todo, context);
    }
  }

  void addTodo(TodoDTO todo, BuildContext context) {
    todoService.addEntity(todo).then((response) => {
          SnackBarUtil.snackBarWithDismiss(
              context: context,
              value: "Todo added.",
              onPressed: () => {},
              onVisible: () => RouteNavigatorUtil.goToPage(
                  context: context, routeName: HomePage.routeName, seconds: 3))
        });
  }

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
          padding: const EdgeInsets.only(top: 15, left: 25, right: 25),
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
                        tasksProvider: tasksProvider,
                        todo: todo,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
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
                        tasksProvider: tasksProvider,
                        todo: todo,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
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
                        tasksProvider: tasksProvider,
                        todo: todo,
                        field: 'dueDate',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                      onTap: () {
                        if (!addTodoButtonPressed) {
                          onAddTodoButtonPressed(context);
                        }
                      },
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color:
                              !addTodoButtonPressed ? primary : inactiveButton,
                        ),
                        child: Center(
                            child: Text("Add Todo",
                                style: TextStyle(
                                    fontFamily: "Cerebri Sans",
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800))),
                      )),
                  Visibility(
                      visible: !addTodoButtonPressed,
                      replacement: Column(
                        children: const [
                          SizedBox(
                            height: 20,
                          ),
                          Center(child: CircularProgressIndicator())
                        ],
                      ),
                      child: Text(""))
                ],
              )),
        ),
      ),
    );
  }
}
