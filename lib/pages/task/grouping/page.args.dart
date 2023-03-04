import 'package:todo/openapi/lib/api.dart';

import '../../../util/task.stats.dart';

class ScreenArguments {
  final TaskStats todoStats;
  final TaskType todoType;

  ScreenArguments(this.todoStats, this.todoType);
}
