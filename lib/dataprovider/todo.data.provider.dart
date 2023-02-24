import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/dataprovider/todo.service.provider.dart';
import 'package:todo/openapi/lib/api.dart';

final todoDataProvider = FutureProvider((ref) async {
  return ref.read(todoServiceProvider).getAllEntities();
});

final todoForTodayDataProvider = FutureProvider((ref) async {
  return ref.watch(todoServiceProvider).getAllTodosForToday();
});

addTodoDataProvider(TodoDTO todo) => FutureProvider((ref) async {
  return ref.watch(todoServiceProvider).addEntity(todo);
});

final updateTodoDataProvider = FutureProvider((ref) async {
  return ref.watch(todoServiceProvider).getAllTodosForToday();
});

todoByIdAndUserIdDataProvider(int todoId) => FutureProvider((ref) async {
  return ref.watch(todoServiceProvider).findTodoByIdAndUserId(todoId);
});
