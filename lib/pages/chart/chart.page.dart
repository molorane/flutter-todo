import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/pages/chart/widgets/task.chart.dart';
import 'package:todo/pages/chart/widgets/task.statuses.container.dart';

import '../../../constants.dart';
import '../../provider/tasks.dashboard.provider.dart';
import '../../theme/colors.dart';

class ChartPage extends ConsumerStatefulWidget {
  @override
  _ChartPage createState() => _ChartPage();
}

class _ChartPage extends ConsumerState<ChartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff5f7fa),
        body: Container(
            padding: EdgeInsets.all(ctPadding),
            decoration: BoxDecoration(
              color: ctContainer,
            ),
            child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Storage Details",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: ctPadding),
                    TaskChart(),
                    TaskStatusesContainer()
                  ],
                ))),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh_rounded),
          backgroundColor: navBar,
          onPressed: () {
            ref.read(tasksDashboardStateProvider.notifier).refresh();
          },
        ));
  }
}
