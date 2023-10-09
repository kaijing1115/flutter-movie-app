import 'package:intl/intl.dart';

class DateTimeHelper {
  static String todayDateString([String? format]) {
    DateTime today = DateTime.now();
    return dateToString(today, format);
  }

  static String dateFromTodayString(int diff, [String? format]) {
    DateTime dateTime = DateTime.now();
    if (diff < 0) {
      dateTime = DateTime.now().subtract(Duration(days: diff.abs()));
    } else {
      dateTime = DateTime.now().add(Duration(days: diff.abs()));
    }
    return dateToString(dateTime, format);
  }

  static String dateToString(DateTime date, [String? format]) {
    String toFormat = 'y-MM-dd';
    if (format != null && format.isNotEmpty) {
      toFormat = format;
    }
    final dateString = DateFormat(toFormat, 'en_US').format(date);
    return dateString;
  }

  static DateTime stringToDate(String dateString, [String? format]) {
    if (format != null) {
      return DateFormat(format).parse(dateString);
    }
    return DateTime.parse(dateString);
  }

  static String dateStringFormat(String dateString,
      [String? format, String? fromFormat]) {
    final dateTime = DateTimeHelper.stringToDate(dateString, fromFormat);
    return dateToString(dateTime, format);
  }

  static String durationToMmSs(Duration duration) {
    final mm = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final ss = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return '$mm:$ss';
  }

  static DateTime getFirstDateOfDate(DateTime date) {
    DateTime firstDateTime = DateTime.utc(date.year, date.month, 1);
    return firstDateTime;
  }

  static Duration getDifference(DateTime datetime1, DateTime datetime2) {
    Duration diff = datetime1.difference(datetime2);
    return diff;
  }
}
