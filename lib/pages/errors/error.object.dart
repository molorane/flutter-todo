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
    if (error is SocketException) {
      return ErrorObject(
        title: 'Error Code: INTERNAL_SERVER_FAILURE',
        message: 'It seems that the server is not reachable at the moment, try '
            'again later, should the issue persist please reach out to the '
            'developer at a@b.com',
      );
    } else if (error is TlsException) {
      return ErrorObject(
        title: 'Error Code: JSON_PARSING_FAILURE',
        message: 'It seems that the app needs to be updated to reflect the , '
            'changed server data structure, if no update is '
            'available on the store please reach out to the developer at a@b.com',
      );
    } else if (error is ClientException) {
      return ErrorObject(
        title: 'Error Code: NO_CONNECTIVITY',
        message: 'It seems that your device is not connected to the network, '
            'please check your internet connectivity or try again later.',
      );
    } else if (error is DioError) {
      switch (error.type) {
        case DioErrorType.connectTimeout:
          return ErrorObject(
            title: 'Error Code: CONNECTING TIMEOUT',
            message: error.message,
          );
        case DioErrorType.sendTimeout:
          return ErrorObject(
            title: 'Error Code: SENDING TIMEOUT',
            message: error.message,
          );
        case DioErrorType.receiveTimeout:
          return ErrorObject(
            title: 'Error Code: RECEIVING DATA TIMEOUT',
            message: error.message,
          );
        case DioErrorType.response:
          return ErrorObject(
            title: 'Error Code: SERVER ERROR',
            message: error.message,
          );
        case DioErrorType.cancel:
          return ErrorObject(
            title: 'Error Code: REQUEST CANCELLED',
            message: error.message,
          );
        case DioErrorType.other:
          return ErrorObject(
            title: 'Error Code: DEFAULT ERROR',
            message: error.message,
          );
      }
    } else {
      return ErrorObject(
          title: 'Unknown error occurred',
          message: 'An unknown error has occurred, try '
              'again later, should the issue persist please contact a developer at mothusi.molorane@gmail.com.');
    }
  }
}
