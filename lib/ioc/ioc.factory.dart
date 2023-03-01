import 'package:todo/service/impl/todo.dashboard.service.impl.dart';
import 'package:todo/service/impl/todo.service.impl.dart';

import '../service/todo.dashboard.service.dart';
import '../service/todo.service.dart';

class IocFactory {
  static TodoService? todoService;
  static TodoDashboardService? todoDashboardService;

  static TodoService getTodoService() {
    return todoService = TodoServiceImpl();
  }

  static TodoDashboardService getTodoDashboardService() {
    return todoDashboardService = TodoDashboardServiceImpl();
  }
}
