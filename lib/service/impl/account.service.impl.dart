import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_api/todo_api.dart';

import '../account.service.dart';

class AccountServiceImpl extends AccountService {
  final AccountApi accountApi = TodoApi().getAccountApi();

  @override
  Future<Response<void>> updateEntity(AccountDTO t) {
    return accountApi.updateAccount(userId: api.getAccountId(), accountDTO: t);
  }

  @override
  Future<Response<AccountDTO>> findAccountById() {
    return accountApi.findAccountById(userId: api.getAccountId());
  }

  @override
  Future<Response<DefaultResponse>> uploadProfileImage(
      {XFile? profileImage}) async {
    final image = await MultipartFile.fromFile(profileImage!.path);
    return accountApi.uploadProfileImage(
        userId: api.getAccountId(), profileImage: image);
  }

  @override
  Future<Response<Uint8List>> loadProfileImage() {
    return accountApi.loadProfileImage(userId: api.getAccountId());
  }
}
