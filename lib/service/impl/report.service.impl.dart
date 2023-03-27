import 'dart:async';
import 'dart:typed_data';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:todo/service/report.service.dart';
import 'package:todo_api/todo_api.dart';

class ReportServiceImpl extends ReportService {
  final ReportApi reportApi = TodoApi().getReportApi();

  @override
  Future<Response<void>> createReports() async {
    return await reportApi.createReports(userId: api.getAccountId());
  }

  @override
  Future<Response<BuiltList<TodoDocument>>> fetchReportDocuments() {
    return reportApi.fetchReportDocuments(userId: api.getAccountId());
  }

  @override
  Future<Response<Uint8List>> getDocumentByFileName(String fileName) {
    return reportApi.getDocumentByFileName(fileName: fileName);
  }
}
