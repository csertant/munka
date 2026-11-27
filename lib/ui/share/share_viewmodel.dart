import 'dart:async';

import 'package:material_ui/material_ui.dart';

import '../../data/database/database.dart';
import '../../data/managers/session/session_manager.dart';
import '../../data/repositories/timeentries/timeentries_repository.dart';
import '../../utils/utils.dart';

class ShareViewModel extends ChangeNotifier {
  ShareViewModel({
    required this._timeEntriesRepository,
    required this._sessionManager,
  }) {
    load = Command0(_load);

    _sessionManager.addListener(_onSessionChanged);
    _timeEntriesSubscription = _timeEntriesRepository
        .watchRecentEntries(profileId: _sessionManager.profileId!)
        .listen((entries) {
          _timeEntries = entries;
          notifyListeners();
        });

    unawaited(load.execute());
  }

  final TimeEntriesRepository _timeEntriesRepository;
  final SessionManager _sessionManager;
  late StreamSubscription<List<TimeEntry>> _timeEntriesSubscription;

  List<TimeEntry> _timeEntries = [];

  late Command0<void> load;

  List<TimeEntry> get timeEntries => _timeEntries;

  Future<Result<void>> _load() async {
    try {
      final profileId = _sessionManager.profileId;
      if (profileId == null) {
        return Result.error(NotFoundError('No active session found'));
      }
      final timeEntriesResult = await _timeEntriesRepository.getRecentEntries(
        profileId: _sessionManager.profileId!,
      );
      switch (timeEntriesResult) {
        case Ok<List<TimeEntry>>():
          _timeEntries = timeEntriesResult.value;
          return const Result.ok(null);
        case Error<List<TimeEntry>>():
          return Result.error(timeEntriesResult.error);
      }
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> exportTimeEntriesToCsv() async {
    try {
      final exportResult = await _timeEntriesRepository.exportTimeEntriesToCsv(
        timeEntries: _timeEntries,
      );
      switch (exportResult) {
        case Ok<void>():
          return const Result.ok(null);
        case Error<void>():
          return Result.error(exportResult.error);
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> _onSessionChanged() async {
    await _timeEntriesSubscription.cancel();
    _timeEntriesSubscription = _timeEntriesRepository
        .watchRecentEntries(profileId: _sessionManager.profileId!)
        .listen((entries) {
          _timeEntries = entries;
          notifyListeners();
        });
    await load.execute();
  }

  @override
  Future<void> dispose() async {
    _sessionManager.removeListener(_onSessionChanged);
    await _timeEntriesSubscription.cancel();
    super.dispose();
  }
}
