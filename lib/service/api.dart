

import 'end.point.dart';

class API {

  API();

  static const String host = '192.168.0.157';
  static const int port = 2023;
  
  static const String http = "http";
  static const String https = "https";

  factory API.create() => API();

  Uri tokenUri() => Uri(
    scheme: http,
    host: host,
    port: port
  );

  static Map<Endpoint, String> paths = {
    Endpoint.todo: 'todo',
    Endpoint.todos: 'todo/task'
  };
}