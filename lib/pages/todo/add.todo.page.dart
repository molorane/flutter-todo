// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/pages/todo/widgets/todo.date.dart';
import 'package:todo/pages/todo/widgets/todo.type.dart';
import 'package:todo/theme/colors.dart';

import '../../dataprovider/todo.add.provider.dart';
import '../../dataprovider/todos.provider.dart';
import '../../openapi/lib/api.dart';
import '../../util/route.navigator.util.dart';
import '../../util/snack.bar.util.dart';
import '../errors/error.dialog.dart';
import '../errors/error.object.dart';
import '../home/home.page.dart';
import 'notifier/todo.state.dart';
import 'notifier/todo.state.notifier.dart';
import 'widgets/todo.description.form.field.dart';

class AddTodo extends ConsumerWidget {
  static const String routeName = "/addTodo";
  final _formKey = GlobalKey<FormState>();

  final todoStateProvider =
      StateNotifierProvider<TodoStateNotifier, TodoState>((ref) {
    return TodoStateNotifier(todoState: TodoState());
  });

  void showAlert(BuildContext context) {
    SnackBarUtil.snackBarWithDismiss(
        context: context, value: "Todo added.", onVisible: goBack);
  }

  void goBack(BuildContext context) {
    RouteNavigatorUtil.goToPage(
        context: context, routeName: HomePage.routeName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var addTodoProvider = ref.watch(todoAddStateProvider);

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
                          todoStateProvider: todoStateProvider),
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
                          todoStateProvider: todoStateProvider),
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
                      child: TodoDate(todoStateProvider: todoStateProvider),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  addTodoProvider.when(
                      data: (data) {
                        return GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                TodoDTO addTodo = ref
                                    .read(todoStateProvider.notifier)
                                    .getTodoData();
                                TodoDTO? addedTodo = await ref
                                    .read(todoAddStateProvider.notifier)
                                    .addTodo(addTodo);
                                await ref
                                    .read(todosStateProvider.notifier)
                                    .addTodo(addedTodo!);
                                showAlert(context);
                              }
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
                            ));
                      },
                      error: (err, s) => ErrorDialog(
                          errorObject:
                              ErrorObject.mapErrorToObject(error: err)),
                      loading: () {
                        return GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                color: inactiveButton,
                              ),
                              child: Center(child: CircularProgressIndicator(color: Colors.white,)),
                            ));
                      })
                ],
              )),
        ),
      ),
    );
  }
}
