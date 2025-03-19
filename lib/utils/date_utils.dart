import 'package:get_time_ago/get_time_ago.dart';
import 'package:intl/intl.dart';

extension StringExtensions on String {
  DateTime get dateTime => DateTime.parse(this);

  String formatDateToReadable() {
    final date = dateTime;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateToCheck = DateTime(date.year, date.month, date.day);

    if (dateToCheck == today) {
      return 'Today';
    } else if (dateToCheck == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('MMM d, yyyy').format(date);
    }
  }

  String get toTimeAgo => GetTimeAgo.parse(dateTime);
}
