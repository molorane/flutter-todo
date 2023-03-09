import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/pages/chart/widgets/task.status.card.dart';

import '../../../provider/tasks.dashboard.provider.dart';
import '../../errors/error.dialog.dart';
import '../../errors/error.object.dart';

class TaskStatusesContainer extends ConsumerWidget {
  TaskStatusesContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskDashboardStateData = ref.watch(tasksDashboardStateProvider);

    return taskDashboardStateData.when(
        data: (data) {
          return Column(
            children: [
              TaskStatusCard(
                svgSrc: 'assets/others/success.svg',
                title: "Completed",
                amountOfFiles: data.taskStats.countCompletedTasks().toString(),
                text: "",
              ),
              TaskStatusCard(
                svgSrc: 'assets/others/bill.svg',
                title: "In Progress",
                amountOfFiles: data.taskStats.countInProgressTasks().toString(),
                text: "",
              ),
              TaskStatusCard(
                svgSrc: 'assets/others/trash.svg',
                title: "Deleted",
                amountOfFiles: data.taskStats.deletedCount.toString(),
                text: "",
              )
            ],
          );
        },
        error: (err, s) =>
            ErrorDialog(errorObject: ErrorObject.mapErrorToObject(error: err)),
        loading: () => Center(child: CircularProgressIndicator()));
  }
}
