import 'dart:typed_data';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:todo/service/todo.api.dart';
import 'package:todo_api/todo_api.dart';

abstract class ReportService {
  final TodoAPI api = TodoAPI();

  Future<Response<void>> createReports();

  Future<Response<BuiltList<TodoDocument>>> fetchReportDocuments();

  Future<Response<Uint8List>> getDocumentByFileName(String fileName);
}
