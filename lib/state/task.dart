class Task {
  final int id;
  final String fieldName;
  dynamic value;

  Task({required this.id, required this.fieldName, this.value});

  Task copyWith({int? id, String? fieldName, dynamic? value}) {
    return Task(
        id: id ?? this.id,
        fieldName: fieldName ?? this.fieldName,
        value: value ?? this.value);
  }
}
