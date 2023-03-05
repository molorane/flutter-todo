import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_api/todo_api.dart';

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

  void setDueDate(Date dueDate) {
    state = state.copyWith(dueDate: dueDate, whatChanged: "dueDate");
  }

  void setIsCompleted(bool isCompleted) {
    state =
        state.copyWith(isCompleted: isCompleted, whatChanged: "isCompleted");
  }

  void setStartDate(Date startDate) {
    state = state.copyWith(
        startDate: startDate, whatChanged: "startDate", endDate: null);
  }

  void setEndDate(Date endDate) {
    state = state.copyWith(endDate: endDate, whatChanged: "endDate");
  }

  TaskSearchDTO getSearchData() {
    TaskSearchDTOBuilder taskSearchDTOBuilder = TaskSearchDTOBuilder();
    taskSearchDTOBuilder.taskType = state.taskType;
    taskSearchDTOBuilder.description = state.description;
    taskSearchDTOBuilder.startDate = state.startDate;
    taskSearchDTOBuilder.endDate = state.endDate;
    taskSearchDTOBuilder.isCompleted = state.isCompleted;
    return taskSearchDTOBuilder.build();
  }

  TaskDTO getUpdateTaskData() {
    TaskDTOBuilder taskDTOBuilder = TaskDTOBuilder();
    taskDTOBuilder.taskType = state.taskType;
    taskDTOBuilder.description = state.description;
    taskDTOBuilder.dueDate = state.dueDate;
    taskDTOBuilder.isCompleted = state.isCompleted;
    return taskDTOBuilder.build();
  }

  TaskDTO getUpdateTaskDataWithID(int taskId) {
    TaskDTOBuilder taskDTOBuilder = TaskDTOBuilder();
    taskDTOBuilder.id = taskId;
    taskDTOBuilder.taskType = state.taskType;
    taskDTOBuilder.description = state.description;
    taskDTOBuilder.dueDate = state.dueDate;
    taskDTOBuilder.isCompleted = state.isCompleted;
    return taskDTOBuilder.build();
  }

  TaskDTO getAddTaskData() {
    TaskDTOBuilder taskDTOBuilder = TaskDTOBuilder();
    taskDTOBuilder.taskType = state.taskType;
    taskDTOBuilder.description = state.description;
    taskDTOBuilder.dueDate = state.dueDate;
    return taskDTOBuilder.build();
  }
}
