import 'package:todo/openapi/lib/api.dart';

import '../../../util/todo.stats.dart';

class ScreenArguments {
  final TodoStats todoStats;
  final TodoType todoType;

  ScreenArguments(this.todoStats, this.todoType);
}
