import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_api/todo_api.dart';

import '../../../constants.dart';
import '../../../provider/tasks.dashboard.provider.dart';
import '../../../theme/colors.dart';
import '../../../util/color.util.dart';
import '../../../util/task.stats.dart';
import '../../errors/error.dialog.dart';
import '../../errors/error.object.dart';

class TaskChart extends ConsumerWidget {
  TaskChart({super.key});

  Color getColor(TaskStats taskStats, TaskType taskType) {
    return ColorUtil.getColorForCompleted(
        taskStats.countCompletedTasksByType(taskType) /
            taskStats.countTasksByType(taskType));
  }

  double getPercentage(TaskStats taskStats, TaskType taskType) {
    return taskStats.countCompletedTasksByType(taskType) /
        taskStats.countTasksByType(taskType) *
        100;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskDashboardStateData = ref.watch(tasksDashboardStateProvider);

    return taskDashboardStateData.when(
        data: (data) {
          final List<PieChartSectionData> taskGroups = [];

          for (TaskType taskType in data.taskStats.groupTasks()) {
            taskGroups.add(PieChartSectionData(
                color: getColor(data.taskStats, taskType),
                value: data.taskStats
                    .countCompletedTasksByType(taskType)
                    .toDouble(),
                showTitle: true,
                radius: getPercentage(data.taskStats, taskType),
                title: taskType.name));
          }

          return SizedBox(
            height: 300,
            child: Stack(
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 4,
                    centerSpaceRadius: 100,
                    startDegreeOffset: -90,
                    sections: taskGroups,
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: ctPadding),
                      Text(
                        data.taskStats.countCompletedTasks().toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: navBar,
                              fontWeight: FontWeight.w600,
                              height: 0.5,
                            ),
                      ),
                      Text("of ${data.taskStats.countAllTasks().toString()}")
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        error: (err, s) =>
            ErrorDialog(errorObject: ErrorObject.mapErrorToObject(error: err)),
        loading: () => Center(child: CircularProgressIndicator()));
  }
}

List<PieChartSectionData> paiChartSelectionDatas = [
  PieChartSectionData(
      color: primaryColor,
      value: 25,
      showTitle: false,
      radius: 25,
      title: "STUDY"),
  PieChartSectionData(
    color: Color(0xFF26E5FF),
    value: 20,
    showTitle: false,
    radius: 22,
  ),
  PieChartSectionData(
    color: Color(0xFFFFCF26),
    value: 10,
    showTitle: false,
    radius: 19,
  ),
  PieChartSectionData(
    color: Color(0xFFEE2727),
    value: 15,
    showTitle: false,
    radius: 16,
  ),
  PieChartSectionData(
    color: primaryColor.withOpacity(0.1),
    value: 25,
    showTitle: false,
    radius: 13,
  ),
];
