import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo/openapi/lib/api.dart';
import 'package:todo/service/todo.service.dart';

import '../service/impl/todo.service.impl.dart';

// Import freezed file (maybe not yet generated)
part 'todo.provider.freezed.dart';

// Creating state where the freezed annotation will suggest that boilerplate code needs to be generated
@Freezed()
abstract class TodoState with _$TodoState {
  const factory TodoState({@Default([]) List<TodoDTO> todos}) = _TodoState;

  const TodoState._();
}

// Creating state notifier provider
final todoStateProvider =
    StateNotifierProvider<TodoNotifier, AsyncValue<TodoState>>(
        (ref) => TodoNotifier());

// Creating Notifier
class TodoNotifier extends StateNotifier<AsyncValue<TodoState>> {
  final TodoService todoService = TodoServiceImpl();

  // Notifier constructor - call functions on provider initialization
  TodoNotifier() : super(AsyncLoading()) {
    loadTop40Todos();
  }

  // loadTodos top 40 todos
  void loadTop40Todos() async {
    state = AsyncLoading();
    final AsyncValue<List<TodoDTO>?> av =
        await AsyncValue.guard(() => todoService.getAllEntities());
    final List<TodoDTO> list = av.value!;
    state = AsyncData(TodoState());
    state = AsyncData(state.value!.copyWith(todos: list));
  }

  // loadTodo by id
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

  // addTodo
  void addTodo(TodoDTO todo) async {
    await todoService.addEntity(todo);
  }

  // updateTodo
  void updateTodo(TodoDTO todo) async {
    await todoService.updateEntity(todo);
  }

  // get all todos for today
  void getAllTodosForToday() async {
    state = AsyncValue.loading();
    Future<AsyncValue<List<TodoDTO>?>> av =
        AsyncValue.guard(() => todoService.getAllTodosForToday());
    av.then((value) => {
          state = AsyncData(state.value!.copyWith(todos: value.asData!.value!))
        });
  }

  // find todo by id and user id
  Future<TodoDTO> findTodoByIdAndUserId(int todoId) async {
    final todo = await todoService.findTodoByIdAndUserId(todoId);
    return todo!;
  }
}
