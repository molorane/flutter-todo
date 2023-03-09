// ignore_for_file: camel_case_types, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo/pages/home/widgets/profile.info.page.dart';
import 'package:todo/pages/home/widgets/task.dart';
import 'package:todo/pages/home/widgets/task.summary.dart';
import 'package:todo_api/todo_api.dart';

import '../../provider/task.add.provider.dart';
import '../../provider/tasks.provider.dart';
import '../../theme/colors.dart';
import '../../util/alert.dialog.util.dart';
import '../../util/snack.bar.util.dart';
import '../errors/error.dialog.dart';
import '../errors/error.object.dart';
import '../task/add.task.page.dart';
import '../task/search.task.page.dart';

class HomePage extends ConsumerStatefulWidget {
  static const String routeName = "/home";

  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePage();
}

class _HomePage extends ConsumerState<HomePage> {
  bool loadMore = false;
  late TaskDTO? cacheDeletedTask;

  Future<void> onRefreshList() async {
    ref.read(tasksStateProvider.notifier).findTasksByUserId();
  }

  void onDeleteTaskButtonPressed(int taskId, BuildContext context) {
    AlertDialogUtil.showAlertDialog(
        context,
        taskId,
        "Delete Task",
        "Are you sure you want to delete this task?",
        (taskId, context) => acceptDeleteTask(taskId, context));
  }

  void acceptDeleteTask(int taskId, BuildContext context) async {
    Navigator.of(context, rootNavigator: true).pop();
    deleteTask(taskId, context);
  }

  void deleteTask(int taskId, BuildContext context) async {
    final Response<DefaultResponse> defaultResponse = await ref
        .read(taskAddStateProvider.notifier)
        .deleteTaskByIdAndUserId(taskId);

    cacheDeletedTask =
        ref.read(tasksStateProvider.notifier).getDeletedTask(taskId);

    SnackBarUtil.snackBarWithUndo(
        context: context,
        value: defaultResponse.data!.message!,
        onPressed: () => undoDelete(context, taskId),
        onVisible: (context) => taskDeleted(context, taskId));
  }

  void taskDeleted(BuildContext context, int taskId) {
    ref.read(tasksStateProvider.notifier).taskDeleted(taskId);
  }

  void undoDelete(
    BuildContext context,
    int taskId,
  ) async {
    print(cacheDeletedTask);
    await ref
        .read(taskAddStateProvider.notifier)
        .restoreSoftDeletedTask(taskId);
    await ref.read(tasksStateProvider.notifier).restoredTask(cacheDeletedTask!);

    SnackBarUtil.snackBarDismissAndDoNothing(
        context: context, value: "Restored a task");
  }

  @override
  Widget build(BuildContext context) {
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
              child: ProfileInfoPage()),
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
        body: Column(
          children: [
            taskStateProvider.when(
                data: (taskState) {
                  return TaskSummaryWidget(tasks: taskState.tasks);
                },
                error: (err, s) => TaskSummaryWidget(tasks: []),
                loading: () => TaskSummaryWidget(tasks: [])),
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
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Opacity(
                        opacity: 0.3,
                        child: IconButton(
                            onPressed: () {
                              ref
                                  .read(tasksStateProvider.notifier)
                                  .loadTasksForToday();
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
                            onPressed: () {},
                            icon: Icon(
                              Icons.insert_chart,
                              size: 30,
                            )))
                  ])
                ],
              ),
            ),
            Expanded(
              child: taskStateProvider.when(
                  data: (taskState) {
                    return RefreshIndicator(
                        child: ListView.builder(
                            itemCount: taskState.tasks.length,
                            itemBuilder: (context, index) {
                              return Slidable(
                                key: Key(taskState.tasks[index].id!.toString()),
                                startActionPane: ActionPane(
                                  motion: BehindMotion(),
                                  dismissible: DismissiblePane(onDismissed: () {
                                    deleteTask(
                                        taskState.tasks[index].id!, context);
                                  }),
                                  children: [],
                                ),
                                endActionPane: ActionPane(
                                  motion: const StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      backgroundColor: Colors.red,
                                      icon: Iconsax.trash,
                                      label: 'Delete',
                                      onPressed: (BuildContext ct) {
                                        onDeleteTaskButtonPressed(
                                            taskState.tasks[index].id!,
                                            context);
                                      },
                                    ),
                                    SlidableAction(
                                      backgroundColor: navBar,
                                      icon: Iconsax.edit,
                                      label: 'Edit',
                                      onPressed: (BuildContext ct) {
                                        Navigator.of(context).pushNamed(
                                            '/updateTask',
                                            arguments:
                                                taskState.tasks[index].id);
                                      },
                                    )
                                  ],
                                ),
                                child: TaskWidget(task: taskState.tasks[index]),
                              );
                            }),
                        onRefresh: onRefreshList);
                  },
                  error: (err, s) => ErrorDialog(
                      errorObject: ErrorObject.mapErrorToObject(error: err)),
                  loading: () => Center(child: CircularProgressIndicator())),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_circle_outline_sharp),
          backgroundColor: navBar,
          onPressed: () {
            Navigator.of(context).pushNamed(AddTask.routeName);
          },
        ));
  }
}
