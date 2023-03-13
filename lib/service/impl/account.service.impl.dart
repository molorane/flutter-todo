import 'dart:async';

import 'package:dio/dio.dart';
import 'package:todo_api/todo_api.dart';

import '../account.service.dart';

class AccountServiceImpl extends AccountService {
  final AccountApi accountApi = TodoApi().getAccountApi();

  @override
  Future<Response<void>> updateEntity(AccountDTO t) {
    return accountApi.updateAccount(accountDTO: t);
  }

  @override
  Future<Response<AccountDTO>> findAccountById() {
    return accountApi.findAccountById(userId: api.getAccountId());
  }
}
