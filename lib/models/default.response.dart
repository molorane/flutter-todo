class DefaultResponse {
  String message;
  String? description;
  String? date;

  DefaultResponse({
    required this.message,
    this.description,
    required this.date,
  });

  factory DefaultResponse.fromJson(Map<String, dynamic> json) {
    return DefaultResponse(
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
