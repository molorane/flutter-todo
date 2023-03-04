import 'package:todo/service/task.api.dart';

import '../openapi/lib/api.dart';

abstract class AbstractService<T> {
  TaskAPI api = TaskAPI();

  Future<PageTaskDTO?> loadTopEntities({Pageable? pageable}) {
    // TODO: Please implement this method
    throw UnimplementedError();
  }

  Future<T?> addEntity(T t) {
    // TODO: Please implement this method
    throw UnimplementedError();
  }

  Future<void> updateEntity(T t) {
    // TODO: Please implement this method
    throw UnimplementedError();
  }

  Future<DefaultResponse?> deleteTaskByIdAndUserId(int todoId) {
    // TODO: Please implement this method
    throw UnimplementedError();
  }

  Future<DefaultResponse?> restoreSoftDeletedTask(int todoId) {
    // TODO: Please implement this method
    throw UnimplementedError();
  }
}
