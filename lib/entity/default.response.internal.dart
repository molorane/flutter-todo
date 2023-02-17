class DefaultResponseInternal {
  String message;
  String? description;
  String? date;

  DefaultResponseInternal({
    required this.message,
    this.description,
    required this.date,
  });

  factory DefaultResponseInternal.fromJson(Map<String, dynamic> json) {
    return DefaultResponseInternal(
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
