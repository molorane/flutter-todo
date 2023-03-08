// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'task.search.provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TaskSearchState {
  TaskState get taskState => throw _privateConstructorUsedError;
  PageData get pageData => throw _privateConstructorUsedError;
  List<TaskDTO> get pageDataList => throw _privateConstructorUsedError;
  List<TaskDTO> get searchResults => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TaskSearchStateCopyWith<TaskSearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskSearchStateCopyWith<$Res> {
  factory $TaskSearchStateCopyWith(
          TaskSearchState value, $Res Function(TaskSearchState) then) =
      _$TaskSearchStateCopyWithImpl<$Res, TaskSearchState>;
  @useResult
  $Res call(
      {TaskState taskState,
      PageData pageData,
      List<TaskDTO> pageDataList,
      List<TaskDTO> searchResults});

  $TaskStateCopyWith<$Res> get taskState;
}

/// @nodoc
class _$TaskSearchStateCopyWithImpl<$Res, $Val extends TaskSearchState>
    implements $TaskSearchStateCopyWith<$Res> {
  _$TaskSearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskState = null,
    Object? pageData = null,
    Object? pageDataList = null,
    Object? searchResults = null,
  }) {
    return _then(_value.copyWith(
      taskState: null == taskState
          ? _value.taskState
          : taskState // ignore: cast_nullable_to_non_nullable
              as TaskState,
      pageData: null == pageData
          ? _value.pageData
          : pageData // ignore: cast_nullable_to_non_nullable
              as PageData,
      pageDataList: null == pageDataList
          ? _value.pageDataList
          : pageDataList // ignore: cast_nullable_to_non_nullable
              as List<TaskDTO>,
      searchResults: null == searchResults
          ? _value.searchResults
          : searchResults // ignore: cast_nullable_to_non_nullable
              as List<TaskDTO>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TaskStateCopyWith<$Res> get taskState {
    return $TaskStateCopyWith<$Res>(_value.taskState, (value) {
      return _then(_value.copyWith(taskState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TaskSearchStateCopyWith<$Res>
    implements $TaskSearchStateCopyWith<$Res> {
  factory _$$_TaskSearchStateCopyWith(
          _$_TaskSearchState value, $Res Function(_$_TaskSearchState) then) =
      __$$_TaskSearchStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TaskState taskState,
      PageData pageData,
      List<TaskDTO> pageDataList,
      List<TaskDTO> searchResults});

  @override
  $TaskStateCopyWith<$Res> get taskState;
}

/// @nodoc
class __$$_TaskSearchStateCopyWithImpl<$Res>
    extends _$TaskSearchStateCopyWithImpl<$Res, _$_TaskSearchState>
    implements _$$_TaskSearchStateCopyWith<$Res> {
  __$$_TaskSearchStateCopyWithImpl(
      _$_TaskSearchState _value, $Res Function(_$_TaskSearchState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskState = null,
    Object? pageData = null,
    Object? pageDataList = null,
    Object? searchResults = null,
  }) {
    return _then(_$_TaskSearchState(
      taskState: null == taskState
          ? _value.taskState
          : taskState // ignore: cast_nullable_to_non_nullable
              as TaskState,
      pageData: null == pageData
          ? _value.pageData
          : pageData // ignore: cast_nullable_to_non_nullable
              as PageData,
      pageDataList: null == pageDataList
          ? _value._pageDataList
          : pageDataList // ignore: cast_nullable_to_non_nullable
              as List<TaskDTO>,
      searchResults: null == searchResults
          ? _value._searchResults
          : searchResults // ignore: cast_nullable_to_non_nullable
              as List<TaskDTO>,
    ));
  }
}

/// @nodoc

class _$_TaskSearchState extends _TaskSearchState {
  const _$_TaskSearchState(
      {this.taskState = const TaskState(),
      this.pageData = const PageData(),
      final List<TaskDTO> pageDataList = const [],
      final List<TaskDTO> searchResults = const []})
      : _pageDataList = pageDataList,
        _searchResults = searchResults,
        super._();

  @override
  @JsonKey()
  final TaskState taskState;
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

  final List<TaskDTO> _searchResults;
  @override
  @JsonKey()
  List<TaskDTO> get searchResults {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchResults);
  }

  @override
  String toString() {
    return 'TaskSearchState(taskState: $taskState, pageData: $pageData, pageDataList: $pageDataList, searchResults: $searchResults)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskSearchState &&
            (identical(other.taskState, taskState) ||
                other.taskState == taskState) &&
            (identical(other.pageData, pageData) ||
                other.pageData == pageData) &&
            const DeepCollectionEquality()
                .equals(other._pageDataList, _pageDataList) &&
            const DeepCollectionEquality()
                .equals(other._searchResults, _searchResults));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      taskState,
      pageData,
      const DeepCollectionEquality().hash(_pageDataList),
      const DeepCollectionEquality().hash(_searchResults));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskSearchStateCopyWith<_$_TaskSearchState> get copyWith =>
      __$$_TaskSearchStateCopyWithImpl<_$_TaskSearchState>(this, _$identity);
}

abstract class _TaskSearchState extends TaskSearchState {
  const factory _TaskSearchState(
      {final TaskState taskState,
      final PageData pageData,
      final List<TaskDTO> pageDataList,
      final List<TaskDTO> searchResults}) = _$_TaskSearchState;
  const _TaskSearchState._() : super._();

  @override
  TaskState get taskState;
  @override
  PageData get pageData;
  @override
  List<TaskDTO> get pageDataList;
  @override
  List<TaskDTO> get searchResults;
  @override
  @JsonKey(ignore: true)
  _$$_TaskSearchStateCopyWith<_$_TaskSearchState> get copyWith =>
      throw _privateConstructorUsedError;
}
