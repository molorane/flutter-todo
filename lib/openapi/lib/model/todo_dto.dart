//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TodoDTO {
  /// Returns a new [TodoDTO] instance.
  TodoDTO({
    this.id,
    this.todoType = const TodoDTOTodoTypeEnum._('STUDY'),
    this.title,
    this.completed = false,
    this.dueDate,
    this.description,
    this.createdDate,
    this.deleted = false,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? id;

  TodoDTOTodoTypeEnum todoType;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? title;

  bool completed;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? dueDate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? description;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? createdDate;

  bool deleted;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoDTO &&
          other.id == id &&
          other.todoType == todoType &&
          other.title == title &&
          other.completed == completed &&
          other.dueDate == dueDate &&
          other.description == description &&
          other.createdDate == createdDate &&
          other.deleted == deleted;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (id == null ? 0 : id!.hashCode) +
      (todoType.hashCode) +
      (title == null ? 0 : title!.hashCode) +
      (completed.hashCode) +
      (dueDate == null ? 0 : dueDate!.hashCode) +
      (description == null ? 0 : description!.hashCode) +
      (createdDate == null ? 0 : createdDate!.hashCode) +
      (deleted.hashCode);

  @override
  String toString() =>
      'TodoDTO[id=$id, todoType=$todoType, title=$title, completed=$completed, dueDate=$dueDate, description=$description, createdDate=$createdDate, deleted=$deleted]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    if (id != null) {
      _json[r'id'] = id;
    }
    _json[r'todoType'] = todoType;
    if (title != null) {
      _json[r'title'] = title;
    }
    _json[r'completed'] = completed;
    if (dueDate != null) {
      _json[r'dueDate'] = _dateFormatter.format(dueDate!.toUtc());
    }
    if (description != null) {
      _json[r'description'] = description;
    }
    if (createdDate != null) {
      _json[r'createdDate'] = createdDate!.toUtc().toIso8601String();
    }
    _json[r'deleted'] = deleted;
    return _json;
  }

  /// Returns a new [TodoDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TodoDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "TodoDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "TodoDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TodoDTO(
        id: mapValueOfType<int>(json, r'id'),
        todoType: TodoDTOTodoTypeEnum.fromJson(json[r'todoType']) ??
            TodoDTOTodoTypeEnum._('STUDY'),
        title: mapValueOfType<String>(json, r'title'),
        completed: mapValueOfType<bool>(json, r'completed') ?? false,
        dueDate: mapDateTime(json, r'dueDate', ''),
        description: mapValueOfType<String>(json, r'description'),
        createdDate: mapDateTime(json, r'createdDate', ''),
        deleted: mapValueOfType<bool>(json, r'deleted') ?? false,
      );
    }
    return null;
  }

  static List<TodoDTO>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <TodoDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TodoDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TodoDTO> mapFromJson(dynamic json) {
    final map = <String, TodoDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TodoDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TodoDTO-objects as value to a dart map
  static Map<String, List<TodoDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<TodoDTO>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TodoDTO.listFromJson(
          entry.value,
          growable: growable,
        );
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{};
}

class TodoDTOTodoTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const TodoDTOTodoTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const PRAYER = TodoDTOTodoTypeEnum._(r'PRAYER');
  static const GYM = TodoDTOTodoTypeEnum._(r'GYM');
  static const PREACH = TodoDTOTodoTypeEnum._(r'PREACH');
  static const FLUTTER = TodoDTOTodoTypeEnum._(r'FLUTTER');
  static const SPRING = TodoDTOTodoTypeEnum._(r'SPRING');
  static const STUDY = TodoDTOTodoTypeEnum._(r'STUDY');
  static const FOOD = TodoDTOTodoTypeEnum._(r'FOOD');
  static const ENTERTAINMENT = TodoDTOTodoTypeEnum._(r'ENTERTAINMENT');

  /// List of all possible values in this [enum][TodoDTOTodoTypeEnum].
  static const values = <TodoDTOTodoTypeEnum>[
    PRAYER,
    GYM,
    PREACH,
    FLUTTER,
    SPRING,
    STUDY,
    FOOD,
    ENTERTAINMENT,
  ];

  static TodoDTOTodoTypeEnum? fromJson(dynamic value) =>
      TodoDTOTodoTypeEnumTypeTransformer().decode(value);

  static List<TodoDTOTodoTypeEnum>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <TodoDTOTodoTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TodoDTOTodoTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [TodoDTOTodoTypeEnum] to String,
/// and [decode] dynamic data back to [TodoDTOTodoTypeEnum].
class TodoDTOTodoTypeEnumTypeTransformer {
  factory TodoDTOTodoTypeEnumTypeTransformer() =>
      _instance ??= const TodoDTOTodoTypeEnumTypeTransformer._();

  const TodoDTOTodoTypeEnumTypeTransformer._();

  String encode(TodoDTOTodoTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a TodoDTOTodoTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  TodoDTOTodoTypeEnum decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data.toString()) {
        case r'PRAYER':
          return TodoDTOTodoTypeEnum.PRAYER;
        case r'GYM':
          return TodoDTOTodoTypeEnum.GYM;
        case r'PREACH':
          return TodoDTOTodoTypeEnum.PREACH;
        case r'FLUTTER':
          return TodoDTOTodoTypeEnum.FLUTTER;
        case r'SPRING':
          return TodoDTOTodoTypeEnum.SPRING;
        case r'STUDY':
          return TodoDTOTodoTypeEnum.STUDY;
        case r'FOOD':
          return TodoDTOTodoTypeEnum.FOOD;
        case r'ENTERTAINMENT':
          return TodoDTOTodoTypeEnum.ENTERTAINMENT;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return TodoDTOTodoTypeEnum._('STUDY');
  }

  /// Singleton [TodoDTOTodoTypeEnumTypeTransformer] instance.
  static TodoDTOTodoTypeEnumTypeTransformer? _instance;
}
