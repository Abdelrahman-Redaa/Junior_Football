extension DataTimeExtension on DateTime {
  String formatDataTime() {
    DateTime dateTime = this;
    String year = dateTime.year.toString();
    String month = dateTime.month.toString();
    String day = dateTime.day.toString();
    return '$year-$month-$day';
  }
}
