import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo/dataprovider/todos.dashboard.provider.dart';
import 'package:todo/openapi/lib/api.dart';
import 'package:todo/service/impl/todo.dashboard.service.impl.dart';
import 'package:todo/service/todo.dashboard.service.dart';
import 'package:todo/service/todo.service.dart';

import '../service/impl/todo.service.impl.dart';

// Import freezed file (maybe not yet generated)
part 'todos.by.type.provider.freezed.dart';

// Creating state where the freezed annotation will suggest that boilerplate code needs to be generated
@Freezed()
abstract class TodosByTypeState with _$TodosByTypeState {
  const factory TodosByTypeState(
      {@Default([]) List<TodoDTO> todos,
      @Default([]) List<TodoGroupCount> todoGroupCount,
      @Default([]) List<TodoCountToday> todoCountToday}) = _TodosByTypeState;

  const TodosByTypeState._();
}

// Creating state notifier provider
final todosByTypeStateProvider =
    AsyncNotifierProvider<TodosByTypeStateNotifier, TodosByTypeState>(
        TodosByTypeStateNotifier.new);

// () => TodosByTypeStateNotifier(selectedTodoType: TodoType.STUDY));

// Creating Notifier
class TodosByTypeStateNotifier extends AsyncNotifier<TodosByTypeState> {
  final TodoService todoService = TodoServiceImpl();
  final TodoDashboardService todoDashboardService = TodoDashboardServiceImpl();
  final todosDashboardStateProvider =
      AsyncNotifierProvider<TodosDashboardNotifier, TodosDashboardState>(
          TodosDashboardNotifier.new);

  TodosByTypeStateNotifier({this.selectedTodoType = TodoType.ENTERTAINMENT});

  final TodoType selectedTodoType;

  // load todos by type selected
  @override
  FutureOr<TodosByTypeState> build() async {
    final AsyncValue<List<TodoDTO>?> av = await getTodosByTodoType();
    final List<TodoDTO> list = av.value!;

    final AsyncValue<List<TodoGroupCount>?> todoGroups =
        await AsyncValue.guard(() => todoGroupCountByUserId());

    final AsyncValue<List<TodoCountToday>?> todoCountToday =
        await AsyncValue.guard(() => todoCountTodayByUserId());

    state = AsyncValue.data(TodosByTypeState());
    return state.value!.copyWith(
        todos: list,
        todoGroupCount: todoGroups.value!,
        todoCountToday: todoCountToday.value!);
  }

  Future<AsyncValue<List<TodoDTO>?>> getTodosByTodoType() async {
    //selectedTodoType = todosDashboardStateProvider.
    state = AsyncLoading();
    return AsyncValue.guard(
        () async => todoService.findTodosByUserIdAndTodoType(selectedTodoType));
  }

  Future<List<TodoGroupCount>?> todoGroupCountByUserId() {
    return todoDashboardService.todoGroupCountByUserId(
        todoType: selectedTodoType);
  }

  Future<List<TodoCountToday>?> todoCountTodayByUserId() {
    return todoDashboardService.todoCountTodayByUserId(
        todoType: selectedTodoType);
  }
}
