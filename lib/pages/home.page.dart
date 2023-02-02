// ignore_for_file: camel_case_types, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:todo/service/todo.service.dart';
import 'package:todo/widgets/expense.card.dart';
import 'package:todo/widgets/income.card.dart';
import 'package:flutter/material.dart';
import 'package:todo/widgets/todo.dart';

import '../models/todo.dart';
import '../service/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo>? todos;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  void fetchTodos() async {
    final todoService = TodoService(API.create());
    todos = await todoService.getAllTodos();
    if (todos != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 15, left: 25, right: 25),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage('assets/mothusi.jpeg'),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello Mothusi",
                                style: TextStyle(
                                    fontFamily: 'Cerebri Sans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17),
                              ),
                              Text(
                                "Hope you're tracking your todos?",
                                style: TextStyle(
                                    fontFamily: 'Cerebri Sans',
                                    fontStyle: FontStyle.normal),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(child: IncomeCard()),
                          // check widgets folder for income_card.dart
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(child: ExpenseCard()),
                          // check widgets folder for expense_card.dart
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Todos',
                        style: TextStyle(
                            fontFamily: 'Cerebri Sans',
                            fontWeight: FontWeight.w800,
                            fontSize: 21),
                      ),
                      Opacity(
                          opacity: 0.3,
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed('/allTransactions');
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                              ))),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: todos?.length,
                      itemBuilder: (context, index) {
                        return TodoWidget(
                            todoType: todos![index].todoType,
                            title: todos![index].title,
                            completed: todos![index].completed,
                            dueDate: todos![index].dueDate);
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
