// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo/pages/todo/notifier/todo.state.dart';
import 'package:todo/pages/todo/notifier/todo.state.notifier.dart';
import 'package:todo/pages/todo/widgets/todo.completed.checkbox.dart';
import 'package:todo/pages/todo/widgets/todo.date.dart';
import 'package:todo/pages/todo/widgets/todo.description.form.field.dart';
import 'package:todo/pages/todo/widgets/todo.type.dart';
import 'package:todo/theme/colors.dart';
import 'package:todo/util/snack.bar.util.dart';

import '../../dataprovider/todos.provider.dart';
import '../../openapi/lib/api.dart';
import '../../util/alert.dialog.util.dart';
import '../../util/route.navigator.util.dart';
import '../errors/error.dialog.dart';
import '../errors/error.object.dart';
import '../home/home.page.dart';

class UpdateTodo extends ConsumerWidget {
  static const String routeName = "/updateTodo";
  final _formKey = GlobalKey<FormState>();

  void onUpdateTodoButtonPressed(TodoDTO todo, BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      updateTodo(todo, context);
    }
  }

  void updateTodo(TodoDTO todo, BuildContext context) {
    SnackBarUtil.snackBarWithDismiss(
        context: context, value: "Todo updated.", onVisible: updateComplete);
  }

  void updateComplete() {
    Future.delayed(Duration(seconds: 3), () {});
  }

  void hideSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
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

    SnackBarUtil.snackBarWithUndo(
        context: context,
        value: "",
        onPressed: () => {},
        onVisible: () => RouteNavigatorUtil.goToPage(
            context: context, routeName: HomePage.routeName, seconds: 3));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int todoId = ModalRoute.of(context)!.settings.arguments as int;
    final Future<TodoDTO> futureTodo =
        ref.read(todosStateProvider.notifier).findTodoById(todoId);

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
        body: FutureBuilder<TodoDTO>(
            future: futureTodo,
            builder: (BuildContext context, AsyncSnapshot<TodoDTO> snapshot) {
              if (snapshot.hasData) {
                final TodoDTO todo = snapshot.data as TodoDTO;

                final todoStateProvider =
                    StateNotifierProvider<TodoStateNotifier, TodoState>((ref) {
                  return TodoStateNotifier(
                      todoState: TodoState(
                          todoType: todo.todoType!,
                          description: todo.description!,
                          isCompleted: todo.isCompleted,
                          dueDate: todo.dueDate));
                });

                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 25, right: 25, bottom: 15),
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
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: TodoTypeDropdown(
                                    todoStateProvider: todoStateProvider),
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
                                padding:
                                    const EdgeInsets.only(left: 15, top: 5),
                                child: TodoDescriptionFormField(
                                    todoStateProvider: todoStateProvider),
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
                                    todoStateProvider: todoStateProvider),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Completed",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      TodoCompleted(
                                          todoStateProvider: todoStateProvider),
                                    ],
                                  ),
                                )),
                            Container(
                                margin: EdgeInsets.only(bottom: 15),
                                height: 70,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 5, bottom: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                            height: 60,
                                            width: double.infinity,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15, right: 15),
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                  foregroundColor:
                                                  primary,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(15)),
                                                  backgroundColor: profileItem,
                                                ),
                                                onPressed: () => {
                                                onUpdateTodoButtonPressed(
                                                todo, context)
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(Iconsax.edit, weight: 22),
                                                    const SizedBox(width: 20),
                                                    Expanded(child: Text("Update"))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                      // check widgets folder for income_card.dart
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          child: Container(
                                            height: 60,
                                            width: double.infinity,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15, right: 15),
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                  foregroundColor:
                                                  Colors.deepOrangeAccent,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(15)),
                                                  backgroundColor: profileItem,
                                                ),
                                                onPressed: () => {
                                                  onDeleteTodoButtonPressed(
                                                      todo, context)
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.delete, weight: 22),
                                                    const SizedBox(width: 20),
                                                    Expanded(child: Text("Delete"))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                      // check widgets folder for expense_card.dart
                                    ],
                                  ),
                                ))
                          ],
                        )),
                  ),
                );
              } else if (snapshot.hasError) {
                return ErrorDialog(
                    errorObject:
                        ErrorObject.mapErrorToObject(error: snapshot.hasError));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
