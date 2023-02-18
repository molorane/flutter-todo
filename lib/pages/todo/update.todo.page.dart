// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo/pages/todo/widgets/todo.completed.checkbox.dart';
import 'package:todo/pages/todo/widgets/todo.date.dart';
import 'package:todo/pages/todo/widgets/todo.description.form.field.dart';
import 'package:todo/pages/todo/widgets/todo.type.dart';
import 'package:todo/theme/colors.dart';
import 'package:todo/util/snack.bar.util.dart';

import '../../ioc/ioc.factory.dart';
import '../../openapi/lib/api.dart';
import '../../service/todo.service.dart';
import '../../state/task.dart';
import '../../state/task.notifier.dart';
import '../../util/alert.dialog.util.dart';
import '../../util/route.navigator.util.dart';
import '../home/home.page.dart';

class UpdateTodo extends StatefulWidget {
  const UpdateTodo({Key? key}) : super(key: key);

  @override
  State<UpdateTodo> createState() => _UpdateTodo();
}

class _UpdateTodo extends State<UpdateTodo> {
  final _formKey = GlobalKey<FormState>();
  final TodoService todoService = IocFactory.getTodoService();
  bool updateTodoButtonPressed = false;

  void onUpdateTodoButtonPressed(TodoDTO todo, BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        updateTodoButtonPressed = true;
      });
      updateTodo(todo, context);
    }
  }

  void updateTodo(TodoDTO todo, BuildContext context) {
    todoService.updateEntity(todo).then((response) => {
          SnackBarUtil.snackBarWithDismiss(
              context: context,
              value: "Todo updated.",
              onPressed: () => {},
              onVisible: () => {})
        });
  }

  void restoreDeletedTodo(BuildContext context, TodoDTO todo) {
    todoService.undoSoftDeletedEntity(todo.id!).then((value) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    });
  }

  void onDeleteTodoButtonPressed(TodoDTO todo, BuildContext context) {
    AlertDialogUtil.showAlertDialog(
        context,
        todo,
        "Delete Todo",
        "Are you sure you want to delete this todo?",
        () => deletedTodo(todo, context));
  }

  void deletedTodo(TodoDTO todo, BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
    setState(() {
      updateTodoButtonPressed = true;
    });
    todoService.deleteEntityById(todo.id!).then((response) {
      SnackBarUtil.snackBarWithUndo(
          context: context,
          value: response?.message ?? "",
          onPressed: () => restoreDeletedTodo(context, todo),
          onVisible: () => RouteNavigatorUtil.goToPage(
              context: context, routeName: Home.routeName, seconds: 3));
    });
  }

  Color deleteColor() {
    return !updateTodoButtonPressed ? inProgressTodoArrow : inactiveButton;
  }

  Color updateColor() {
    return !updateTodoButtonPressed ? primary : inactiveButton;
  }

  @override
  Widget build(BuildContext context) {
    final TodoDTO todo = ModalRoute.of(context)!.settings.arguments as TodoDTO;

    List<Task> tasks = [
      Task(id: 1, fieldName: 'todoType', value: todo.todoType),
      Task(id: 3, fieldName: 'completed', value: todo.completed),
      Task(id: 4, fieldName: 'description', value: todo.description),
      Task(id: 5, fieldName: 'dueDate', value: todo.dueDate),
    ];

    final tasksProvider =
        StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
      return TaskNotifier(tasks: tasks);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              RouteNavigatorUtil.previousPage(context: context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            )),
        elevation: 0.2,
        backgroundColor: Colors.white,
        title: const Text("Update Todo",
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
                        color: completedTodoContainer,
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
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: completedTodoContainer,
                        borderRadius: BorderRadius.circular(17)),
                    height: 80,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 5),
                      child: TodoDescriptionFormField(
                        taskProvider: tasksProvider,
                        todo: todo,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: completedTodoContainer,
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
                  Container(
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      decoration: BoxDecoration(
                          color: completedTodoContainer,
                          borderRadius: BorderRadius.circular(17)),
                      height: 70,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 5, bottom: 10, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Completed",
                              style: TextStyle(fontSize: 16),
                            ),
                            TodoCompleted(
                              taskProvider: tasksProvider,
                              todo: todo,
                            ),
                          ],
                        ),
                      )),
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17),
                        color: completedTodoContainer),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Iconsax.edit, color: updateColor()),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    if (!updateTodoButtonPressed) {
                                      onUpdateTodoButtonPressed(todo, context);
                                    }
                                  },
                                  child: Text(
                                    "Update",
                                    style: TextStyle(
                                        color: updateColor(),
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
                              Icon(Icons.delete, color: deleteColor()),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    if (!updateTodoButtonPressed) {
                                      onDeleteTodoButtonPressed(todo, context);
                                    }
                                  },
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                        color: deleteColor(),
                                        fontFamily: "Cerebri Sans",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 80,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 5),
                      child: Visibility(
                          visible: !updateTodoButtonPressed,
                          replacement: Column(
                            children: const [
                              SizedBox(
                                height: 20,
                              ),
                              Center(child: CircularProgressIndicator())
                            ],
                          ),
                          child: Text("")),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
