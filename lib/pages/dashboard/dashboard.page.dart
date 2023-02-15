import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:todo/pages/dashboard/widgets/stat.card.dart';
import 'package:todo/theme/colors.dart';

import '../../ioc/ioc.factory.dart';
import '../../models/todo.dart';
import '../../service/todo.service.dart';
import '../../util/todo.stats.dart';

class DashboardPage extends StatefulWidget {
  static String routeName = "/dashboard";

  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  List<Todo>? todos = [];
  TodoStats? todoStats = TodoStats();
  bool isLoaded = false;
  final TodoService todoService = IocFactory.getTodoService();

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  void fetchTodos() async {
    todos = await todoService.getAllTodos();
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
      Size size = MediaQuery.of(context).size;
      return Visibility(
          visible: todoStats != null,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: Scaffold(
              backgroundColor: const Color(0xfff5f7fa),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
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
                              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
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
                                        '${todoStats!.countAllTodos()} todos',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  LinearPercentIndicator(
                                    lineHeight: 8.0,
                                    percent: todoStats!.completedTodosPercentage(),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    backgroundColor: primary.withAlpha(30),
                                    progressColor:
                                        Theme.of(context).primaryColor,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 30),
                                  ),
                                  Text(
                                    'Todos Today'.toUpperCase(),
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontFamily: 'Bebas',
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'You completed 165 todos today',
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
                              color: Colors.grey[300],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'DISTANCE',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '8500',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' m',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
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
                                        'CALORIES',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '259',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' cal',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        'HEART RATE',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '102',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' bpm',
                                              style: TextStyle(
                                                color: Colors.grey,
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
                              color: Colors.grey[300],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Todo Categories',
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
                              height: 160,
                              padding: const EdgeInsets.only(top: 5),
                              child: ListView(
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  StatCard(
                                    title: 'Carbs',
                                    achieved: 200,
                                    total: 350,
                                    color: Colors.orange,
                                    image: Image.asset(
                                        'assets/todo_types/spring.png',
                                        width: 20),
                                  ),
                                  StatCard(
                                    title: 'Protien',
                                    achieved: 350,
                                    total: 300,
                                    color: Theme.of(context).primaryColor,
                                    image: Image.asset(
                                        'assets/todo_types/flutter.png',
                                        width: 20),
                                  ),
                                  StatCard(
                                    title: 'Fats',
                                    achieved: 100,
                                    total: 200,
                                    color: Colors.green,
                                    image: Image.asset(
                                        'assets/todo_types/food.jpeg',
                                        width: 20),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              )));
    } catch (e) {
      return const CircularProgressIndicator();
    }
  }
}
