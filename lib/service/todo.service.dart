import 'package:todo/openapi/lib/api.dart';
import 'package:todo/service/todo.api.dart';

import 'abstract.service.dart';

abstract class TodoService extends AbstractService<TodoDTO> {
  TodoAPI api = TodoAPI();
}
