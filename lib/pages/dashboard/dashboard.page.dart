import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:todo/pages/dashboard/widgets/task.groups.container.dart';
import 'package:todo/theme/colors.dart';

import '../../provider/tasks.dashboard.provider.dart';
import '../../util/color.util.dart';
import '../errors/error.dialog.dart';
import '../errors/error.object.dart';

class DashboardPage extends ConsumerWidget {
  static const String routeName = "/dashboard";

  @override
  Widget build(BuildContext context, ref) {
    final taskDashboardStateData = ref.watch(tasksDashboardStateProvider);
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xfff5f7fa),
        body: taskDashboardStateData.when(
            data: (taskDashboardData) {
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
                                  Image.asset('assets/task.jpeg', width: 150),
                            ),
                            Text(
                              taskDashboardData.taskStats
                                  .countAllTasks()
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
                                  const EdgeInsets.only(left: 15, right: 15),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: <Widget>[
                                  LinearPercentIndicator(
                                    leading: Text(
                                      '0',
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontSize: 25,
                                        fontFamily: 'Bebas',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing: Text(
                                      '${taskDashboardData.taskStats.countAllTasks()}',
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontSize: 25,
                                        fontFamily: 'Bebas',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    lineHeight: 15,
                                    percent: taskDashboardData.taskStats
                                        .completedTasksPercentage(),
                                    barRadius: const Radius.circular(16),
                                    backgroundColor: primary.withAlpha(30),
                                    progressColor:
                                        ColorUtil.getColorForCompleted(
                                            taskDashboardData.taskStats
                                                .completedTasksPercentage()),
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
                                    'You completed ${taskDashboardData.taskStats.countCompletedTasksToday()} of ${taskDashboardData.taskStats.countTasksForToday()} tasks.',
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
                                              text: taskDashboardData.taskStats
                                                  .countCompletedTasks()
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
                                              text: taskDashboardData.taskStats
                                                  .countInProgressTasks()
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
                                              text: taskDashboardData
                                                  .taskStats.deletedCount
                                                  .toString(),
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
                                  'Task Groups',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 24,
                                    fontFamily: 'Bebas',
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  TaskGroupsContainer(
                                    crossAxisCount: _size.width < 650 ? 2 : 4,
                                    childAspectRatio:
                                        _size.width < 650 && _size.width > 350
                                            ? 1.3
                                            : 1,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              );
            },
            error: (err, s) => ErrorDialog(
                errorObject: ErrorObject.mapErrorToObject(error: err)),
            loading: () => Center(child: CircularProgressIndicator())),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh_rounded, color: Colors.black54),
          backgroundColor: navBar,
          onPressed: () {
            ref.read(tasksDashboardStateProvider.notifier).refresh();
          },
        ));
  }
}
