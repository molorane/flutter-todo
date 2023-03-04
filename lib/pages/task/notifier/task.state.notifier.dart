import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../openapi/lib/api.dart';
import 'task.state.dart';

final taskStateProvider =
    StateNotifierProvider<TaskStateNotifier, TaskState>((ref) {
  return TaskStateNotifier(taskState: TaskState());
});

class TaskStateNotifier extends StateNotifier<TaskState> {
  TaskStateNotifier({required TaskState taskState}) : super(taskState);

  void setTaskType(TaskType taskType) {
    state = state.copyWith(taskType: taskType, whatChanged: "taskType");
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

  TaskSearchDTO getSearchData() {
    return TaskSearchDTO(
        taskType: state.taskType,
        isCompleted: state.isCompleted,
        startDate: state.startDate,
        endDate: state.endDate,
        description: state.description);
  }

  TaskDTO getUpdateTaskData() {
    return TaskDTO(
        taskType: state.taskType,
        description: state.description,
        dueDate: state.dueDate,
        isCompleted: state.isCompleted);
  }

  TaskDTO getAddTaskData() {
    return TaskDTO(
        taskType: state.taskType,
        dueDate: state.dueDate,
        description: state.description);
  }
}
