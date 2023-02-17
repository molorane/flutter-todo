import 'package:todo/service/todo.api.dart';

import '../api.dart';

abstract class AbstractService<T> {
  TodoAPI api = TodoAPI();

  Future<List<T>?> getAllEntities() {
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

  Future<DefaultResponse?> deleteEntityById(int todoId) {
    // TODO: Please implement this method
    throw UnimplementedError();
  }

  Future<DefaultResponse?> undoSoftDeletedEntity(int todoId) {
    // TODO: Please implement this method
    throw UnimplementedError();
  }
}
