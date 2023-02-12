class ResponseMessage {
  String message;
  String? description;
  String? date;

  ResponseMessage({
    required this.message,
    this.description,
    required this.date,
  });

  factory ResponseMessage.fromJson(Map<String, dynamic> json) {
    return ResponseMessage(
      message: json['message'],
      description: json['description'],
      date: json['date'],
    );
  }

  @override
  String toString() {
    return '[$message, $description, $date]';
  }
}
