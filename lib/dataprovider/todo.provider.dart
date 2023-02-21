import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/service/impl/todo.service.impl.dart';

final todoDataProvider = FutureProvider((ref) async {
  return ref.watch(todoProvider).getAllEntities();
});

final todoForTodayDataProvider = FutureProvider((ref) async {
  return ref.watch(todoProvider).getAllTodosForToday();
});
