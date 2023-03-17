import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/service/task.api.dart';
import 'package:todo_api/todo_api.dart';

abstract class AccountService {
  final TaskAPI api = TaskAPI();

  Future<Response<void>> updateEntity(AccountDTO t);

  Future<Response<AccountDTO>> findAccountById();

  Future<Response<DefaultResponse>> uploadProfileImage({XFile? profileImage});

  Future<Response<Uint8List>> loadProfileImage();
}
