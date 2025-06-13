import 'package:intl/intl.dart';

class AppDateUtils {
  // Định dạng ngày tháng
  static String formatDate(DateTime date, {String format = 'dd/MM/yyyy'}) {
    return DateFormat(format).format(date);
  }

  // Chuyển đổi chuỗi thành DateTime
  static DateTime? parseDate(String date, {String format = 'dd/MM/yyyy'}) {
    try {
      return DateFormat(format).parse(date);
    } catch (e) {
      return null;
    }
  }

  // Lấy tuần hiện tại trong năm
  static int getCurrentWeek() {
    final now = DateTime.now();
    final firstDayOfYear = DateTime(now.year, 1, 1);
    final dayDifference = now.difference(firstDayOfYear).inDays;
    return (dayDifference / 7).ceil();
  }

  // Lấy tuần từ ngày
  static int getWeekFromDate(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final dayDifference = date.difference(firstDayOfYear).inDays;
    return (dayDifference / 7).ceil();
  }

  // Lấy ngày đầu tiên của tuần
  static DateTime getFirstDayOfWeek(int year, int week) {
    final firstDayOfYear = DateTime(year, 1, 1);
    return firstDayOfYear.add(Duration(days: (week - 1) * 7));
  }

  // Lấy ngày cuối cùng của tuần
  static DateTime getLastDayOfWeek(int year, int week) {
    final firstDayOfWeek = getFirstDayOfWeek(year, week);
    return firstDayOfWeek.add(const Duration(days: 6));
  }

  // Lấy danh sách các ngày trong tuần
  static List<DateTime> getDaysInWeek(int year, int week) {
    final firstDayOfWeek = getFirstDayOfWeek(year, week);
    return List.generate(
        7, (index) => firstDayOfWeek.add(Duration(days: index)));
  }

  // Lấy năm học hiện tại (VD: 2023-2024)
  static String getCurrentSchoolYear() {
    final now = DateTime.now();
    // Năm học bắt đầu từ tháng 9
    if (now.month >= 9) {
      return '${now.year}-${now.year + 1}';
    } else {
      return '${now.year - 1}-${now.year}';
    }
  }

  // Lấy năm của năm học từ ngày
  static int getSchoolYearFromDate(DateTime date) {
    // Năm học bắt đầu từ tháng 9
    if (date.month >= 9) {
      return date.year;
    } else {
      return date.year - 1;
    }
  }
}