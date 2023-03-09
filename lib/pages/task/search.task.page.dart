// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/pages/task/update.task.page.dart';
import 'package:todo/pages/task/widgets/task.completed.checkbox.dart';
import 'package:todo/pages/task/widgets/task.end.date.dart';
import 'package:todo/pages/task/widgets/task.start.date.dart';
import 'package:todo/pages/task/widgets/task.text.form.field.dart';
import 'package:todo/pages/task/widgets/task.type.dart';

import '../../provider/task.search.provider.dart';
import '../../theme/colors.dart';
import '../../util/route.navigator.util.dart';
import '../errors/error.dialog.dart';
import '../errors/error.object.dart';
import '../home/widgets/task.dart';
import 'notifier/task.state.dart';
import 'notifier/task.state.notifier.dart';

class SearchTasks extends ConsumerStatefulWidget {
  static const String routeName = "/searchTasks";

  const SearchTasks({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchTasks> createState() => _SearchTasks();
}

class _SearchTasks extends ConsumerState<SearchTasks> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController dateInput = TextEditingController();
  bool loadMore = false;

  final ScrollController scrollController = ScrollController();

  final taskStateProvider =
      StateNotifierProvider<TaskStateNotifier, TaskState>((ref) {
    return TaskStateNotifier(taskState: TaskState());
  });

  void loadMoreListener() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !loadMore) {
      loadMore = true;
      if (loadMore) {
        print("Scrolled to end solution 1");
        if (ref.read(taskSearchStateProvider.notifier).hasMore()) {
          ref
              .read(taskSearchStateProvider.notifier)
              .loadMore(ref.read(taskStateProvider.notifier).getSearchData());
        }
        Future.delayed(Duration(seconds: 3), () {
          loadMore = false;
        });
      }
    }
  }

  Future refresh() async {
    ref
        .read(taskSearchStateProvider.notifier)
        .loadLatest(ref.read(taskStateProvider.notifier).getSearchData());
  }

  @override
  Widget build(BuildContext context) {
    final taskSearchStateData = ref.watch(taskSearchStateProvider);
    scrollController..addListener(loadMoreListener);

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
            title: const Text("Search Task",
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
        body: Column(
          children: [
            Form(
                key: _formKey,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
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
                          )),
                          // check widgets folder for income_card.dart
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                                color: textfield,
                                borderRadius: BorderRadius.circular(17)),
                            height: 60,
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: TaskTextFormField(
                                  taskStateProvider: taskStateProvider),
                            ),
                          )),
                          // check widgets folder for expense_card.dart
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                                color: textfield,
                                borderRadius: BorderRadius.circular(17)),
                            height: 60,
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: TaskStartDate(
                                  taskStateProvider: taskStateProvider),
                            ),
                          )),
                          // check widgets folder for income_card.dart
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                                color: textfield,
                                borderRadius: BorderRadius.circular(17)),
                            height: 60,
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: TaskEndDate(
                                  taskStateProvider: taskStateProvider),
                            ),
                          )),
                          // check widgets folder for expense_card.dart
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                                color: textfield,
                                borderRadius: BorderRadius.circular(17)),
                            height: 60,
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
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
                            ),
                          )),
                          // check widgets folder for income_card.dart
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Container(
                            height: 60,
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  backgroundColor: navBar,
                                ),
                                onPressed: () => {
                                  ref
                                      .read(taskSearchStateProvider.notifier)
                                      .loadTasks(ref
                                          .read(taskStateProvider.notifier)
                                          .getSearchData())
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.search,
                                        weight: 25, color: Colors.black54),
                                    const SizedBox(width: 5),
                                    Text("Search",
                                        style: TextStyle(
                                            fontFamily: "Cerebri Sans",
                                            fontSize: 20,
                                            color: Colors.black38,
                                            fontWeight: FontWeight.w400))
                                  ],
                                ),
                              ),
                            ),
                          )),
                          // check widgets folder for expense_card.dart
                        ],
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Results',
                    style: TextStyle(
                        fontFamily: 'Cerebri Sans',
                        fontWeight: FontWeight.w800,
                        fontSize: 21),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Divider(
                height: 25,
                thickness: 1,
                color: Colors.grey[300],
              ),
            ),
            Expanded(
                child: taskSearchStateData.when(
                    data: (searchData) {
                      return RefreshIndicator(
                          child: ListView.builder(
                              controller: scrollController,
                              itemCount: searchData.searchResults.length,
                              itemBuilder: (context, index) {
                                return OpenContainer(
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
                                          task: searchData.searchResults[index],
                                          action: action);
                                    },
                                    openBuilder: (builder, context) {
                                      return UpdateTask(
                                          taskId: searchData
                                              .searchResults[index].id!);
                                    });
                              }),
                          onRefresh: refresh);
                    },
                    error: (err, s) => ErrorDialog(
                        errorObject: ErrorObject.mapErrorToObject(error: err)),
                    loading: () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[CircularProgressIndicator()]))),
          ],
        ));
  }
}
