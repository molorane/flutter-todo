import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/dataprovider/todo.provider.dart';

final todoDataProvider = FutureProvider((ref) async {
  return ref.watch(todoProvider).getAllEntities();
});

final todoForTodayDataProvider = FutureProvider((ref) async {
  return ref.watch(todoProvider).getAllTodosForToday();
});
