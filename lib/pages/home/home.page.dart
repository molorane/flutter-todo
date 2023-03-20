// ignore_for_file: camel_case_types, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:animations/animations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo/pages/home/widgets/profile.info.page.dart';
import 'package:todo/pages/home/widgets/task.dart';
import 'package:todo/pages/home/widgets/task.summary.dart';
import 'package:todo/pages/home/widgets/view.task.page.dart';
import 'package:todo/pages/task/update.task.page.dart';
import 'package:todo/provider/tasks.dashboard.provider.dart';
import 'package:todo_api/todo_api.dart';

import '../../provider/task.add.provider.dart';
import '../../provider/tasks.provider.dart';
import '../../theme/colors.dart';
import '../../util/awesome.dialog.util.dart';
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
  bool showingList = true;

  Future<void> onRefreshList() async {
    ref.read(tasksStateProvider.notifier).findTasksByUserId();
  }

  void onDeleteTaskButtonPressed(int taskId, BuildContext context) {
    AwesomeDialogUtil.warning(
        context,
        taskId,
        "Delete Task",
        "Are you sure you want to delete this task?",
        (taskId, context) => acceptDeleteTask(taskId, context));
  }

  void acceptDeleteTask(int taskId, BuildContext context) async {
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
    ref.read(tasksDashboardStateProvider.notifier).refresh();
  }

  void undoDelete(
    BuildContext context,
    int taskId,
  ) async {
    await ref
        .read(taskAddStateProvider.notifier)
        .restoreSoftDeletedTask(taskId);
    await ref.read(tasksStateProvider.notifier).restoredTask(cacheDeletedTask!);
    AwesomeDialogUtil.success(context, "Success action", "Restored a task");
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
              padding: EdgeInsets.only(left: 15, right: 15),
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
              padding: const EdgeInsets.only(left: 25, right: 20),
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
                      child: OpenContainer(
                          transitionType: ContainerTransitionType.fadeThrough,
                          openElevation: 0,
                          transitionDuration: Duration(seconds: 1),
                          closedBuilder: (
                            BuildContext context,
                            VoidCallback action,
                          ) {
                            return Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Icon(Icons.content_paste_search));
                          },
                          openBuilder: (builder, context) {
                            return SearchTasks();
                          }),
                    ),
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
                                  key: Key(
                                      taskState.tasks[index].id!.toString()),
                                  startActionPane: ActionPane(
                                    motion: BehindMotion(),
                                    dismissible:
                                        DismissiblePane(onDismissed: () {
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
                                        onPressed: (ct) {
                                          onDeleteTaskButtonPressed(
                                              taskState.tasks[index].id!,
                                              context);
                                        },
                                      ),
                                      SlidableAction(
                                        backgroundColor: Colors.black54,
                                        icon: Iconsax.edit,
                                        label: 'Edit',
                                        onPressed: (ct) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => UpdateTask(
                                                  taskId: taskState
                                                      .tasks[index].id!),
                                            ),
                                          );
                                        },
                                      ),
                                      SlidableAction(
                                        backgroundColor: navBar,
                                        icon: Icons.close,
                                        label: 'Close',
                                        onPressed: (ct) {},
                                      )
                                    ],
                                  ),
                                  child: OpenContainer(
                                      transitionType:
                                          ContainerTransitionType.fadeThrough,
                                      closedColor: Colors.transparent,
                                      closedElevation: 0,
                                      transitionDuration: Duration(seconds: 1),
                                      closedBuilder: (
                                        BuildContext context,
                                        VoidCallback action,
                                      ) {
                                        return TaskWidget(
                                            task: taskState.tasks[index],
                                            action: action);
                                      },
                                      openBuilder: (builder, context) {
                                        return ViewTaskPage(
                                            taskId: taskState.tasks[index].id!);
                                      }));
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
        floatingActionButton: OpenContainer(
            transitionType: ContainerTransitionType.fadeThrough,
            closedColor: Colors.transparent,
            closedElevation: 0,
            transitionDuration: Duration(seconds: 1),
            closedBuilder: (
              BuildContext context,
              VoidCallback action,
            ) {
              return Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: navBar, borderRadius: BorderRadius.circular(25)),
                  child: Icon(Icons.add_circle_outline_sharp));
            },
            openBuilder: (builder, context) {
              return AddTask();
            }));
  }
}
