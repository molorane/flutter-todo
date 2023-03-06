// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/pages/task/widgets/task.date.dart';
import 'package:todo/pages/task/widgets/task.type.dart';
import 'package:todo/theme/colors.dart';
import 'package:todo_api/todo_api.dart';

import '../../notification/NotificationService.dart';
import '../../provider/task.add.provider.dart';
import '../../provider/tasks.provider.dart';
import '../../util/route.navigator.util.dart';
import '../../util/snack.bar.util.dart';
import '../errors/error.dialog.dart';
import '../errors/error.object.dart';
import '../home/home.page.dart';
import 'notifier/task.state.dart';
import 'notifier/task.state.notifier.dart';
import 'widgets/task.description.form.field.dart';

class AddTask extends ConsumerStatefulWidget {
  static const String routeName = "/addTask";

  const AddTask({Key? key}) : super(key: key);

  @override
  ConsumerState<AddTask> createState() => _AddTask();
}

class _AddTask extends ConsumerState<AddTask> {
  final _formKey = GlobalKey<FormState>();

  final taskStateProvider =
      StateNotifierProvider<TaskStateNotifier, TaskState>((ref) {
    return TaskStateNotifier(taskState: TaskState());
  });

  void showAlert(BuildContext context) {
    TaskDTO newTask = ref.read(taskStateProvider.notifier).getAddTaskData();
    SnackBarUtil.snackBarDismissAndExecute(
        context: context, value: "Task added.", onVisible: goBack);
    NotificationService().showBasicNotification(
        title: newTask.taskType!.name,
        body:
            """Heads up! You just added a new task. ${Emojis.smile_face_with_tears_of_joy} ${Emojis.smile_face_with_tears_of_joy} ${Emojis.smile_kissing_face} ${Emojis.smile_zany_face} ${Emojis.smile_hugging_face}
            """);
  }

  void goBack(BuildContext context) {
    RouteNavigatorUtil.goToPage(
        context: context, routeName: HomePage.routeName);
  }

  @override
  void initState() {
    NotificationService().requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var addTaskProvider = ref.watch(taskAddStateProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
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
        title: const Text("Add Task",
            style: TextStyle(
                fontFamily: "Cerebri Sans",
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 25, right: 25),
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
                      padding: const EdgeInsets.only(left: 15, right: 15),
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
                      padding: const EdgeInsets.only(left: 15, top: 10),
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
                      child: TaskDate(taskStateProvider: taskStateProvider),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  addTaskProvider.when(
                      data: (data) {
                        return GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                TaskDTO addTask = ref
                                    .read(taskStateProvider.notifier)
                                    .getAddTaskData();
                                Response<TaskDTO> addedTask = await ref
                                    .read(taskAddStateProvider.notifier)
                                    .addTask(addTask);
                                await ref
                                    .read(tasksStateProvider.notifier)
                                    .addTask(addedTask.data!);
                                showAlert(context);
                              }
                            },
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                color: primary,
                              ),
                              child: Center(
                                  child: Text("Add Task",
                                      style: TextStyle(
                                          fontFamily: "Cerebri Sans",
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800))),
                            ));
                      },
                      error: (err, s) => ErrorDialog(
                          errorObject:
                              ErrorObject.mapErrorToObject(error: err)),
                      loading: () {
                        return GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                color: inactiveButton,
                              ),
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: Colors.white,
                              )),
                            ));
                      })
                ],
              )),
        ),
      ),
    );
  }
}
