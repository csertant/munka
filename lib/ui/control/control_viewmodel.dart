import 'dart:async';

import 'package:material_ui/material_ui.dart';

import '../../data/database/database.dart';
import '../../data/managers/session/session_manager.dart';
import '../../data/repositories/timeentries/timeentries_repository.dart';
import '../../utils/utils.dart';

class ControlViewModel extends ChangeNotifier {
  ControlViewModel({
    required this._sessionManager,
    required this._timeEntriesRepository,
  }) {
    load = Command0(_load);

    _sessionManager.addListener(_onSessionChanged);
    _timeEntriesSubscription = _timeEntriesRepository
        .watchRecentEntries(profileId: _sessionManager.profileId!)
        .listen(_onTimeEntriesChanged);
    _activeEntrySubscription = _timeEntriesRepository
        .watchActiveEntry(profileId: _sessionManager.profileId!)
        .listen(_onActiveEntryChanged);

    unawaited(load.execute());
  }

  final SessionManager _sessionManager;
  final TimeEntriesRepository _timeEntriesRepository;
  StreamSubscription<List<TimeEntry>>? _timeEntriesSubscription;
  StreamSubscription<TimeEntry?>? _activeEntrySubscription;

  List<TimeEntry> _timeEntries = [];
  TimeEntry? _activeEntry;

  late Command0<void> load;

  List<TimeEntry> get timeEntries => _timeEntries;
  TimeEntry? get activeEntry => _activeEntry;

  Future<Result<void>> _load() async {
    try {
      final profileId = _sessionManager.profileId;
      if (profileId == null) {
        return Result.error(NotFoundError('No active session found'));
      } else {
        return const Result.ok(null);
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> _onSessionChanged() async {
    await _timeEntriesSubscription?.cancel();
    _timeEntriesSubscription = _timeEntriesRepository
        .watchRecentEntries(profileId: _sessionManager.profileId!)
        .listen((_) {
          notifyListeners();
        });
    await _activeEntrySubscription?.cancel();
    _activeEntrySubscription = _timeEntriesRepository
        .watchActiveEntry(profileId: _sessionManager.profileId!)
        .listen((_) {
          notifyListeners();
        });
    unawaited(load.execute());
  }

  void _onTimeEntriesChanged(List<TimeEntry> timeEntries) {
    _timeEntries = timeEntries;
    notifyListeners();
  }

  void _onActiveEntryChanged(TimeEntry? activeEntry) {
    _activeEntry = activeEntry;
    notifyListeners();
  }

  @override
  Future<void> dispose() async {
    _sessionManager.removeListener(_onSessionChanged);
    await _timeEntriesSubscription?.cancel();
    await _activeEntrySubscription?.cancel();
    super.dispose();
  }
}
