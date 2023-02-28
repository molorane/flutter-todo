import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/openapi/lib/api.dart';
import 'package:todo/service/todo.service.dart';

import '../pages/todo/notifier/todo.state.dart';
import '../service/impl/todo.service.impl.dart';

// Creating state notifier provider
final todoAddStateProvider =
    AsyncNotifierProvider<TodoAddStateNotifier, TodoState>(
        TodoAddStateNotifier.new);

// Creating Notifier
class TodoAddStateNotifier extends AsyncNotifier<TodoState> {
  final TodoService todoService = TodoServiceImpl();

  @override
  FutureOr<TodoState> build() async {
      return state.value!;
  }

  bool isStateConstructed() {
    return state.value != null;
  }

  // get all todos for today
  loadTodos(TodoSearchDTO todoSearchDTO) async {
    state = AsyncLoading();
    print(todoSearchDTO);
    AsyncValue<List<TodoDTO>?> av = await AsyncValue.guard(
        () async => todoService.searchTodos(todoSearchDTO));
    //state = AsyncData(state.value!.copyWith(searchResults: av.value!));
  }
}
