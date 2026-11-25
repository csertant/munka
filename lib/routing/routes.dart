abstract final class Routes {
  static const home = '/';
  static const control = '/control';
  static const controlEntriesList = '$control/$controlEntriesListSegment';
  static const controlEntriesListSegment = 'entries/list';
  static const controlEntriesNew = '$control/$controlEntriesNewSegment';
  static const controlEntriesNewSegment = 'entries/new';
  static String controlEntriesEdit(String id) =>
      '$control/${controlEntriesEditSegment(id)}';
  static String controlEntriesEditSegment(String id) => 'entries/edit/$id';
  static const settings = '/settings';
  static const settingsProfileNew = '$settings/$settingsProfileNewSegment';
  static const settingsProfileNewSegment = 'profile/new';
  static String settingsProfileEdit(String id) =>
      '$settings/${settingsProfileEditSegment(id)}';
  static String settingsProfileEditSegment(String id) => 'profile/edit/$id';
  static const share = '/share';
  static const stats = '/stats';
}
