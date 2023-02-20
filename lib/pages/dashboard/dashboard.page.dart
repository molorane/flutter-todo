import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:todo/pages/dashboard/widgets/stat.card.dart';
import 'package:todo/service/todo.dashboard.service.dart';
import 'package:todo/theme/colors.dart';

import '../../ioc/ioc.factory.dart';
import '../../openapi/lib/api.dart';
import '../../service/todo.service.dart';
import '../../util/todo.stats.dart';

class DashboardPage extends StatefulWidget {
  static String routeName = "/dashboard";

  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  List<TodoDTO>? todos = [];
  TodoStats? todoStats = TodoStats();
  bool isLoaded = false;
  int? deletedTodos = 0;
  final TodoService todoService = IocFactory.getTodoService();
  final TodoDashboardService dashboardService =
      IocFactory.getTodoDashboardService();

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  void fetchTodos() async {
    deletedTodos = await dashboardService.countSoftDeletedEntitiesByAccountId();
    todos = await todoService.getAllEntities();
    todoStats = TodoStats(todos: todos);
    if (todos != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Visibility(
          visible: todoStats != null,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: Scaffold(
              backgroundColor: const Color(0xfff5f7fa),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child:
                                  Image.asset('assets/todo.jpeg', width: 150),
                            ),
                            Text(
                              todoStats!.countAllTodos().toString(),
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 80,
                                fontFamily: 'Bebas',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '0'.toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        '${todoStats!.countAllTodos()} active',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  LinearPercentIndicator(
                                    lineHeight: 15,
                                    percent:
                                        todoStats!.completedTodosPercentage(),
                                    barRadius: const Radius.circular(16),
                                    backgroundColor: primary.withAlpha(30),
                                    progressColor: primaryColor,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 20),
                                  ),
                                  Text(
                                    'Today'.toUpperCase(),
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontFamily: 'Bebas',
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'You completed ${todoStats!.countCompletedTodosToday()} of ${todoStats!.countTodosForToday()} todos.',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 25,
                              thickness: 1,
                              color: Colors.grey[300],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'COMPLETED',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: todoStats!
                                                  .countCompletedTodos()
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'IN PROGRESS',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: todoStats!
                                                  .countInProgressTodos()
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'DELETED',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: deletedTodos.toString(),
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              height: 15,
                              thickness: 1,
                              color: Colors.grey[300],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 5),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Todo Groups',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 24,
                                    fontFamily: 'Bebas',
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            Container(
                                height: 120,
                                padding: const EdgeInsets.only(top: 5),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: todoStats?.groupTodos().length,
                                    itemBuilder: (context, index) {
                                      return StatCard(
                                          todoType: todoStats!
                                              .groupTodos()
                                              .elementAt(index),
                                          completed: todoStats!
                                              .countCompletedTodosByType(
                                                  todoStats!
                                                      .groupTodos()
                                                      .elementAt(index)),
                                          totalByTodoType: todoStats!
                                              .countTodosByType(todoStats!
                                                  .groupTodos()
                                                  .elementAt(index)),
                                      todoStats: todoStats!,);
                                    })),
                          ],
                        ),
                      )),
                ),
              )));
    } catch (e) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
