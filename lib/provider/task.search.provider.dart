import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_api/todo_api.dart';

import '../entity/page.data.dart';
import '../pages/task/notifier/task.state.dart';
import '../service/impl/task.service.impl.dart';
import '../service/task.service.dart';

part 'task.search.provider.freezed.dart';

// Creating state where the freezed annotation will suggest that boilerplate code needs to be generated
@Freezed()
abstract class TaskSearchState with _$TaskSearchState {
  const factory TaskSearchState(
      {@Default(TaskState()) TaskState taskState,
      @Default(PageData()) PageData pageData,
      @Default([]) List<TaskDTO> pageDataList,
      @Default([]) List<TaskDTO> searchResults}) = _TaskSearchState;

  const TaskSearchState._();
}

// Creating state notifier provider
final taskSearchStateProvider =
    AsyncNotifierProvider<TaskSearchStateNotifier, TaskSearchState>(
        TaskSearchStateNotifier.new);

// Creating Notifier
class TaskSearchStateNotifier extends AsyncNotifier<TaskSearchState> {
  final TaskService taskService = TaskServiceImpl();

  // loadTasks
  @override
  FutureOr<TaskSearchState> build() async {
    state = AsyncValue.data(TaskSearchState());
    return state.value!;
  }

  bool isStateConstructed() {
    return state.value != null;
  }

  Future<AsyncValue<Response<PageTaskDTO>>> searchTasks() async {
    state = AsyncLoading();
    TaskSearchDTOBuilder taskSearchDTOBuilder = TaskSearchDTOBuilder();
    taskSearchDTOBuilder.taskType = state.value!.taskState.taskType;
    taskSearchDTOBuilder.description = state.value!.taskState.description;
    taskSearchDTOBuilder.startDate = state.value!.taskState.startDate;
    taskSearchDTOBuilder.endDate = state.value!.taskState.endDate;
    taskSearchDTOBuilder.isCompleted = state.value!.taskState.isCompleted;

    return AsyncValue.guard(
        () async => taskService.searchTasks(taskSearchDTOBuilder.build()));
  }

  // load all tasks using search filters
  loadTasks(TaskSearchDTO taskSearchDTO) async {
    state = AsyncLoading();
    final Pageable pageable = Pageable((t) => {
          t.page: 0,
          t.size: 20,
          t.sort: ['dueDate', 'DESC']
        });
    try {
      AsyncValue<Response<PageTaskDTO>> av = await AsyncValue.guard(() async =>
          taskService.searchTasks(taskSearchDTO, pageable: pageable));
      state = AsyncData(state.value!.copyWith(
          searchResults: av.value!.data!.content!.toList(),
          pageData: PageData.fromPage(av.value!.data)));
      print("in prover loadTasks");
      print(state.value!.pageData);
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }

  // load more tasks using search filters
  loadLatest(TaskSearchDTO taskSearchDTO) async {
    state = AsyncLoading();
    AsyncValue<Response<PageTaskDTO>> av = await AsyncValue.guard(
        () async => taskService.searchTasks(taskSearchDTO));
    final List<TaskDTO> searchResults = List.from(state.value!.searchResults);
    final PageData pageData = PageData.fromPage(av.value!.data);
    state = AsyncData(state.value!
        .copyWith(searchResults: searchResults, pageData: pageData));
  }

  // load more tasks using search filters
  loadMore(TaskSearchDTO taskSearchDTO) async {
    final PageData currentPageData = state.value!.pageData;
    final Pageable pageable = Pageable((t) =>
        {t.size: currentPageData.pageSize, t.page: currentPageData.pageNo + 1});

    state = AsyncLoading();
    AsyncValue<Response<PageTaskDTO>> av = await AsyncValue.guard(
        () async => taskService.searchTasks(taskSearchDTO, pageable: pageable));
    final List<TaskDTO> searchResults = List.from(state.value!.searchResults);
    final BuiltList<TaskDTO> moreData = av.value!.data!.content!;
    searchResults.addAll(moreData);

    final PageData pageData = PageData.fromPage(av.value!.data);

    state = AsyncData(state.value!
        .copyWith(searchResults: searchResults, pageData: pageData));

    print(state.value!.pageData);
  }

  bool hasMore() {
    if (state.value!.searchResults.isEmpty) return false;
    return state.value!.pageData.pageNo < state.value!.pageData.totalPages;
  }
}
