// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tasks.by.type.provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TasksByTypeState {
  List<TaskDTO> get tasks => throw _privateConstructorUsedError;
  List<TaskGroupCount> get taskGroupCount => throw _privateConstructorUsedError;
  List<TaskCountToday> get taskCountToday => throw _privateConstructorUsedError;
  TaskType? get selectedTaskType => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TasksByTypeStateCopyWith<TasksByTypeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TasksByTypeStateCopyWith<$Res> {
  factory $TasksByTypeStateCopyWith(
          TasksByTypeState value, $Res Function(TasksByTypeState) then) =
      _$TasksByTypeStateCopyWithImpl<$Res, TasksByTypeState>;
  @useResult
  $Res call(
      {List<TaskDTO> tasks,
      List<TaskGroupCount> taskGroupCount,
      List<TaskCountToday> taskCountToday,
      TaskType? selectedTaskType});
}

/// @nodoc
class _$TasksByTypeStateCopyWithImpl<$Res, $Val extends TasksByTypeState>
    implements $TasksByTypeStateCopyWith<$Res> {
  _$TasksByTypeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
    Object? taskGroupCount = null,
    Object? taskCountToday = null,
    Object? selectedTaskType = freezed,
  }) {
    return _then(_value.copyWith(
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<TaskDTO>,
      taskGroupCount: null == taskGroupCount
          ? _value.taskGroupCount
          : taskGroupCount // ignore: cast_nullable_to_non_nullable
              as List<TaskGroupCount>,
      taskCountToday: null == taskCountToday
          ? _value.taskCountToday
          : taskCountToday // ignore: cast_nullable_to_non_nullable
              as List<TaskCountToday>,
      selectedTaskType: freezed == selectedTaskType
          ? _value.selectedTaskType
          : selectedTaskType // ignore: cast_nullable_to_non_nullable
              as TaskType?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TasksByTypeStateCopyWith<$Res>
    implements $TasksByTypeStateCopyWith<$Res> {
  factory _$$_TasksByTypeStateCopyWith(
          _$_TasksByTypeState value, $Res Function(_$_TasksByTypeState) then) =
      __$$_TasksByTypeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TaskDTO> tasks,
      List<TaskGroupCount> taskGroupCount,
      List<TaskCountToday> taskCountToday,
      TaskType? selectedTaskType});
}

/// @nodoc
class __$$_TasksByTypeStateCopyWithImpl<$Res>
    extends _$TasksByTypeStateCopyWithImpl<$Res, _$_TasksByTypeState>
    implements _$$_TasksByTypeStateCopyWith<$Res> {
  __$$_TasksByTypeStateCopyWithImpl(
      _$_TasksByTypeState _value, $Res Function(_$_TasksByTypeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
    Object? taskGroupCount = null,
    Object? taskCountToday = null,
    Object? selectedTaskType = freezed,
  }) {
    return _then(_$_TasksByTypeState(
      tasks: null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<TaskDTO>,
      taskGroupCount: null == taskGroupCount
          ? _value._taskGroupCount
          : taskGroupCount // ignore: cast_nullable_to_non_nullable
              as List<TaskGroupCount>,
      taskCountToday: null == taskCountToday
          ? _value._taskCountToday
          : taskCountToday // ignore: cast_nullable_to_non_nullable
              as List<TaskCountToday>,
      selectedTaskType: freezed == selectedTaskType
          ? _value.selectedTaskType
          : selectedTaskType // ignore: cast_nullable_to_non_nullable
              as TaskType?,
    ));
  }
}

/// @nodoc

class _$_TasksByTypeState extends _TasksByTypeState {
  const _$_TasksByTypeState(
      {final List<TaskDTO> tasks = const [],
      final List<TaskGroupCount> taskGroupCount = const [],
      final List<TaskCountToday> taskCountToday = const [],
      this.selectedTaskType = null})
      : _tasks = tasks,
        _taskGroupCount = taskGroupCount,
        _taskCountToday = taskCountToday,
        super._();

  final List<TaskDTO> _tasks;
  @override
  @JsonKey()
  List<TaskDTO> get tasks {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  final List<TaskGroupCount> _taskGroupCount;
  @override
  @JsonKey()
  List<TaskGroupCount> get taskGroupCount {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taskGroupCount);
  }

  final List<TaskCountToday> _taskCountToday;
  @override
  @JsonKey()
  List<TaskCountToday> get taskCountToday {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taskCountToday);
  }

  @override
  @JsonKey()
  final TaskType? selectedTaskType;

  @override
  String toString() {
    return 'TasksByTypeState(tasks: $tasks, taskGroupCount: $taskGroupCount, taskCountToday: $taskCountToday, selectedTaskType: $selectedTaskType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TasksByTypeState &&
            const DeepCollectionEquality().equals(other._tasks, _tasks) &&
            const DeepCollectionEquality()
                .equals(other._taskGroupCount, _taskGroupCount) &&
            const DeepCollectionEquality()
                .equals(other._taskCountToday, _taskCountToday) &&
            (identical(other.selectedTaskType, selectedTaskType) ||
                other.selectedTaskType == selectedTaskType));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tasks),
      const DeepCollectionEquality().hash(_taskGroupCount),
      const DeepCollectionEquality().hash(_taskCountToday),
      selectedTaskType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TasksByTypeStateCopyWith<_$_TasksByTypeState> get copyWith =>
      __$$_TasksByTypeStateCopyWithImpl<_$_TasksByTypeState>(this, _$identity);
}

abstract class _TasksByTypeState extends TasksByTypeState {
  const factory _TasksByTypeState(
      {final List<TaskDTO> tasks,
      final List<TaskGroupCount> taskGroupCount,
      final List<TaskCountToday> taskCountToday,
      final TaskType? selectedTaskType}) = _$_TasksByTypeState;
  const _TasksByTypeState._() : super._();

  @override
  List<TaskDTO> get tasks;
  @override
  List<TaskGroupCount> get taskGroupCount;
  @override
  List<TaskCountToday> get taskCountToday;
  @override
  TaskType? get selectedTaskType;
  @override
  @JsonKey(ignore: true)
  _$$_TasksByTypeStateCopyWith<_$_TasksByTypeState> get copyWith =>
      throw _privateConstructorUsedError;
}
