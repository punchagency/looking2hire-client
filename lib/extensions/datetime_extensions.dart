extension DatetimeExtensions on DateTime {
  String toMonthYear() {
    return "${month.toMonthName()} $year";
  }

  String toMonthDayYear() {
    return "${month.toFullMonthName()} $day, $year";
  }
}

extension MonthNameExtension on int {
  String toFullMonthName() {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    if (this < 1 || this > 12) return '';
    return months[this - 1];
  }

  String toMonthName() {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    if (this < 1 || this > 12) return '';
    return months[this - 1];
  }
}
