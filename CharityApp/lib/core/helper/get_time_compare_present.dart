class GetTimeComparePresent {
  static String call(DateTime time) {
    if (DateTime.now().compareTo(time) < 0)
      throw Exception('Time must be late for now');

    final distanceTime = DateTime.now().difference(time);
    final days = distanceTime.inHours / 24;

    //Check year
    if (days / 365 >= 1) return "${days ~/ 365} năm trước";
    //Check month
    if (days / 30 >= 1) return "${days ~/ 30} tháng trước";
    //Check day
    if (days >= 1) return "${days.toInt()} ngày trước";
    //Check hour
    if (distanceTime.inHours > 0) return "${distanceTime.inHours} giờ trước";
    //Check minute
    return "${distanceTime.inMinutes} phút trước";
  }
}
