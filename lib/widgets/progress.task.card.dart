// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:todo/util/color.util.dart';

import '../util/math.util.dart';

class ProgressTaskCard extends StatelessWidget {
  final double percentage;
  final bool isCompleted;
  final Color cardColor;

  ProgressTaskCard(
      {required this.percentage,
      this.isCompleted = true,
      this.cardColor = const Color(0xFFB4B6B9),
      Key? key})
      : super(key: key);

  int getPercentage() {
    return (percentage * 100).round();
  }

  double percentageForProgressBar() {
    return MathUtil.roundDouble(percentage, 1);
  }

  String getPerformanceStatus() {
    return isCompleted
        ? getCompletedPerformanceStatus()
        : getInProgressPerformanceStatus();
  }

  String getInProgressPerformanceStatus() {
    int value = getPercentage();
    if (value == 0) {
      return "Wow! ${Emojis.icon_hundred_points} ${Emojis.hand_ok_hand}";
    } else if (value < 40) {
      return "Nice! ${Emojis.wheater_fire}";
    } else if (value < 50) {
      return "Improve ${Emojis.hand_thumbs_up}";
    } else if (value < 60) {
      return "Better ${Emojis.wheater_fire}";
    } else if (value < 80) {
      return "Poor ${Emojis.smile_worried_face}";
    } else if (value <= 99) {
      return "Work ${Emojis.smile_worried_face}";
    } else {
      return "Start ${Emojis.smile_smiling_face}";
    }
  }

  String getCompletedPerformanceStatus() {
    int value = getPercentage();
    if (value == 0) {
      return "No data ${Emojis.hand_raising_hands}";
    } else if (value < 40) {
      return "Low ${Emojis.smile_disappointed_face}";
    } else if (value < 50) {
      return "Better";
    } else if (value < 70) {
      return "Good ${Emojis.hand_oncoming_fist}";
    } else if (value < 80) {
      return "Nice! ${Emojis.hand_raising_hands}";
    } else {
      return "Wow!  ${Emojis.wheater_fire} ${Emojis.hand_raising_hands}";
    }
  }

  Color getProgressColor() {
    return isCompleted
        ? ColorUtil.getColorForCompleted(percentageForProgressBar())
        : ColorUtil.getColorForUncompleted(percentageForProgressBar());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      width: 200,
      height: 75,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Color(0xFFE4E5E8)),
      child: Row(
        children: [
          CircularPercentIndicator(
            radius: 30.0,
            lineWidth: 5.0,
            percent: percentageForProgressBar(),
            center: Text("${getPercentage()}%",
                style: TextStyle(
                    fontFamily: "Cerebri Sans",
                    fontWeight: FontWeight.w600,
                    fontSize: 14)),
            progressColor: getProgressColor(),
          ),
          SizedBox(
            width: 4,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Opacity(
                  opacity: 0.5,
                  child: Text(
                    isCompleted ? "Completed" : "In progress",
                    style: TextStyle(fontFamily: "Cerebri Sans"),
                  )),
              SizedBox(
                height: 2,
              ),
              Text(
                getPerformanceStatus(),
                style: TextStyle(
                    fontFamily: "Cerebri Sans",
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
