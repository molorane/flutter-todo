import 'dart:async';
import 'dart:typed_data';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo/service/impl/report.service.impl.dart';
import 'package:todo/service/report.service.dart';
import 'package:todo_api/todo_api.dart';

// Import freezed file (maybe not yet generated)
part 'reports.provider.freezed.dart';

// Creating state where the freezed annotation will suggest that boilerplate code needs to be generated
@Freezed()
abstract class ReportsState with _$ReportsState {
  const factory ReportsState({@Default([]) List<TodoDocument> documents}) =
      _ReportsState;

  const ReportsState._();
}

// Creating state notifier provider
final reportsStateProvider =
    AsyncNotifierProvider<ReportsStateNotifier, ReportsState>(
        ReportsStateNotifier.new);

// Creating Notifier
class ReportsStateNotifier extends AsyncNotifier<ReportsState> {
  final ReportService reportsService = ReportServiceImpl();

  @override
  FutureOr<ReportsState> build() async {
    state = AsyncLoading();
    final AsyncValue<Response<BuiltList<TodoDocument>>> av =
        await AsyncValue.guard(() => reportsService.fetchReportDocuments());
    final List<TodoDocument> list = av.value!.data!.toList();
    state = AsyncValue.data(ReportsState(documents: list));
    return state.value!;
  }

  // dwonload
  Future<void> downloadReports() async {
    try {
      state = AsyncLoading();
      reportsService.createReports();
      final AsyncValue<Response<BuiltList<TodoDocument>>> av =
          await AsyncValue.guard(() => reportsService.fetchReportDocuments());
      final List<TodoDocument> list = av.value!.data!.toList();
      state = AsyncValue.data(ReportsState(documents: list));
      if (av.value!.data != null) {
        state = AsyncData(
            state.value!.copyWith(documents: av.value!.data!.toList()));
      } else {
        state = AsyncData(ReportsState());
      }
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }

  // dwonload
  Future<Uint8List?> loadReport(String fileName) async {
    try {
      final ReportsState data = state.value!;
      state = AsyncLoading();
      reportsService.createReports();
      final AsyncValue<Response<Uint8List>> av = await AsyncValue.guard(
          () => reportsService.getDocumentByFileName(fileName));
      if (av.value!.data != null) {
        //var document = MultipartFile.fromBytes(file.toList());
        state = AsyncValue.data(ReportsState(documents: data.documents));
        return av.value!.data!;
      } else {
        state = AsyncData(ReportsState());
      }
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
    return null;
  }
}
