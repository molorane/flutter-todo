import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/pages/chart/widgets/chart.colors.dart';
import 'package:todo_api/todo_api.dart';

import '../../provider/tasks.dashboard.provider.dart';
import '../../util/color.util.dart';
import '../errors/error.dialog.dart';
import '../errors/error.object.dart';

class PieChartSample extends ConsumerStatefulWidget {
  @override
  _PieChartSample createState() => _PieChartSample();
}

class _PieChartSample extends ConsumerState<PieChartSample> {
  int touchedIndex = -1;

  Color getColor(double ratio) {
    return ColorUtil.getColorForCompleted(ratio);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 1),
            child: AspectRatio(
              aspectRatio: 1.3,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections(),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }

  List<PieChartSectionData> showingSections() {
    int counter = 0;
    final List<PieChartSectionData> taskGroups = [];
    ref.watch(tasksDashboardStateProvider).when(
        data: (data) {
          for (TaskType taskType in data.taskStats.groupTasks()) {
            final isTouched = counter == touchedIndex;
            final fontSize = isTouched ? 25.0 : 16.0;
            final radius = isTouched ? 70.0 : 50.0;
            const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
            taskGroups.add(PieChartSectionData(
                color: data.taskStats.getColor(taskType),
                value: data.taskStats.getPercentage(taskType).toDouble(),
                title: '${data.taskStats.getPercentage(taskType)}%',
                showTitle: true,
                radius: radius,
                titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: ChartColors.mainTextColor1,
                  shadows: shadows,
                )));
            counter++;
          }
        },
        error: (err, s) =>
            ErrorDialog(errorObject: ErrorObject.mapErrorToObject(error: err)),
        loading: () => Center(child: CircularProgressIndicator()));
    return taskGroups;
  }
}
