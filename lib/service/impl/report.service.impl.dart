import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:todo/service/report.service.dart';
import 'package:todo_api/todo_api.dart';

class ReportServiceImpl extends ReportService {
  final ReportApi reportApi = TodoApi().getReportApi();

  @override
  Future<Response<Uint8List>> loadGroupTaskReport() {
    return reportApi.loadGroupTaskReport(userId: api.getAccountId());
  }
}
