// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo/pages/home/home.page.dart';
import 'package:todo/pages/todo/notifier/todo.state.dart';
import 'package:todo/pages/todo/notifier/todo.state.notifier.dart';
import 'package:todo/pages/todo/widgets/todo.completed.checkbox.dart';
import 'package:todo/pages/todo/widgets/todo.date.dart';
import 'package:todo/pages/todo/widgets/todo.description.form.field.dart';
import 'package:todo/pages/todo/widgets/todo.type.dart';
import 'package:todo/theme/colors.dart';
import 'package:todo/util/snack.bar.util.dart';

import '../../dataprovider/todo.add.provider.dart';
import '../../dataprovider/todos.provider.dart';
import '../../openapi/lib/api.dart';
import '../../util/alert.dialog.util.dart';
import '../../util/route.navigator.util.dart';
import '../errors/error.dialog.dart';
import '../errors/error.object.dart';

class UpdateTodo extends ConsumerStatefulWidget {
  static const String routeName = "/updateTodo";

  const UpdateTodo({Key? key}) : super(key: key);

  @override
  ConsumerState<UpdateTodo> createState() => _UpdateTodo();
}

class _UpdateTodo extends ConsumerState<UpdateTodo> {
  final _formKey = GlobalKey<FormState>();
  late int todoId;
  late TodoDTO? cacheDeletedTodo;

  void hideSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  void onDeleteTodoButtonPressed(int todoId, BuildContext context) {
    AlertDialogUtil.showAlertDialog(
        context,
        todoId,
        "Delete Todo",
        "Are you sure you want to delete this todo?",
        (todoId, context) => deletedTodo(context));
  }

  void deletedTodo(BuildContext context) async {
    Navigator.of(context, rootNavigator: true).pop();

    final DefaultResponse defaultResponse = await ref
        .read(todoAddStateProvider.notifier)
        .deleteTodoByIdAndUserId(todoId);

    cacheDeletedTodo =
        ref.read(todosStateProvider.notifier).getDeletedTodo(todoId);

    SnackBarUtil.snackBarWithUndo(
        context: context,
        value: defaultResponse.message!,
        onPressed: () => undoDelete(context),
        onVisible: (context) => todoDeleted(context));
  }

  void todoDeleted(BuildContext context) {
    ref.read(todosStateProvider.notifier).todoDeleted(todoId);
    Future.delayed(Duration(seconds: 3), () {
      RouteNavigatorUtil.goToPage(
          context: context, routeName: HomePage.routeName);
    });
  }

  void undoDelete(BuildContext context) async {
    await ref
        .read(todoAddStateProvider.notifier)
        .restoreSoftDeletedTodo(todoId);

    await ref.read(todosStateProvider.notifier).restoredTodo(cacheDeletedTodo!);

    SnackBarUtil.snackBarDismissAndDoNothing(
        context: context, value: "Restored a todo");
  }

  @override
  Widget build(BuildContext context) {
    todoId = ModalRoute.of(context)!.settings.arguments as int;
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

                final todoAddState = ref.watch(todoAddStateProvider);

                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 25, right: 25, bottom: 15),
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
                                    child: todoAddState.when(
                                        data: (data) {
                                          return Row(
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                height: 60,
                                                width: double.infinity,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15, right: 15),
                                                  child: TextButton(
                                                    style: TextButton.styleFrom(
                                                      foregroundColor: primary,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                      backgroundColor:
                                                          profileItem,
                                                    ),
                                                    onPressed: () async {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        _formKey.currentState!
                                                            .save();
                                                        final TodoDTO updateTodoDTO = ref
                                                            .read(
                                                                todoStateProvider
                                                                    .notifier)
                                                            .getUpdateTodoData();
                                                        updateTodoDTO.id =
                                                            todoId;
                                                        await ref
                                                            .read(
                                                                todoAddStateProvider
                                                                    .notifier)
                                                            .updateTodo(
                                                                updateTodoDTO);
                                                        SnackBarUtil
                                                            .snackBarDismissAndDoNothing(
                                                                context:
                                                                    context,
                                                                value:
                                                                    "Todo updated.");
                                                        ref
                                                            .read(
                                                                todoAddStateProvider
                                                                    .notifier)
                                                            .updateComplete();
                                                      }
                                                    },
                                                    child: todoAddState.when(
                                                        data: (data) {
                                                          return Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Icon(Iconsax.edit,
                                                                  weight: 22),
                                                              const SizedBox(
                                                                  width: 20),
                                                              Expanded(
                                                                  child: Text(
                                                                      "Update"))
                                                            ],
                                                          );
                                                        },
                                                        error: (err, s) => ErrorDialog(
                                                            errorObject: ErrorObject
                                                                .mapErrorToObject(
                                                                    error:
                                                                        err)),
                                                        loading: () {
                                                          return Center(
                                                              child: CircularProgressIndicator(
                                                                  color:
                                                                      primaryColor));
                                                        }),
                                                  ),
                                                ),
                                              )),
                                              Expanded(
                                                  child: Container(
                                                height: 60,
                                                width: double.infinity,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15, right: 15),
                                                  child: TextButton(
                                                    style: TextButton.styleFrom(
                                                      foregroundColor: Colors
                                                          .deepOrangeAccent,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                      backgroundColor:
                                                          profileItem,
                                                    ),
                                                    onPressed: () => {
                                                      onDeleteTodoButtonPressed(
                                                          todoId, context)
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Icon(Icons.delete,
                                                            weight: 22),
                                                        const SizedBox(
                                                            width: 20),
                                                        Expanded(
                                                            child:
                                                                Text("Delete"))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )),
                                              // check widgets folder for expense_card.dart
                                            ],
                                          );
                                        },
                                        error: (err, s) => ErrorDialog(
                                            errorObject:
                                                ErrorObject.mapErrorToObject(
                                                    error: err)),
                                        loading: () {
                                          return Center(
                                              child: CircularProgressIndicator(
                                                  color: primaryColor));
                                        })))
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
