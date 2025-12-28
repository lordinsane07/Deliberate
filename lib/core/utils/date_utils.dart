class DateUtilsHelper {
  /// Formats a DateTime into HH:mm (24-hour)
  static String formatTime(DateTime dateTime) {
    final h = dateTime.hour.toString().padLeft(2, '0');
    final m = dateTime.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  /// Formats a DateTime into dd/MM/yyyy
  static String formatDate(DateTime dateTime) {
    final d = dateTime.day.toString().padLeft(2, '0');
    final m = dateTime.month.toString().padLeft(2, '0');
    final y = dateTime.year.toString();
    return '$d/$m/$y';
  }

  /// Returns true if [dateTime] is in the past
  static bool isPast(DateTime dateTime) {
    return dateTime.isBefore(DateTime.now());
  }

  /// Safe difference between now and a future time
  static Duration remainingUntil(DateTime futureTime) {
    final diff = futureTime.difference(DateTime.now());
    return diff.isNegative ? Duration.zero : diff;
  }
}
