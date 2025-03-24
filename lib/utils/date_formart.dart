import 'package:intl/intl.dart';
String formatDateString(String dateStr) {
  try {
    // Parse the input date string
    DateTime dateTime = DateTime.parse(dateStr);

    // Get the month name, day, and year
    String month = _getMonthName(dateTime.month);
    int day = dateTime.day;
    int year = dateTime.year;

    // Return formatted date
    return '$month $day, $year';
  } catch (e) {
    // Return original string if parsing fails
    return dateStr;
  }
}

// Helper function to get month name from month number
String _getMonthName(int month) {
  List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  // Month numbers are 1-based, but list indices are 0-based
  return months[month - 1];
}



String formatDateString2(String dateStr) {
  try {
    DateTime dateTime = DateTime.parse(dateStr);
    return DateFormat('MMMM d, yyyy').format(dateTime);
  } catch (e) {
    return dateStr;
  }
}