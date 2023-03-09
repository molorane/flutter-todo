import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/constants.dart';
import 'package:todo/pages/dashboard/widgets/task.info.card.dart';

import '../../../provider/tasks.dashboard.provider.dart';
import '../../errors/error.dialog.dart';
import '../../errors/error.object.dart';

class TaskGroupsContainer extends ConsumerWidget {
  const TaskGroupsContainer({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  Future<void> onRefreshList() async {
    //ref.read(tasksDashboardStateProvider.notifier).findTasksByUserId();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskDashboardStateData = ref.watch(tasksDashboardStateProvider);

    return taskDashboardStateData.when(
        data: (data) {
          return RefreshIndicator(
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.taskStats.groupTasks().length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: ctPadding,
                  mainAxisSpacing: ctPadding,
                  childAspectRatio: childAspectRatio,
                ),
                itemBuilder: (context, index) => TaskInfoCard(
                    taskType: data.taskStats.groupTasks().elementAt(index),
                    completed: data.taskStats.countCompletedTasksByType(
                        data.taskStats.groupTasks().elementAt(index)),
                    totalByTaskType: data.taskStats.countTasksByType(
                        data.taskStats.groupTasks().elementAt(index))),
              ),
              onRefresh: onRefreshList);
        },
        error: (err, s) =>
            ErrorDialog(errorObject: ErrorObject.mapErrorToObject(error: err)),
        loading: () => Center(child: CircularProgressIndicator()));
  }
}
