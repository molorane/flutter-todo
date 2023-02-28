import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo/openapi/lib/api.dart';

part 'todo.state.freezed.dart';

@Freezed()
abstract class TodoState with _$TodoState {
  const factory TodoState({
    @Default(null) TodoType? todoType,
    @Default("") String description,
    @Default(null) DateTime? dueDate,
    @Default(false) bool isCompleted,
    @Default(null) DateTime? startDate,
    @Default(null) DateTime? endDate,
    @Default("") String whatChanged,
  }) = _TodoState;

  const TodoState._();
}
