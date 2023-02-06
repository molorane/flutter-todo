enum TodoType {
  prayer('PRAYER'),
  gym('GYM'),
  evangelism('EVANGELISM'),
  flutter('FLUTTER'),
  spring('SPRING'),
  study('STUDY'),
  food('FOOD'),
  entertainment('ENTERTAINMENT');

  final String displayValue; // define a private field

  const TodoType(this.displayValue); // constructor

  static TodoType fromString(String label) {
    // static parser method
    return values.firstWhere((v) => v.displayValue == label);
  }

  @override
  String toString() {
    return displayValue.toUpperCase();
  }
}
