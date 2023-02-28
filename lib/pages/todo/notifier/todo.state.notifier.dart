import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/openapi/lib/api.dart';

import 'todo.state.dart';

class TodoStateNotifier extends StateNotifier<TodoState> {
  TodoStateNotifier({required TodoState todoState}) : super(todoState);

  void setTodoType(TodoType todoType) {
    state = state.copyWith(todoType: todoType, whatChanged: "todoType");
  }

  void setDescription(String description) {
    state =
        state.copyWith(description: description, whatChanged: "description");
  }

  void setDueDate(DateTime dueDate) {
    state = state.copyWith(dueDate: dueDate, whatChanged: "dueDate");
  }

  void setIsCompleted(bool isCompleted) {
    state =
        state.copyWith(isCompleted: isCompleted, whatChanged: "isCompleted");
  }

  void setStartDate(DateTime startDate) {
    state = state.copyWith(
        startDate: startDate, whatChanged: "startDate", endDate: null);
  }

  void setEndDate(DateTime endDate) {
    state = state.copyWith(endDate: endDate, whatChanged: "endDate");
  }

  TodoSearchDTO getSearchData() {
    return TodoSearchDTO(
        todoType: state.todoType,
        isCompleted: state.isCompleted,
        startDate: state.startDate,
        endDate: state.endDate,
        description: state.description);
  }

  TodoDTO getTodoData() {
    return TodoDTO(
        todoType: state.todoType,
        dueDate: state.dueDate,
        description: state.description);
  }
}
