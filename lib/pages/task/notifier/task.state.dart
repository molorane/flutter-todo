import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo/openapi/lib/api.dart';

part 'task.state.freezed.dart';

@Freezed()
abstract class TaskState with _$TaskState {
  const factory TaskState({
    @Default(null) TaskType? taskType,
    @Default("") String description,
    @Default(null) DateTime? dueDate,
    @Default(false) bool isCompleted,
    @Default(null) DateTime? startDate,
    @Default(null) DateTime? endDate,
    @Default("") String whatChanged,
  }) = _TaskState;

  const TaskState._();
}
