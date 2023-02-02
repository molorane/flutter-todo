enum TodoType {
  prayer('PRAYER'),
  gym('GYM'),
  evangelism('EVANGELISM'),
  flutter('FLUTTER'),
  spring('SPRING'),
  study('STUDY'),
  unknown('UKNOWN');

  final String label; // define a private field

  const TodoType(this.label); // constructor

  static TodoType fromString(String label) {
    // static parser method
    return values.firstWhere(
      (v) => v.label == label,
      orElse: () => TodoType.unknown,
    );
  }

  @override
  String toString() {
    return label.toUpperCase();
  }
}
