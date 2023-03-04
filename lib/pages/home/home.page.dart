// ignore_for_file: camel_case_types, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/pages/home/widgets/task.dart';
import 'package:todo_api/todo_api.dart';

import '../../dataprovider/tasks.provider.dart';
import '../../widgets/progress.task.card.dart';
import '../errors/error.dialog.dart';
import '../errors/error.object.dart';
import '../task/add.task.page.dart';
import '../task/search.task.page.dart';

class HomePage extends ConsumerWidget {
  static const String routeName = "/home";

  @override
  Widget build(BuildContext context, ref) {
    final taskStateProvider = ref.watch(tasksStateProvider);

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
                          color: Theme.of(context).colorScheme.secondary,
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
                          color: Theme.of(context).colorScheme.secondary,
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
        body: taskStateProvider.when(
            data: (taskState) {
              return Column(
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
                            Expanded(
                                child: ProgressTaskCard(
                                    tasks: taskState.tasks, isCompleted: true)),
                            // check widgets folder for income_card.dart
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: ProgressTaskCard(
                                    tasks: taskState.tasks,
                                    isCompleted: false)),
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
                          'Tasks',
                          style: TextStyle(
                              fontFamily: 'Cerebri Sans',
                              fontWeight: FontWeight.w800,
                              fontSize: 21),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Opacity(
                                  opacity: 0.3,
                                  child: IconButton(
                                      onPressed: () {
                                        ref
                                            .read(tasksStateProvider.notifier)
                                            .loadTop40Tasks();
                                      },
                                      icon: Icon(
                                        Icons.refresh_rounded,
                                        size: 30,
                                      ))),
                              Opacity(
                                  opacity: 0.3,
                                  child: IconButton(
                                      onPressed: () {
                                        ref
                                            .read(tasksStateProvider.notifier)
                                            .getAllTasksForToday();
                                      },
                                      icon: Icon(
                                        Icons.today_outlined,
                                        size: 30,
                                      ))),
                              Opacity(
                                  opacity: 0.3,
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed(SearchTasks.routeName);
                                      },
                                      icon: Icon(
                                        Icons.find_in_page_outlined,
                                        size: 30,
                                      ))),
                              Opacity(
                                  opacity: 0.3,
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed(AddTask.routeName);
                                      },
                                      icon: Icon(
                                        Icons.add_circle_outline_sharp,
                                        size: 30,
                                      )))
                            ])
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: taskState.tasks.length,
                        itemBuilder: (context, index) {
                          return TaskWidget(task: taskState.tasks[index]);
                        }),
                  ),
                ],
              );
            },
            error: (err, s) => ErrorDialog(
                errorObject: ErrorObject.mapErrorToObject(error: err)),
            loading: () => Center(child: CircularProgressIndicator())));
  }
}
