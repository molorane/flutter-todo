import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../entity/page.data.dart';
import '../openapi/lib/api.dart';
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
    if (isStateConstructed()) {
      state = AsyncValue.data(TaskSearchState());
    }

    state = AsyncValue.data(TaskSearchState());
    return state.value!;
  }

  bool isStateConstructed() {
    return state.value != null;
  }

  Future<AsyncValue<PageTaskDTO?>> searchTasks() async {
    state = AsyncLoading();
    return AsyncValue.guard(() async => taskService.searchTasks(TaskSearchDTO(
        taskType: state.value!.taskState.taskType,
        isCompleted: state.value!.taskState.isCompleted,
        startDate: state.value!.taskState.startDate,
        endDate: state.value!.taskState.endDate,
        description: state.value!.taskState.description)));
  }

  // load all tasks using search filters
  loadTasks(TaskSearchDTO taskSearchDTO) async {
    state = AsyncLoading();
    final Pageable pageable =
        Pageable(page: 0, size: 20, sort: ['dueDate', 'DESC']);
    AsyncValue<PageTaskDTO?> av = await AsyncValue.guard(
        () async => taskService.searchTasks(taskSearchDTO, pageable: pageable));
    state = AsyncData(state.value!.copyWith(
        searchResults: av.value!.content,
        pageData: PageData.fromPage(av.value)));

    print("in prover loadTasks");
    print(state.value!.pageData);
  }

  // load more tasks using search filters
  loadMore(TaskSearchDTO taskSearchDTO) async {
    final PageData currentPageData = state.value!.pageData;
    final Pageable pageable = Pageable(
        size: currentPageData.pageSize, page: currentPageData.pageNo + 1);

    print("new pageable");
    print(pageable);

    state = AsyncLoading();
    AsyncValue<PageTaskDTO?> av = await AsyncValue.guard(
        () async => taskService.searchTasks(taskSearchDTO, pageable: pageable));
    final List<TaskDTO> searchResults = List.from(state.value!.searchResults);
    final List<TaskDTO> moreData = av.value!.content;
    searchResults.addAll(moreData);

    final PageData pageData = PageData.fromPage(av.value);
    print(pageData);

    state = AsyncData(state.value!
        .copyWith(searchResults: searchResults, pageData: pageData));

    print(state.value!.pageData);
  }

  bool hasMore() {
    if (state.value!.searchResults.isEmpty) return false;
    return state.value!.pageData.pageNo < state.value!.pageData.totalPages;
  }
}
