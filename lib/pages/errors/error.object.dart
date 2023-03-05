import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

class ErrorObject extends Equatable {
  ErrorObject({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  List<Object?> get props => [title, message];

  static ErrorObject mapErrorToObject({Object? error}) {
    print(error);
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.connectTimeout:
          return ErrorObject(
            title: 'CONNECTING TIMEOUT',
            message: error.message,
          );
        case DioErrorType.sendTimeout:
          return ErrorObject(
            title: 'SENDING TIMEOUT',
            message: error.message,
          );
        case DioErrorType.receiveTimeout:
          return ErrorObject(
            title: 'RECEIVING DATA TIMEOUT',
            message: error.message,
          );
        case DioErrorType.response:
          return ErrorObject(
            title: 'SERVER ERROR',
            message: error.message,
          );
        case DioErrorType.cancel:
          return ErrorObject(
            title: 'REQUEST CANCELLED',
            message: error.message,
          );
        case DioErrorType.other:
          if (error is SocketException) {
            return ErrorObject(
              title: 'INTERNAL_SERVER_FAILURE',
              message: error.message,
            );
          } else if (error is TlsException) {
            return ErrorObject(
              title: 'JSON_PARSING_FAILURE',
              message: error.message,
            );
          } else if (error is ClientException) {
            return ErrorObject(
              title: 'NO_CONNECTIVITY',
              message: error.message,
            );
          } else {
            return ErrorObject(
              title: 'DEFAULT ERROR',
              message: error.message,
            );
          }
      }
    } else {
      return ErrorObject(
          title: 'Unknown error occurred',
          message: 'An unknown error has occurred, try '
              'again later, should the issue persist please contact a developer at molorane@gmail.com.');
    }
  }
}
