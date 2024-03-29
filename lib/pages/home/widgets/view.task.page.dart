import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo/theme/colors.dart';
import 'package:todo/util/task.type.util.dart';
import 'package:todo_api/todo_api.dart';

import '../../../provider/tasks.provider.dart';
import '../../../provider/view.task.provider.dart';
import '../../../theme/design_course_app_theme.dart';
import '../../errors/error.dialog.dart';
import '../../errors/error.object.dart';

class ViewTaskPage extends ConsumerStatefulWidget {
  static const String routeName = "/viewTask";

  ViewTaskPage({required this.taskId, super.key});

  final int taskId;

  @override
  _ViewTaskPageState createState() => _ViewTaskPageState();
}

class _ViewTaskPageState extends ConsumerState<ViewTaskPage>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  bool isFavourite = false;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  void makeFavourite(bool favourite) {
    setState(() {
      isFavourite = favourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Future<TaskDTO> futureTask =
        ref.read(tasksStateProvider.notifier).findTaskById(widget.taskId);
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;

    return FutureBuilder<TaskDTO>(
        future: futureTask,
        builder: (BuildContext context, AsyncSnapshot<TaskDTO> snapshot) {
          if (snapshot.hasData) {
            final TaskDTO task = snapshot.data as TaskDTO;

            final String dueDate = DateFormat.yMMMd()
                .format(DateTime.parse(task.dueDate.toString()))
                .toString();

            final String date = DateFormat.yMMMd()
                .format(DateTime.parse(task.createdDate.toString()))
                .toString();

            final String time = DateFormat.jm()
                .format(DateTime.parse(task.createdDate.toString()))
                .toString();

            return Container(
              color: navBar,
              child: Scaffold(
                backgroundColor: navBar,
                body: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1.4,
                          child: Container(
                            margin: EdgeInsets.only(top: 60),
                            width: 50,
                            height: 50,
                            child: Image.asset(
                                TaskTypeUtil.getTaskImageFromTaskType(
                                    task.taskType!)),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: DesignCourseAppTheme.nearlyWhite,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(32.0),
                              topRight: Radius.circular(32.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color:
                                    DesignCourseAppTheme.grey.withOpacity(0.2),
                                offset: const Offset(1.1, 1.1),
                                blurRadius: 10.0),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: SingleChildScrollView(
                            child: Container(
                              constraints: BoxConstraints(
                                  minHeight: infoHeight,
                                  maxHeight: tempHeight > infoHeight
                                      ? tempHeight
                                      : infoHeight),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 32.0, left: 18, right: 16),
                                    child: Text(
                                      task.taskType.toString(),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22,
                                        letterSpacing: 0.27,
                                        color: DesignCourseAppTheme.darkerText,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        bottom: 8,
                                        top: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Checkbox(
                                            activeColor: navBar,
                                            value: task.isCompleted!,
                                            onChanged: (completed) {}),
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                dueDate,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 22,
                                                  letterSpacing: 0.27,
                                                  color:
                                                      DesignCourseAppTheme.grey,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  AnimatedOpacity(
                                    duration: const Duration(milliseconds: 500),
                                    opacity: opacity1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        children: <Widget>[
                                          getTimeBoxUI('$date  $time', 'Time')
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      opacity: opacity2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            top: 8,
                                            bottom: 8),
                                        child: Text(
                                            task.description ??
                                                'No description',
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontSize: 14,
                                              color: DesignCourseAppTheme
                                                  .dark_grey,
                                            )),
                                      ),
                                    ),
                                  ),
                                  AnimatedOpacity(
                                    duration: const Duration(milliseconds: 500),
                                    opacity: opacity3,
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, bottom: 16, right: 16)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top:
                          (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
                      right: 35,
                      child: ScaleTransition(
                        alignment: Alignment.center,
                        scale: CurvedAnimation(
                            parent: animationController!,
                            curve: Curves.fastOutSlowIn),
                        child: GestureDetector(
                            onTap: () async {
                              await ref
                                  .watch(viewTaskStateProvider.notifier)
                                  .makeTaskFavourite(
                                      widget.taskId, !task.isFavourite!);
                              makeFavourite(!task.isFavourite!);
                              ref
                                  .watch(tasksStateProvider.notifier)
                                  .makeFavourite(
                                      widget.taskId, !task.isFavourite!);
                            },
                            child: Card(
                              color: task.isFavourite!
                                  ? Colors.deepOrangeAccent
                                  : navBar,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                              elevation: 10.0,
                              child: Container(
                                width: 60,
                                height: 60,
                                child: Center(
                                  child: Icon(
                                    Icons.favorite,
                                    color: DesignCourseAppTheme.nearlyWhite,
                                    size: 30,
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top),
                      child: SizedBox(
                        width: AppBar().preferredSize.height,
                        height: AppBar().preferredSize.height,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(
                                AppBar().preferredSize.height),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: DesignCourseAppTheme.nearlyBlack,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
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
        });
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.nearlyBlue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
