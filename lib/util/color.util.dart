import 'package:flutter/material.dart';

import '../theme/colors.dart';
import 'math.util.dart';

class ColorUtil {
  static Color getColor(double value) {
    double percentage = MathUtil.roundDouble(value, 1);
    if (percentage == 0.1) {
      return Colors.redAccent;
    } else if (percentage == 0.2) {
      return Colors.orange;
    } else if (percentage >= 0.3 && percentage <= 0.4) {
      return Colors.amber;
    } else if (percentage == 0.5) {
      return darkGray;
    } else if (percentage == 0.6) {
      return completedTaskArrow;
    } else if (percentage >= 0.7 && percentage <= 0.8) {
      return Colors.lightGreen;
    } else if (percentage == 0.9) {
      return Colors.green;
    } else {
      return Colors.green;
    }
  }
}
