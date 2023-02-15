import 'package:todo/service/exceptions/todo.exception.dart';

class FetchDataException extends TodoException {
  FetchDataException([String? message, String? url])
      : super(message, 'Unable to process', url);
}
