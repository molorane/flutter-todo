// ignore_for_file: camel_case_types, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:todo/pages/home/widgets/todo.dart';
import 'package:todo/service/todo.service.dart';
import 'package:todo/widgets/progress.todo.card.dart';

import '../../dto/todo.dto.dart';
import '../../models/todo.dart';
import '../../service/todo.api.dart';

class Home extends StatefulWidget {
  static String routeName = "/home";

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TodoDTO>? todos;
  bool isLoaded = false;
  final TodoService todoService = TodoService(TodoAPI.create());

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  void fetchTodos() async {
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
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 5,
          backgroundColor: Colors.white,
          title: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 10, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('assets/mothusi.jpeg'),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Hello Mothusi',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Track your daily tasks with ease.",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          actions: <Widget>[
            TextButton(
              onPressed: () {},
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    width: 50,
                    child: Icon(
                      Icons.notifications,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 35,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    width: 20,
                    height: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.red,
                      ),
                      width: 20,
                      height: 20,
                      child: Center(
                        child: Text(
                          '03',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        body: Visibility(
            visible: isLoaded,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(child: ProgressTodoCard(todos, true)),
                          // check widgets folder for income_card.dart
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(child: ProgressTodoCard(todos, false)),
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
                                Navigator.of(context).pushNamed('/addTodo');
                              },
                              icon: Icon(
                                Icons.add_circle_outline_sharp,
                                size: 30,
                              ))),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: todos?.length,
                      itemBuilder: (context, index) {
                        return TodoWidget(
                            todo: TodoDTO(
                                id: todos![index].id,
                                todoType: todos![index].todoType,
                                title: todos![index].title,
                                completed: todos![index].completed,
                                dueDate: todos![index].dueDate,
                                description: todos![index].description,
                                createdDate: todos![index].createdDate,
                                deleted: todos![index].deleted));
                      }),
                ),
              ],
            )));
  }
}
