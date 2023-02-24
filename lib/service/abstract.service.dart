import 'package:todo/service/todo.api.dart';
import '../openapi/lib/api.dart';

abstract class AbstractService<T> {
  TodoAPI api = TodoAPI();

  Future<List<T>?> loadTopEntities() {
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

  Future<DefaultResponse?> deleteTodoByIdAndUserId(int todoId) {
    // TODO: Please implement this method
    throw UnimplementedError();
  }

  Future<DefaultResponse?> restoreSoftDeletedTodo(int todoId) {
    // TODO: Please implement this method
    throw UnimplementedError();
  }
}
