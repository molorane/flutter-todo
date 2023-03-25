// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'task.state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TaskState {
  TaskType? get taskType => throw _privateConstructorUsedError;

  String get description => throw _privateConstructorUsedError;

  Date? get dueDate => throw _privateConstructorUsedError;

  bool get isCompleted => throw _privateConstructorUsedError;

  Date? get startDate => throw _privateConstructorUsedError;

  Date? get endDate => throw _privateConstructorUsedError;

  String get whatChanged => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TaskStateCopyWith<TaskState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskStateCopyWith<$Res> {
  factory $TaskStateCopyWith(TaskState value, $Res Function(TaskState) then) =
      _$TaskStateCopyWithImpl<$Res, TaskState>;

  @useResult
  $Res call(
      {TaskType? taskType,
      String description,
      Date? dueDate,
      bool isCompleted,
      Date? startDate,
      Date? endDate,
      String whatChanged});
}

/// @nodoc
class _$TaskStateCopyWithImpl<$Res, $Val extends TaskState>
    implements $TaskStateCopyWith<$Res> {
  _$TaskStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskType = freezed,
    Object? description = null,
    Object? dueDate = freezed,
    Object? isCompleted = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? whatChanged = null,
  }) {
    return _then(_value.copyWith(
      taskType: freezed == taskType
          ? _value.taskType
          : taskType // ignore: cast_nullable_to_non_nullable
              as TaskType?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as Date?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as Date?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as Date?,
      whatChanged: null == whatChanged
          ? _value.whatChanged
          : whatChanged // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TaskStateCopyWith<$Res> implements $TaskStateCopyWith<$Res> {
  factory _$$_TaskStateCopyWith(
          _$_TaskState value, $Res Function(_$_TaskState) then) =
      __$$_TaskStateCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call(
      {TaskType? taskType,
      String description,
      Date? dueDate,
      bool isCompleted,
      Date? startDate,
      Date? endDate,
      String whatChanged});
}

/// @nodoc
class __$$_TaskStateCopyWithImpl<$Res>
    extends _$TaskStateCopyWithImpl<$Res, _$_TaskState>
    implements _$$_TaskStateCopyWith<$Res> {
  __$$_TaskStateCopyWithImpl(
      _$_TaskState _value, $Res Function(_$_TaskState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskType = freezed,
    Object? description = null,
    Object? dueDate = freezed,
    Object? isCompleted = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? whatChanged = null,
  }) {
    return _then(_$_TaskState(
      taskType: freezed == taskType
          ? _value.taskType
          : taskType // ignore: cast_nullable_to_non_nullable
              as TaskType?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as Date?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as Date?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as Date?,
      whatChanged: null == whatChanged
          ? _value.whatChanged
          : whatChanged // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_TaskState extends _TaskState {
  const _$_TaskState(
      {this.taskType = null,
      this.description = "",
      this.dueDate = null,
      this.isCompleted = false,
      this.startDate = null,
      this.endDate = null,
      this.whatChanged = ""})
      : super._();

  @override
  @JsonKey()
  final TaskType? taskType;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final Date? dueDate;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  @JsonKey()
  final Date? startDate;
  @override
  @JsonKey()
  final Date? endDate;
  @override
  @JsonKey()
  final String whatChanged;

  @override
  String toString() {
    return 'TaskState(taskType: $taskType, description: $description, dueDate: $dueDate, isCompleted: $isCompleted, startDate: $startDate, endDate: $endDate, whatChanged: $whatChanged)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskState &&
            (identical(other.taskType, taskType) ||
                other.taskType == taskType) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.whatChanged, whatChanged) ||
                other.whatChanged == whatChanged));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taskType, description, dueDate,
      isCompleted, startDate, endDate, whatChanged);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskStateCopyWith<_$_TaskState> get copyWith =>
      __$$_TaskStateCopyWithImpl<_$_TaskState>(this, _$identity);
}

abstract class _TaskState extends TaskState {
  const factory _TaskState(
      {final TaskType? taskType,
      final String description,
      final Date? dueDate,
      final bool isCompleted,
      final Date? startDate,
      final Date? endDate,
      final String whatChanged}) = _$_TaskState;

  const _TaskState._() : super._();

  @override
  TaskType? get taskType;

  @override
  String get description;

  @override
  Date? get dueDate;

  @override
  bool get isCompleted;

  @override
  Date? get startDate;

  @override
  Date? get endDate;

  @override
  String get whatChanged;

  @override
  @JsonKey(ignore: true)
  _$$_TaskStateCopyWith<_$_TaskState> get copyWith =>
      throw _privateConstructorUsedError;
}
