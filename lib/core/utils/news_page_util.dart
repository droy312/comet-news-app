class NewsPageUtil {
  static const List<String> _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

  /// Returns May 16, 2021
  static String getMonthDayYear(DateTime dateTime) {
    return '${_months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
  }
}