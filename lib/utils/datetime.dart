import 'package:intl/intl.dart';

import 'types.dart';

abstract final class AppDateFormat {
  static final yMMdd = DateFormat('y. MM. dd.');
  static final yMMddHHmm = DateFormat('y. MM. dd. HH:mm');

  static final yMMM = DateFormat('y. MMM.');
  // Keep naming consistent with the intl package's formatting patterns.
  // ignore: non_constant_identifier_names
  static final MMdd = DateFormat('MM. dd.');
  // Keep naming consistent with the intl package's formatting patterns.
  // ignore: non_constant_identifier_names
  static final HHmm = DateFormat('HH:mm');
}

abstract final class AppDateUtils {
  static String formatElapsedTime(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    final formattedHours = hours.toString().padLeft(2, '0');
    final formattedMinutes = minutes.toString().padLeft(2, '0');
    final formattedSeconds = seconds.toString().padLeft(2, '0');

    return '$formattedHours:$formattedMinutes:$formattedSeconds';
  }

  static String formatDurationDecimal(DateTime start, DateTime end) {
    final duration = end.difference(start);
    final decimalHours = duration.inMinutes / 60.0;

    return decimalHours.toStringAsFixed(2);
  }

  static String formatHoursDecimal(double hours) {
    return hours.toStringAsFixed(2);
  }

  static String formatDurationHoursMinutes(DateTime start, DateTime end) {
    final duration = end.difference(start);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    return '$hours:$minutes';
  }

  static String formatHoursMinutes(double hours) {
    final wholeHours = hours.floor();
    final minutes = ((hours - wholeHours) * 60).round();

    return '$wholeHours:${minutes.toString().padLeft(2, '0')}';
  }

  static DateTimeRange weekRange(int offset) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final monday = today.subtract(Duration(days: today.weekday - 1));
    final start = monday.add(Duration(days: offset * 7));
    final end = start.add(const Duration(days: 7));
    return (start: start, end: end);
  }

  static DateTimeRange threeMonthRange(int offset) {
    final now = DateTime.now();
    final anchorMonthIndex = (now.year * 12 + (now.month - 1)) + (offset * 3);
    final firstIndex = anchorMonthIndex - 2;
    final start = DateTime(firstIndex ~/ 12, (firstIndex % 12) + 1);
    final end = DateTime(anchorMonthIndex ~/ 12, (anchorMonthIndex % 12) + 2);
    return (start: start, end: end);
  }

  static DateTimeRange threeYearRange(int offset) {
    final now = DateTime.now();
    final endYear = now.year + (offset * 3);
    final startYear = endYear - 2;
    return (start: DateTime(startYear), end: DateTime(endYear + 1));
  }

  static DateTime firstPossibleDate() {
    return DateTime(1998, 11, 11);
  }

  static DateTime lastPossibleDate() {
    return DateTime.now().add(const Duration(days: 365));
  }
}
