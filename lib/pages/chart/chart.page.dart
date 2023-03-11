import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo/pages/chart/pie.chart.sample.dart';
import 'package:todo/pages/chart/widgets/task.chart.dart';
import 'package:todo/pages/chart/widgets/task.statuses.container.dart';

import '../../../constants.dart';
import '../../provider/tasks.dashboard.provider.dart';
import '../../theme/colors.dart';
import 'bar.chart.sample.dart';
import 'line.chart.sample.dart';

class ChartPage extends ConsumerStatefulWidget {
  static const String routeName = "/home";

  @override
  _ChartPage createState() => _ChartPage();
}

class _ChartPage extends ConsumerState<ChartPage> {
  final String title = "Pie Chart Summary";

  final pageController = PageController();

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
                    Expanded(
                      child: PageView(
                        scrollDirection: Axis.horizontal,
                        physics: ClampingScrollPhysics(),
                        controller: pageController,
                        children: [
                          Column(children: [
                            Center(
                              child: Text(
                                title.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: ctPadding),
                            TaskChart(),
                            TaskStatusesContainer()
                          ]),
                          PieChartSample(),
                          BarChartSample(),
                          LineChartSample(isShowingMainData: false)
                        ],
                      ),
                    ),
                    Center(
                        child: SmoothPageIndicator(
                            controller: pageController, count: 4))
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
