import 'end.point.dart';

class TodoAPI {
  TodoAPI();

  static const apiKey = "";
  static const String host = '192.168.0.157';
  static const int port = 2023;

  static const String http = "http";
  static const String https = "https";
  static const String version = "v1";

  static const String accountId = "2014098616";

  factory TodoAPI.create() => TodoAPI();

  Uri hostUri() => Uri(scheme: http, host: host, port: port);

  static Map<Endpoint, String> paths = {
    Endpoint.todos: 'todo/todo/v1/task/$accountId/user',
    Endpoint.addTodo: 'todo/v1/task/$accountId'
  };

  String? getPath(Endpoint endpoint) {
    return paths[endpoint];
  }

  String getAccountId() {
    return accountId;
  }
}