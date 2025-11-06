import 'package:intl/intl.dart';

class DateFormatter {
  static String format(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }
}