import 'package:dio/dio.dart';
import 'package:todo/service/todo.api.dart';
import 'package:todo_api/todo_api.dart';

abstract class AbstractService<T> {
  final TodoAPI api = TodoAPI();

  Future<Response<PageTaskDTO>> findTasksByUserId({Pageable? pageable}) {
    // TODO: Please implement this method
    throw UnimplementedError();
  }

  Future<Response<TaskDTO>> addEntity(T t) {
    // TODO: Please implement this method
    throw UnimplementedError();
  }

  Future<Response<void>> updateEntity(T t) {
    // TODO: Please implement this method
    throw UnimplementedError();
  }

  Future<Response<DefaultResponse>> deleteTaskByIdAndUserId(int todoId) {
    // TODO: Please implement this method
    throw UnimplementedError();
  }

  Future<Response<DefaultResponse>> restoreSoftDeletedTask(int todoId) {
    // TODO: Please implement this method
    throw UnimplementedError();
  }
}
