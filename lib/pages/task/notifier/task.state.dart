import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_api/todo_api.dart';

part 'task.state.freezed.dart';

@Freezed()
abstract class TaskState with _$TaskState {
  const factory TaskState({
    @Default(null) TaskType? taskType,
    @Default("") String description,
    @Default(null) Date? dueDate,
    @Default(false) bool isCompleted,
    @Default(null) Date? startDate,
    @Default(null) Date? endDate,
    @Default("") String whatChanged,
  }) = _TaskState;

  const TaskState._();
}
