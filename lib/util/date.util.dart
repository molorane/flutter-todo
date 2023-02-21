import 'package:intl/intl.dart';

class DateUtil {
  static String getStringFormattedDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static DateTime getDateTimeFromString(String date) {
    return DateTime.parse(date);
  }
}
