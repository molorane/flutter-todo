// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/openapi/lib/api.dart';
import 'package:todo/pages/todo/widgets/todo.completed.checkbox.dart';
import 'package:todo/pages/todo/widgets/todo.end.date.dart';
import 'package:todo/pages/todo/widgets/todo.start.date.dart';
import 'package:todo/pages/todo/widgets/todo.text.form.field.dart';
import 'package:todo/pages/todo/widgets/todo.type.dart';

import '../../dataprovider/todo.search.provider.dart';
import '../../theme/colors.dart';
import '../../util/route.navigator.util.dart';
import '../errors/error.dialog.dart';
import '../errors/error.object.dart';
import '../home/widgets/todo.dart';
import 'notifier/todo.state.dart';
import 'notifier/todo.state.notifier.dart';

class SearchTodos extends ConsumerWidget {
  static const String routeName = "/searchTodos";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController dateInput = TextEditingController();

  final todoStateProvider =
      StateNotifierProvider<TodoStateNotifier, TodoState>((ref) {
    return TodoStateNotifier(todoState: TodoState());
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoSearchStateData = ref.watch(todoSearchStateProvider);

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
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: TodoTypeDropdown(
                                  todoStateProvider: todoStateProvider),
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
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: TodoTextFormField(
                                  todoStateProvider: todoStateProvider),
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
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: TodoStartDate(
                                  todoStateProvider: todoStateProvider),
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
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: TodoEndDate(
                                  todoStateProvider: todoStateProvider),
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
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
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
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  backgroundColor: profileItem,
                                ),
                                onPressed: () => {
                                  ref
                                      .read(todoSearchStateProvider.notifier)
                                      .loadTodos(ref
                                          .read(todoStateProvider.notifier)
                                          .getSearchData())
                                },
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
                child: todoSearchStateData.when(
                    data: (searchData) {
                      return ListView.builder(
                          itemCount: searchData.searchResults.length,
                          itemBuilder: (context, index) {
                            return TodoWidget(
                                todo: TodoDTO(
                                    id: searchData.searchResults[index].id,
                                    todoType: searchData
                                        .searchResults[index].todoType,
                                    isCompleted: searchData
                                        .searchResults[index].isCompleted,
                                    dueDate: searchData
                                        .searchResults[index].dueDate!,
                                    description: searchData
                                        .searchResults[index].description,
                                    createdDate: searchData
                                        .searchResults[index].createdDate,
                                    isDeleted: searchData
                                        .searchResults[index].isDeleted));
                          });
                    },
                    error: (err, s) => ErrorDialog(
                        errorObject: ErrorObject.mapErrorToObject(error: err)),
                    loading: () => Center(child: CircularProgressIndicator()))),
          ],
        ));
  }
}
