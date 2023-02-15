import 'package:todo/service/exceptions/todo.exception.dart';

class NoResponseException extends TodoException {
  NoResponseException([String? message, String? url])
      : super(message, 'Api not responded in time', url);
}
