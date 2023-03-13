// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tasks.provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TasksState {
  List<TaskDTO> get tasks => throw _privateConstructorUsedError;
  PageData get pageData => throw _privateConstructorUsedError;
  List<TaskDTO> get pageDataList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TasksStateCopyWith<TasksState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TasksStateCopyWith<$Res> {
  factory $TasksStateCopyWith(
          TasksState value, $Res Function(TasksState) then) =
      _$TasksStateCopyWithImpl<$Res, TasksState>;
  @useResult
  $Res call(
      {List<TaskDTO> tasks, PageData pageData, List<TaskDTO> pageDataList});
}

/// @nodoc
class _$TasksStateCopyWithImpl<$Res, $Val extends TasksState>
    implements $TasksStateCopyWith<$Res> {
  _$TasksStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
    Object? pageData = null,
    Object? pageDataList = null,
  }) {
    return _then(_value.copyWith(
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<TaskDTO>,
      pageData: null == pageData
          ? _value.pageData
          : pageData // ignore: cast_nullable_to_non_nullable
              as PageData,
      pageDataList: null == pageDataList
          ? _value.pageDataList
          : pageDataList // ignore: cast_nullable_to_non_nullable
              as List<TaskDTO>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TasksStateCopyWith<$Res>
    implements $TasksStateCopyWith<$Res> {
  factory _$$_TasksStateCopyWith(
          _$_TasksState value, $Res Function(_$_TasksState) then) =
      __$$_TasksStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TaskDTO> tasks, PageData pageData, List<TaskDTO> pageDataList});
}

/// @nodoc
class __$$_TasksStateCopyWithImpl<$Res>
    extends _$TasksStateCopyWithImpl<$Res, _$_TasksState>
    implements _$$_TasksStateCopyWith<$Res> {
  __$$_TasksStateCopyWithImpl(
      _$_TasksState _value, $Res Function(_$_TasksState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
    Object? pageData = null,
    Object? pageDataList = null,
  }) {
    return _then(_$_TasksState(
      tasks: null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<TaskDTO>,
      pageData: null == pageData
          ? _value.pageData
          : pageData // ignore: cast_nullable_to_non_nullable
              as PageData,
      pageDataList: null == pageDataList
          ? _value._pageDataList
          : pageDataList // ignore: cast_nullable_to_non_nullable
              as List<TaskDTO>,
    ));
  }
}

/// @nodoc

class _$_TasksState extends _TasksState {
  const _$_TasksState(
      {final List<TaskDTO> tasks = const [],
      this.pageData = const PageData(),
      final List<TaskDTO> pageDataList = const []})
      : _tasks = tasks,
        _pageDataList = pageDataList,
        super._();

  final List<TaskDTO> _tasks;
  @override
  @JsonKey()
  List<TaskDTO> get tasks {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  @override
  @JsonKey()
  final PageData pageData;
  final List<TaskDTO> _pageDataList;
  @override
  @JsonKey()
  List<TaskDTO> get pageDataList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pageDataList);
  }

  @override
  String toString() {
    return 'TasksState(tasks: $tasks, pageData: $pageData, pageDataList: $pageDataList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TasksState &&
            const DeepCollectionEquality().equals(other._tasks, _tasks) &&
            (identical(other.pageData, pageData) ||
                other.pageData == pageData) &&
            const DeepCollectionEquality()
                .equals(other._pageDataList, _pageDataList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tasks),
      pageData,
      const DeepCollectionEquality().hash(_pageDataList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TasksStateCopyWith<_$_TasksState> get copyWith =>
      __$$_TasksStateCopyWithImpl<_$_TasksState>(this, _$identity);
}

abstract class _TasksState extends TasksState {
  const factory _TasksState(
      {final List<TaskDTO> tasks,
      final PageData pageData,
      final List<TaskDTO> pageDataList}) = _$_TasksState;
  const _TasksState._() : super._();

  @override
  List<TaskDTO> get tasks;
  @override
  PageData get pageData;
  @override
  List<TaskDTO> get pageDataList;
  @override
  @JsonKey(ignore: true)
  _$$_TasksStateCopyWith<_$_TasksState> get copyWith =>
      throw _privateConstructorUsedError;
}
