import 'package:flutter/cupertino.dart';

@immutable
class Task {
  final int id;
  final String fieldName;
  final dynamic value;
  final bool changed;

  const Task(
      {required this.id,
      required this.fieldName,
      this.value,
      this.changed = false});

  Task copyWith(
      {int? id, String? fieldName, dynamic value, bool changed = false}) {
    return Task(
        id: id ?? this.id,
        fieldName: fieldName ?? this.fieldName,
        value: value ?? this.value,
        changed: changed);
  }

  @override
  String toString() {
    // TODO: implement toString
    return '[$id $fieldName $value $changed]';
  }
}
