
import 'package:todo/openapi/lib/api.dart';

import '../../../util/todo.stats.dart';

class ScreenArguments {
  final TodoStats todoStats;
  final TodoDTOTodoTypeEnum todoType;

  ScreenArguments(this.todoStats, this.todoType);
}