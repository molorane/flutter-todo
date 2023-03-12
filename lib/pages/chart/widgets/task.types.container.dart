import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/pages/chart/widgets/task.status.card.dart';
import 'package:todo/pages/chart/widgets/task.type.card.dart';
import 'package:todo_api/todo_api.dart';

import '../../../provider/tasks.dashboard.provider.dart';
import '../../../util/color.util.dart';
import '../../errors/error.dialog.dart';
import '../../errors/error.object.dart';

class TaskTypesContainer extends ConsumerWidget {
  TaskTypesContainer({super.key});

  Color getColor(double ratio) {
    return ColorUtil.getColorForCompleted(ratio);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskDashboardStateData = ref.watch(tasksDashboardStateProvider);

    return taskDashboardStateData.when(
        data: (data) {

          final List<Widget> taskTypes = [];
          for (TaskType taskType in data.taskStats.groupTasks()) {
            taskTypes.add(
                TaskTypeCard(
                  taskType: taskType,
                  completed: data.taskStats.countCompletedTasksByType(taskType),
                  color: data.taskStats.getColor(taskType),
                )
            );
          }
          return Column(
            children: taskTypes,
          );
        },
        error: (err, s) =>
            ErrorDialog(errorObject: ErrorObject.mapErrorToObject(error: err)),
        loading: () => Center(child: CircularProgressIndicator()));
  }
}
