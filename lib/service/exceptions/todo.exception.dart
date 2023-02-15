class TodoException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  TodoException([this.message, this.prefix, this.url]);
}
