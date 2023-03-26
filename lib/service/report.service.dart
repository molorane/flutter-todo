import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:todo/service/todo.api.dart';

abstract class ReportService {
  final TodoAPI api = TodoAPI();

  Future<Response<Uint8List>> loadGroupTaskReport();
}
