// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/pages/task/widgets/task.date.dart';
import 'package:todo/pages/task/widgets/task.type.dart';
import 'package:todo/theme/colors.dart';
import 'package:todo/util/awesome.dialog.util.dart';
import 'package:todo_api/todo_api.dart';

import '../../notification/NotificationService.dart';
import '../../provider/task.add.provider.dart';
import '../../provider/tasks.dashboard.provider.dart';
import '../../provider/tasks.provider.dart';
import '../../util/route.navigator.util.dart';
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
    AwesomeDialogUtil.successOnAction(
        context: context,
        title: "Success action.",
        message: "Task added.",
        onVisible: goBack);
    ref.read(tasksDashboardStateProvider.notifier).refresh();
  }

  void goBack(BuildContext context) {
    RouteNavigatorUtil.goToPage(
        context: context, routeName: HomePage.routeName);
  }

  void addTask() async {
    TaskDTO addTask = ref.read(taskStateProvider.notifier).getAddTaskData();
    Response<TaskDTO> addedTask =
        await ref.read(taskAddStateProvider.notifier).addTask(addTask);
    await ref.read(tasksStateProvider.notifier).addTask(addedTask.data!);
    showAlert(context);
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
          actions: <Widget>[
            TextButton(
              onPressed: () {
                ref.read(taskStateProvider.notifier).resetForm();
              },
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    width: 50,
                    child: Icon(
                      Icons.refresh,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 25,
                    ),
                  )
                ],
              ),
            )
          ]),
      body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
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
                                    addTask();
                                  }
                                },
                                child: Container(
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(17),
                                    color: navBar,
                                  ),
                                  child: Center(
                                      child: Text("Add Task",
                                          style: TextStyle(
                                              fontFamily: "Cerebri Sans",
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500))),
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
                                    color: navBar,
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
          )),
    );
  }
}
