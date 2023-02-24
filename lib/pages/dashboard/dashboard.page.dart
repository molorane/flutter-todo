import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:todo/pages/dashboard/widgets/stat.card.dart';
import 'package:todo/theme/colors.dart';

import '../../dataprovider/todo.dashboard.provider.dart';
import '../errors/error.dialog.dart';
import '../errors/error.object.dart';

class DashboardPage extends ConsumerWidget {
  static const String routeName = "/dashboard";

  @override
  Widget build(BuildContext context, ref) {
    final todoDashboardStateData = ref.watch(todoDashboardStateProvider);

    return Scaffold(
        backgroundColor: const Color(0xfff5f7fa),
        body: todoDashboardStateData.when(
            data: (todoDashboardData) {
              return SingleChildScrollView(
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
                              todoDashboardData.todoStats
                                  .countAllTodos()
                                  .toString(),
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
                                        '${todoDashboardData.todoStats.countAllTodos()} active',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  LinearPercentIndicator(
                                    lineHeight: 15,
                                    percent: todoDashboardData.todoStats
                                        .completedTodosPercentage(),
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
                                    'You completed ${todoDashboardData.todoStats.countCompletedTodosToday()} of ${todoDashboardData.todoStats.countTodosForToday()} todos.',
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
                                              text: todoDashboardData.todoStats
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
                                              text: todoDashboardData.todoStats
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
                                              text: 0.toString(),
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
                                    itemCount: todoDashboardData.todoStats
                                        .groupTodos()
                                        .length,
                                    itemBuilder: (context, index) {
                                      return StatCard(
                                        todoType: todoDashboardData.todoStats
                                            .groupTodos()
                                            .elementAt(index),
                                        completed: todoDashboardData.todoStats
                                            .countCompletedTodosByType(
                                                todoDashboardData.todoStats
                                                    .groupTodos()
                                                    .elementAt(index)),
                                        totalByTodoType: todoDashboardData
                                            .todoStats
                                            .countTodosByType(todoDashboardData
                                                .todoStats
                                                .groupTodos()
                                                .elementAt(index)),
                                        todoStats: todoDashboardData.todoStats,
                                      );
                                    })),
                          ],
                        ),
                      )),
                ),
              );
            },
            error: (err, s) => ErrorDialog(
                errorObject: ErrorObject.mapErrorToObject(error: err)),
            loading: () => Center(child: CircularProgressIndicator())));
  }
}
