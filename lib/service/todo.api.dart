class TodoAPI {
  TodoAPI();

  static const apiKey = "";
  static const String host = '192.168.0.157';
  static const int port = 2023;
  static const int timeOutDuration = 20;

  static const String http = "http";
  static const String https = "https";
  static const String version = "v1";

  static const int accountId = 2014098616;

  factory TodoAPI.create() => TodoAPI();

  Uri hostUri() => Uri(scheme: http, host: host, port: port);

  int getAccountId() {
    return accountId;
  }
}
