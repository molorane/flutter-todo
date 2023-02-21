import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

class ErrorObject extends Equatable {
  const ErrorObject({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  List<Object?> get props => [title, message];

  static ErrorObject mapErrorToObject({Object? error}) {
    if (error is SocketException) {
      return const ErrorObject(
        title: 'Error Code: INTERNAL_SERVER_FAILURE',
        message: 'It seems that the server is not reachable at the moment, try '
            'again later, should the issue persist please reach out to the '
            'developer at a@b.com',
      );
    } else if (error is TlsException) {
      return const ErrorObject(
        title: 'Error Code: JSON_PARSING_FAILURE',
        message: 'It seems that the app needs to be updated to reflect the , '
            'changed server data structure, if no update is '
            'available on the store please reach out to the developer at a@b.com',
      );
    } else if (error is ClientException) {
      return const ErrorObject(
        title: 'Error Code: NO_CONNECTIVITY',
        message: 'It seems that your device is not connected to the network, '
            'please check your internet connectivity or try again later.',
      );
    } else {
      return const ErrorObject(
        title: 'Invalid HTTP operation',
        message: 'It seems that your device is not connected to the network, '
            'please check your internet connectivity or try again later.',
      );
    }
  }
}
