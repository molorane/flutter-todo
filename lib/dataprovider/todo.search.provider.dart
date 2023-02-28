import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo/openapi/lib/api.dart';
import 'package:todo/service/todo.service.dart';

import '../pages/todo/notifier/todo.state.dart';
import '../service/impl/todo.service.impl.dart';

part 'todo.search.provider.freezed.dart';

// Creating state where the freezed annotation will suggest that boilerplate code needs to be generated
@Freezed()
abstract class TodoSearchState with _$TodoSearchState {
  const factory TodoSearchState(
      {@Default(TodoState()) TodoState todoState,
      @Default([]) List<TodoDTO> searchResults}) = _TodoSearchState;

  const TodoSearchState._();
}

// Creating state notifier provider
final todoSearchStateProvider =
    AsyncNotifierProvider<TodoSearchStateNotifier, TodoSearchState>(
        TodoSearchStateNotifier.new);

// Creating Notifier
class TodoSearchStateNotifier extends AsyncNotifier<TodoSearchState> {
  final TodoService todoService = TodoServiceImpl();

  // loadTodos
  @override
  FutureOr<TodoSearchState> build() async {
    if (isStateConstructed()) {
      return state.value!;
    }

    state = AsyncValue.data(TodoSearchState());
    return state.value!;
  }

  bool isStateConstructed() {
    return state.value != null;
  }

  Future<AsyncValue<List<TodoDTO>?>> searchTodos() async {
    state = AsyncLoading();
    return AsyncValue.guard(() async => todoService.searchTodos(TodoSearchDTO(
        todoType: state.value!.todoState.todoType,
        isCompleted: state.value!.todoState.isCompleted,
        startDate: state.value!.todoState.startDate,
        endDate: state.value!.todoState.endDate,
        description: state.value!.todoState.description)));
  }

  // get all todos for today
  loadTodos(TodoSearchDTO todoSearchDTO) async {
    state = AsyncLoading();
    print(todoSearchDTO);
    AsyncValue<List<TodoDTO>?> av = await AsyncValue.guard(
        () async => todoService.searchTodos(todoSearchDTO));
    state = AsyncData(state.value!.copyWith(searchResults: av.value!));
  }
}
