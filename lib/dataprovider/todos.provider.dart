import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo/openapi/lib/api.dart';
import 'package:todo/service/todo.service.dart';

import '../service/impl/todo.service.impl.dart';

// Import freezed file (maybe not yet generated)
part 'todos.provider.freezed.dart';

// Creating state where the freezed annotation will suggest that boilerplate code needs to be generated
@Freezed()
abstract class TodosState with _$TodosState {
  const factory TodosState({@Default([]) List<TodoDTO> todos}) = _TodosState;

  const TodosState._();
}

// Creating state notifier provider
final todosStateProvider =
    AsyncNotifierProvider<TodosStateNotifier, TodosState>(
        TodosStateNotifier.new);

// Creating Notifier
class TodosStateNotifier extends AsyncNotifier<TodosState> {
  final TodoService todoService = TodoServiceImpl();

  // loadTodos top 40 todos
  @override
  FutureOr<TodosState> build() async {
    final AsyncValue<List<TodoDTO>?> av = await getTop40Todos();
    final List<TodoDTO> list = av.value!;
    state = AsyncValue.data(TodosState());
    return state.value!.copyWith(todos: list);
  }

  loadTop40Todos() async {
    final AsyncValue<List<TodoDTO>?> av = await getTop40Todos();
    state = AsyncData(state.value!.copyWith(todos: av.value!));
  }

  Future<AsyncValue<List<TodoDTO>?>> getTop40Todos() async {
    state = AsyncLoading();
    return AsyncValue.guard(() async => todoService.loadTopEntities());
  }

  // get all todos for today
  getAllTodosForToday() async {
    state = AsyncLoading();
    AsyncValue<List<TodoDTO>?> av =
        await AsyncValue.guard(() => todoService.getAllTodosForToday());
    state = AsyncData(state.value!.copyWith(todos: av.value!));
  }

  // load todo by id
  Future<TodoDTO> findTodoById(int todoId) async {
    final todoData = await todoService.findTodoByIdAndUserId(todoId);
    return todoData!;
  }

  // delete todo by Id And userId
  Future<DefaultResponse> deleteTodoByIdAndUserId(int todoId) async {
    final todoData = await todoService.deleteTodoByIdAndUserId(todoId);
    return todoData!;
  }

  // restore soft deleted todo by Id And userId
  Future<DefaultResponse> restoreSoftDeletedTodo(int todoId) async {
    final todoData = await todoService.restoreSoftDeletedTodo(todoId);
    return todoData!;
  }

  // add todo
  addTodo(TodoDTO todo) async {
    final List<TodoDTO> list = List.from(state.value!.todos);
    list.insert(0, todo);
    print(list);
    state = AsyncData(state.value!.copyWith(todos: list));
  }

  // update todo
  void updateTodo(TodoDTO todo) async {
    await todoService.updateEntity(todo);
  }

  // find todo by id and user id
  Future<TodoDTO> findTodoByIdAndUserId(int todoId) async {
    final todo = await todoService.findTodoByIdAndUserId(todoId);
    return todo!;
  }

  // find todo by id and user id
  Future<TodoDTO> findTodosByUserIdAndTodoType(int todoId) async {
    final todo = await todoService.findTodoByIdAndUserId(todoId);
    return todo!;
  }
}
