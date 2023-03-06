// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_api/todo_api.dart';

import '../../../provider/tasks.by.type.provider.dart';
import '../../../widgets/progress.task.card.dart';
import '../../errors/error.dialog.dart';
import '../../errors/error.object.dart';
import '../../home/widgets/task.dart';

class TasksByType extends ConsumerWidget {
  static const String routeName = "/tasksByType";

  int countCompletedTasks(List<TaskGroupCount> tasksCount) {
    final List<TaskGroupCount> countCompletedTasks =
        tasksCount.where((element) => element.isCompleted!).toList();

    return safeReduce(countCompletedTasks.map((e) => e.totalTasks!).toList(),
        (value, element) => value + element);
  }

  int countInProgressTasks(List<TaskGroupCount> tasksCount) {
    final List<TaskGroupCount> countCompletedTasks =
        tasksCount.where((element) => !element.isCompleted!).toList();

    return safeReduce(countCompletedTasks.map((e) => e.totalTasks!).toList(),
        (value, element) => value + element);
  }

  int countCompletedTasksToday(List<TaskCountToday> taskCountToday) {
    final List<TaskCountToday> countCompletedTasksToday =
        taskCountToday.where((element) => element.isCompleted!).toList();

    return safeReduce(
        countCompletedTasksToday.map((e) => e.totalTasks!).toList(),
        (value, element) => value + element);
  }

  int countTasksForToday(List<TaskCountToday> taskCountToday) {
    return safeReduce(taskCountToday.map((e) => e.totalTasks!).toList(),
        (value, element) => value + element);
  }

  int safeReduce(List<int> list, Function function) {
    if (list.isEmpty) return 0;
    return list.reduce((v, e) => function(v, e));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TaskType taskType =
        ModalRoute.of(context)!.settings.arguments as TaskType;

    final tasksByTypeStateData = ref.watch(taskTypeStateProvider);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
          title: Text(
            taskType.toString(),
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Cerebri Sans",
                fontSize: 21,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: tasksByTypeStateData.when(
            loading: () => Center(child: CircularProgressIndicator()),
            data: (data) {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ProgressTaskCard(
                                tasks: data.tasks, isCompleted: true)
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'TODAY',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontFamily: 'Bebas',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'You completed ${countCompletedTasksToday(data.taskCountToday)} of 0 tasks.',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
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
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                          text: countCompletedTasks(
                                                  data.taskGroupCount)
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            color:
                                                Theme.of(context).primaryColor,
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
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                          text: countInProgressTasks(
                                                  data.taskGroupCount)
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 15,
                          thickness: 1,
                          color: Colors.grey[300],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: data.tasks.length,
                        itemBuilder: (context, index) {
                          return TaskWidget(task: data.tasks[index]);
                        }),
                  ),
                ],
              );
            },
            error: (err, s) => ErrorDialog(
                errorObject: ErrorObject.mapErrorToObject(error: err))));
  }
}
