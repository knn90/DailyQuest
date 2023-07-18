class TimestampProvider {
  static String timestamp(DateTime date) {
    return date.day.toString().padLeft(2, '0') +
        date.month.toString().padLeft(2, '0') +
        date.year.toString();
  }

  static String todayTimestamp() {
    return timestamp(DateTime.now());
  }
}
