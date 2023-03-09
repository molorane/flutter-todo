// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/pages/task/widgets/task.completed.checkbox.dart';
import 'package:todo/pages/task/widgets/task.date.dart';
import 'package:todo/pages/task/widgets/task.description.form.field.dart';
import 'package:todo/pages/task/widgets/task.type.dart';
import 'package:todo_api/todo_api.dart';

import '../../notification/NotificationService.dart';
import '../../provider/task.add.provider.dart';
import '../../provider/tasks.dashboard.provider.dart';
import '../../provider/tasks.provider.dart';
import '../../theme/colors.dart';
import '../../util/route.navigator.util.dart';
import '../../util/snack.bar.util.dart';
import '../errors/error.dialog.dart';
import '../errors/error.object.dart';
import 'notifier/task.state.dart';
import 'notifier/task.state.notifier.dart';

class UpdateTask extends ConsumerStatefulWidget {
  static const String routeName = "/updateTask";

  const UpdateTask({Key? key}) : super(key: key);

  @override
  ConsumerState<UpdateTask> createState() => _UpdateTask();
}

class _UpdateTask extends ConsumerState<UpdateTask> {
  final _formKey = GlobalKey<FormState>();
  late int taskId;

  void hideSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  void updateTask(
      StateNotifierProvider<TaskStateNotifier, TaskState>
          taskStateProvider) async {
    final TaskDTO updateTaskDTO =
        ref.read(taskStateProvider.notifier).getUpdateTaskDataWithID(taskId);
    await ref.read(taskAddStateProvider.notifier).updateTask(updateTaskDTO);
    SnackBarUtil.snackBarDismissAndDoNothing(
        context: context, value: "Task updated.");
    ref.read(taskAddStateProvider.notifier).updateComplete();
    await ref.read(tasksStateProvider.notifier).updateTask(updateTaskDTO);
    NotificationService().showBasicNotificationWithBigPicture(
        taskType: updateTaskDTO.taskType!,
        title: updateTaskDTO.taskType!.name,
        body:
            """Heads up! You just udated a task. ${Emojis.smile_face_with_tears_of_joy} ${Emojis.smile_face_with_tears_of_joy} ${Emojis.smile_kissing_face} ${Emojis.smile_zany_face} ${Emojis.smile_hugging_face}
            """);
    ref.read(tasksDashboardStateProvider.notifier).refresh();
  }

  @override
  void initState() {
    NotificationService().requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    taskId = ModalRoute.of(context)!.settings.arguments as int;
    final Future<TaskDTO> futureTask =
        ref.read(tasksStateProvider.notifier).findTaskById(taskId);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                RouteNavigatorUtil.previousPage(context: context);
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              )),
          elevation: 0.2,
          backgroundColor: Colors.white,
          title: const Text("Update Task",
              style: TextStyle(
                  fontFamily: "Cerebri Sans",
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        body: FutureBuilder<TaskDTO>(
            future: futureTask,
            builder: (BuildContext context, AsyncSnapshot<TaskDTO> snapshot) {
              if (snapshot.hasData) {
                final TaskDTO task = snapshot.data as TaskDTO;

                final taskStateProvider =
                    StateNotifierProvider<TaskStateNotifier, TaskState>((ref) {
                  return TaskStateNotifier(
                      taskState: TaskState(
                          taskType: task.taskType!,
                          description: task.description!,
                          isCompleted: task.isCompleted!,
                          dueDate: task.dueDate!));
                });

                final taskAddState = ref.watch(taskAddStateProvider);

                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 25, right: 25, bottom: 15),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: textfield,
                                  borderRadius: BorderRadius.circular(17)),
                              height: 60,
                              width: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: TaskTypeDropdown(
                                    taskStateProvider: taskStateProvider),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: textfield,
                                  borderRadius: BorderRadius.circular(17)),
                              height: 80,
                              width: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 5),
                                child: TaskDescriptionFormField(
                                    taskStateProvider: taskStateProvider),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: textfield,
                                  borderRadius: BorderRadius.circular(17)),
                              height: 70,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 20, bottom: 10),
                                child: TaskDate(
                                    taskStateProvider: taskStateProvider),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 15, bottom: 15),
                                decoration: BoxDecoration(
                                    color: textfield,
                                    borderRadius: BorderRadius.circular(17)),
                                height: 70,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 5, bottom: 10, top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Completed",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      TaskCompleted(
                                          taskStateProvider: taskStateProvider),
                                    ],
                                  ),
                                )),
                            Container(
                                margin: EdgeInsets.only(bottom: 15),
                                height: 70,
                                width: double.infinity,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 5, bottom: 10),
                                    child: taskAddState.when(
                                        data: (data) {
                                          return Row(
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                height: 60,
                                                width: double.infinity,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15, right: 15),
                                                  child: TextButton(
                                                    style: TextButton.styleFrom(
                                                      foregroundColor: primary,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                      backgroundColor: primary,
                                                    ),
                                                    onPressed: () async {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        _formKey.currentState!
                                                            .save();
                                                        updateTask(
                                                            taskStateProvider);
                                                      }
                                                    },
                                                    child: taskAddState.when(
                                                        data: (data) {
                                                          return Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Center(
                                                                  child: Text(
                                                                      "Update Task",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Cerebri Sans",
                                                                          fontSize:
                                                                              20,
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight.w800)))
                                                            ],
                                                          );
                                                        },
                                                        error: (err, s) => ErrorDialog(
                                                            errorObject: ErrorObject
                                                                .mapErrorToObject(
                                                                    error:
                                                                        err)),
                                                        loading: () {
                                                          return Center(
                                                              child: CircularProgressIndicator(
                                                                  color:
                                                                      primaryColor));
                                                        }),
                                                  ),
                                                ),
                                              ))
                                            ],
                                          );
                                        },
                                        error: (err, s) => ErrorDialog(
                                            errorObject:
                                                ErrorObject.mapErrorToObject(
                                                    error: err)),
                                        loading: () {
                                          return Center(
                                              child: CircularProgressIndicator(
                                                  color: primaryColor));
                                        })))
                          ],
                        )),
                  ),
                );
              } else if (snapshot.hasError) {
                return ErrorDialog(
                    errorObject:
                        ErrorObject.mapErrorToObject(error: snapshot.hasError));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
