import 'package:intl/intl.dart';

abstract final class AppDateFormat {
  static final yMMdd = DateFormat('y. MM. dd.');
  static final yMMddHHmm = DateFormat('y. MM. dd. HH:mm');
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

  static String formatDurationHoursMinutes(DateTime start, DateTime end) {
    final duration = end.difference(start);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    return '$hours:$minutes';
  }

  static DateTime firstPossibleDate() {
    return DateTime(1998, 11, 11);
  }

  static DateTime lastPossibleDate() {
    return DateTime.now().add(const Duration(days: 365));
  }
}
