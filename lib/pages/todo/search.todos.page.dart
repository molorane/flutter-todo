// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/openapi/lib/api.dart';
import 'package:todo/pages/todo/widgets/todo.completed.checkbox.dart';
import 'package:todo/pages/todo/widgets/todo.end.date.dart';
import 'package:todo/pages/todo/widgets/todo.start.date.dart';
import 'package:todo/pages/todo/widgets/todo.text.form.field.dart';
import 'package:todo/pages/todo/widgets/todo.type.dart';

import '../../entity/todo.search.dart';
import '../../ioc/ioc.factory.dart';
import '../../service/todo.service.dart';
import '../../state/todo.notifier.dart';
import '../../state/todo.state.dart';
import '../../theme/colors.dart';
import '../../util/route.navigator.util.dart';
import '../errors/error.object.dart';
import '../home/widgets/todo.dart';

class SearchTodos extends StatefulWidget {
  static const String routeName = "/searchTodos";

  const SearchTodos({Key? key}) : super(key: key);

  @override
  State<SearchTodos> createState() => _SearchTodos();
}

class _SearchTodos extends State<SearchTodos> {
  final _formKey = GlobalKey<FormState>();
  final TodoSearch todo = TodoSearch();
  List<TodoDTO> todos = [];
  final TextEditingController dateInput = TextEditingController();

  final tasksProvider =
      StateNotifierProvider<TodoNotifier, List<TodoState>>((ref) {
    return TodoNotifier(tasks: [
      TodoState(id: 1, fieldName: 'todoType'),
      TodoState(id: 2, fieldName: 'description'),
      TodoState(id: 3, fieldName: 'startDate'),
      TodoState(id: 4, fieldName: 'endDate'),
      TodoState(id: 5, fieldName: 'isCompleted', value: false),
    ]);
  });

  bool isLoaded = false;
  final TodoService todoService = IocFactory.getTodoService();

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  void fetchTodos() async {
    try {
      todos = (await todoService.getAllEntities())!;
      setState(() {
        isLoaded = true;
      });
    } on Exception catch (e) {
      Navigator.of(context).pushNamed('/error',
          arguments: ErrorObject.mapErrorToObject(error: e));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: Scaffold(
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
              title: const Text("Search Todo",
                  style: TextStyle(
                      fontFamily: "Cerebri Sans",
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
            body: Column(
              children: [
                Form(
                    key: _formKey,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    color: textfield,
                                    borderRadius: BorderRadius.circular(17)),
                                height: 60,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: TodoTypeDropdown(
                                    tasksProvider: tasksProvider,
                                    todo: todo,
                                  ),
                                ),
                              )),
                              // check widgets folder for income_card.dart
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    color: textfield,
                                    borderRadius: BorderRadius.circular(17)),
                                height: 60,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: TodoTextFormField(
                                    tasksProvider: tasksProvider,
                                    todo: todo,
                                  ),
                                ),
                              )),
                              // check widgets folder for expense_card.dart
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    color: textfield,
                                    borderRadius: BorderRadius.circular(17)),
                                height: 60,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: TodoStartDate(
                                      tasksProvider: tasksProvider, todo: todo),
                                ),
                              )),
                              // check widgets folder for income_card.dart
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    color: textfield,
                                    borderRadius: BorderRadius.circular(17)),
                                height: 60,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: TodoEndDate(
                                      tasksProvider: tasksProvider, todo: todo),
                                ),
                              )),
                              // check widgets folder for expense_card.dart
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    color: textfield,
                                    borderRadius: BorderRadius.circular(17)),
                                height: 60,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Completed",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      TodoCompleted(
                                        tasksProvider: tasksProvider,
                                        todo: todo,
                                      ),
                                    ],
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
                                      foregroundColor: primary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      backgroundColor: profileItem,
                                    ),
                                    onPressed: () => {},
                                    child: Row(
                                      children: [
                                        Icon(Icons.search, weight: 22),
                                        const SizedBox(width: 20),
                                        Expanded(child: Text("Search"))
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                              // check widgets folder for expense_card.dart
                            ],
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Results',
                        style: TextStyle(
                            fontFamily: 'Cerebri Sans',
                            fontWeight: FontWeight.w800,
                            fontSize: 21),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Divider(
                    height: 25,
                    thickness: 1,
                    color: Colors.grey[300],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        return TodoWidget(
                            todo: TodoDTO(
                                id: todos[index].id,
                                todoType: todos[index].todoType,
                                isCompleted: todos[index].isCompleted,
                                dueDate: todos[index].dueDate!,
                                description: todos[index].description,
                                createdDate: todos[index].createdDate,
                                isDeleted: todos[index].isDeleted));
                      }),
                ),
              ],
            )));
  }
}
