import 'package:todo/service/exceptions/todo.exception.dart';

class UnAuthorizedException extends TodoException {
  UnAuthorizedException([String? message, String? url])
      : super(message, 'Un authorized request', url);
}
