import 'package:http/http.dart';
import 'package:todo/service/impl/todo.service.impl.dart';
import 'package:todo/service/repository/todo.repository.dart';

import '../service/todo.service.dart';

class IocFactory {
  static TodoService? todoService;

  static TodoService getTodoService() {
    return todoService ??=
        TodoServiceImpl(TodoRepository(httpClient: Client()));
  }
}
