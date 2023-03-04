import 'package:intl/intl.dart';
import 'package:todo_api/todo_api.dart';

class DateUtil {
  static String getStringFormattedDate(Date date) {
    return DateFormat('yyyy-MM-dd').format(date.toDateTime(utc: true));
  }

  static DateTime getDateTimeFromString(String date) {
    return DateTime.parse(date);
  }
}
