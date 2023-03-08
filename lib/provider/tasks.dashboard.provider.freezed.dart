// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tasks.dashboard.provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TasksDashboardState {
  TaskStats get taskStats => throw _privateConstructorUsedError;
  TaskType? get selectedTaskType => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TasksDashboardStateCopyWith<TasksDashboardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TasksDashboardStateCopyWith<$Res> {
  factory $TasksDashboardStateCopyWith(
          TasksDashboardState value, $Res Function(TasksDashboardState) then) =
      _$TasksDashboardStateCopyWithImpl<$Res, TasksDashboardState>;
  @useResult
  $Res call({TaskStats taskStats, TaskType? selectedTaskType});
}

/// @nodoc
class _$TasksDashboardStateCopyWithImpl<$Res, $Val extends TasksDashboardState>
    implements $TasksDashboardStateCopyWith<$Res> {
  _$TasksDashboardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskStats = null,
    Object? selectedTaskType = freezed,
  }) {
    return _then(_value.copyWith(
      taskStats: null == taskStats
          ? _value.taskStats
          : taskStats // ignore: cast_nullable_to_non_nullable
              as TaskStats,
      selectedTaskType: freezed == selectedTaskType
          ? _value.selectedTaskType
          : selectedTaskType // ignore: cast_nullable_to_non_nullable
              as TaskType?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TasksDashboardStateCopyWith<$Res>
    implements $TasksDashboardStateCopyWith<$Res> {
  factory _$$_TasksDashboardStateCopyWith(_$_TasksDashboardState value,
          $Res Function(_$_TasksDashboardState) then) =
      __$$_TasksDashboardStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TaskStats taskStats, TaskType? selectedTaskType});
}

/// @nodoc
class __$$_TasksDashboardStateCopyWithImpl<$Res>
    extends _$TasksDashboardStateCopyWithImpl<$Res, _$_TasksDashboardState>
    implements _$$_TasksDashboardStateCopyWith<$Res> {
  __$$_TasksDashboardStateCopyWithImpl(_$_TasksDashboardState _value,
      $Res Function(_$_TasksDashboardState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskStats = null,
    Object? selectedTaskType = freezed,
  }) {
    return _then(_$_TasksDashboardState(
      taskStats: null == taskStats
          ? _value.taskStats
          : taskStats // ignore: cast_nullable_to_non_nullable
              as TaskStats,
      selectedTaskType: freezed == selectedTaskType
          ? _value.selectedTaskType
          : selectedTaskType // ignore: cast_nullable_to_non_nullable
              as TaskType?,
    ));
  }
}

/// @nodoc

class _$_TasksDashboardState extends _TasksDashboardState {
  const _$_TasksDashboardState(
      {this.taskStats = const TaskStats(), this.selectedTaskType = null})
      : super._();

  @override
  @JsonKey()
  final TaskStats taskStats;
  @override
  @JsonKey()
  final TaskType? selectedTaskType;

  @override
  String toString() {
    return 'TasksDashboardState(taskStats: $taskStats, selectedTaskType: $selectedTaskType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TasksDashboardState &&
            (identical(other.taskStats, taskStats) ||
                other.taskStats == taskStats) &&
            (identical(other.selectedTaskType, selectedTaskType) ||
                other.selectedTaskType == selectedTaskType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taskStats, selectedTaskType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TasksDashboardStateCopyWith<_$_TasksDashboardState> get copyWith =>
      __$$_TasksDashboardStateCopyWithImpl<_$_TasksDashboardState>(
          this, _$identity);
}

abstract class _TasksDashboardState extends TasksDashboardState {
  const factory _TasksDashboardState(
      {final TaskStats taskStats,
      final TaskType? selectedTaskType}) = _$_TasksDashboardState;
  const _TasksDashboardState._() : super._();

  @override
  TaskStats get taskStats;
  @override
  TaskType? get selectedTaskType;
  @override
  @JsonKey(ignore: true)
  _$$_TasksDashboardStateCopyWith<_$_TasksDashboardState> get copyWith =>
      throw _privateConstructorUsedError;
}
