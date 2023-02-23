import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/state/todo.notifier.dart';
import '../../state/todo.state.dart';

import '../openapi/lib/api.dart';


StateNotifierProvider<TodoNotifier, List<TodoState>> initTodoStateProvider(List<TodoState> todoStates) =>  StateNotifierProvider<TodoNotifier, List<TodoState>>((ref) {
  return TodoNotifier(tasks: todoStates);
});