abstract final class Routes {
  static const String home = '/';
  static const String control = '/control';
  static const String settings = '/settings';
  static const String settingsProfileNew =
      '$settings/$settingsProfileNewSegment';
  static const String settingsProfileNewSegment = 'profile/new';
  static String settingsProfileEdit(String id) =>
      '$settings/${settingsProfileEditSegment(id)}';
  static String settingsProfileEditSegment(String id) => 'profile/edit/$id';
  static const String stats = '/stats';
}
