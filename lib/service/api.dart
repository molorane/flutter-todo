

import 'end.point.dart';

class API {

  API();

  static const String host = '192.168.0.157';
  static const int port = 2023;
  
  static const String http = "http";
  static const String https = "https";
  static const String version = "v1";

  static const String accountId = "2014098616";

  factory API.create() => API();

  Uri hostUri() => Uri(
    scheme: http,
    host: host,
    port: port
  );

  static Map<Endpoint, String> paths = {
    Endpoint.TODOS: 'todo/v1/task/$accountId',
    Endpoint.ADD_TODO: 'todo/v1/task/$accountId'
  };

  String? getPath(Endpoint endpoint) {
    return paths[endpoint];
  }

  String getAccountId() {
    return accountId;
  }
}