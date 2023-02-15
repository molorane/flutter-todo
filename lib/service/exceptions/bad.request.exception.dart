import 'package:todo/service/exceptions/todo.exception.dart';

class BadRequestException extends TodoException {
  BadRequestException([String? message, String? url])
      : super(message, 'Bad Request', url);
}
