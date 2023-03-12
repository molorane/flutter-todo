import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_api/todo_api.dart';

import '../../../constants.dart';
import '../../../provider/tasks.dashboard.provider.dart';
import '../../../theme/colors.dart';
import '../../../util/color.util.dart';
import '../../errors/error.dialog.dart';
import '../../errors/error.object.dart';

class TaskChart extends ConsumerWidget {
  TaskChart({super.key});

  Color getColor(double ratio) {
    return ColorUtil.getColorForCompleted(ratio);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskDashboardStateData = ref.watch(tasksDashboardStateProvider);

    return taskDashboardStateData.when(
        data: (data) {
          final List<PieChartSectionData> taskGroups = [];

          for (TaskType taskType in data.taskStats.groupTasks()) {
            taskGroups.add(PieChartSectionData(
                color: data.taskStats.getColor(taskType),
                value: data.taskStats
                    .countCompletedTasksByType(taskType)
                    .toDouble(),
                showTitle: true,
                radius: data.taskStats.getPercentage(taskType).toDouble(),
                title: taskType.name));
          }

          return SingleChildScrollView(
              child: SizedBox(
                    height: 150,
                    child: Stack(
                      children: [
                        PieChart(
                          PieChartData(
                            sectionsSpace: 4,
                            centerSpaceRadius: 50,
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
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: navBar,
                                ),
                              ),
                              Text("of ${data.taskStats.countAllTasks().toString()}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: navBar,
                                  )
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
        },
        error: (err, s) =>
            ErrorDialog(errorObject: ErrorObject.mapErrorToObject(error: err)),
        loading: () => Center(child: CircularProgressIndicator()));
  }
}
