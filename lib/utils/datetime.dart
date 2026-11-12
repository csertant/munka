import 'package:intl/intl.dart';

abstract final class AppDateFormat {
  static final DateFormat yMMdd = DateFormat('y. MM. dd.');
  static final DateFormat yMMddHHmm = DateFormat('y. MM. dd. HH:mm');
  // Keep naming consistent with the intl package's formatting patterns.
  // ignore: non_constant_identifier_names
  static final DateFormat HHmm = DateFormat('HH:mm');
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
}
