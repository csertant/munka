import 'dart:async';

import 'package:drift/drift.dart';
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
    startTracking = Command0(_startTracking);
    stopTracking = Command0(_stopTracking);
    completeTracking = Command2(_completeTracking);
    clearTracking = Command0(_clearTracking);

    _sessionManager.addListener(_onSessionChanged);
    _timeEntriesSubscription = _timeEntriesRepository
        .watchRecentEntries(profileId: _sessionManager.profileId!)
        .listen((entries) {
          timeEntries.value = entries;
        });
    _activeEntrySubscription = _timeEntriesRepository
        .watchActiveEntry(profileId: _sessionManager.profileId!)
        .listen((entry) {
          _activeEntry = entry;
        });

    unawaited(load.execute());
  }

  final SessionManager _sessionManager;
  final TimeEntriesRepository _timeEntriesRepository;
  late StreamSubscription<List<TimeEntry>> _timeEntriesSubscription;
  late StreamSubscription<TimeEntry?> _activeEntrySubscription;

  TimeEntry? _activeEntry;
  final ValueNotifier<List<TimeEntry>> timeEntries = ValueNotifier([]);

  Timer? _ticker;
  DateTime _currentTime = DateTime.now();
  DateTime? _startedAt;
  DateTime? _endedAt;
  Duration _elapsed = Duration.zero;
  final ValueNotifier<bool> isTracking = ValueNotifier(false);

  late Command0<void> load;
  late Command0<void> startTracking;
  late Command0<void> stopTracking;
  late Command2<void, String, String> completeTracking;
  late Command0<void> clearTracking;

  TimeEntry? get activeEntry => _activeEntry;
  DateTime get currentTime => _currentTime;
  Duration get elapsed => _elapsed;

  Future<Result<void>> _load() async {
    try {
      _startTicker();
      final profileId = _sessionManager.profileId;
      if (profileId == null) {
        return Result.error(NotFoundError('No active session found'));
      } else {
        final activeEntryResult = await _timeEntriesRepository.getActiveEntry(
          profileId: profileId,
        );
        switch (activeEntryResult) {
          case Ok<TimeEntry?>():
            _activeEntry = activeEntryResult.value;
            if (_activeEntry != null) {
              await _startTracking(existingStart: _activeEntry!.startedAt);
            } else {
              return await _stopTracking();
            }
          case Error<TimeEntry?>():
            return Result.error(activeEntryResult.error);
        }
        final recentEntriesResult = await _timeEntriesRepository
            .getRecentEntries(profileId: profileId);
        switch (recentEntriesResult) {
          case Ok<List<TimeEntry>>():
            timeEntries.value = recentEntriesResult.value;
          case Error<List<TimeEntry>>():
            return Result.error(recentEntriesResult.error);
        }
        return const Result.ok(null);
      }
    } finally {
      notifyListeners();
    }
  }

  void _startTicker() {
    if (_ticker != null && _ticker!.isActive) {
      return;
    }
    _ticker = Timer.periodic(const Duration(seconds: 1), _updateTicker);
  }

  void _updateTicker(_) {
    final now = DateTime.now();
    _currentTime = now;

    if (_startedAt != null) {
      _elapsed = now.difference(_startedAt!);
    }
    notifyListeners();
  }

  Future<Result<void>> _startTracking({DateTime? existingStart}) async {
    try {
      if (existingStart == null) {
        final startResult = await _timeEntriesRepository.startTimer(
          profileId: _sessionManager.profileId!,
        );
        if (startResult is Ok<void>) {
          _startedAt = DateTime.now();
        } else if (startResult is Error<void>) {
          return Result.error(startResult.error);
        }
      } else {
        _startedAt = existingStart;
      }
      _endedAt = null;
      _elapsed = DateTime.now().difference(_startedAt!);
      isTracking.value = true;
      return const Result.ok(null);
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _stopTracking() async {
    try {
      _startedAt = null;
      _endedAt = DateTime.now();
      _elapsed = Duration.zero;
      isTracking.value = false;
      return const Result.ok(null);
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _completeTracking(String project, String notes) async {
    try {
      if (activeEntry == null) {
        return Result.error(NotFoundError('No active entry found.'));
      }
      final completedEntry = activeEntry!.copyWith(
        project: Value(project),
        notes: Value(notes),
        endedAt: Value(_endedAt ?? DateTime.now()),
      );
      final completionResult = await _timeEntriesRepository.stopTimer(
        entry: completedEntry,
      );
      if (completionResult is Error<void>) {
        await _startTracking(existingStart: activeEntry!.startedAt);
        return Result.error(completionResult.error);
      } else {
        _activeEntry = null;
        return const Result.ok(null);
      }
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _clearTracking() async {
    try {
      if (activeEntry == null) {
        return Result.error(NotFoundError('No active entry found.'));
      }
      final clearResult = await _timeEntriesRepository.removeEntry(
        entryId: activeEntry!.id,
      );
      if (clearResult is Error<void>) {
        await _startTracking(existingStart: activeEntry!.startedAt);
        return Result.error(clearResult.error);
      } else {
        _activeEntry = null;
        return const Result.ok(null);
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> _onSessionChanged() async {
    _ticker?.cancel();
    await _timeEntriesSubscription.cancel();
    _timeEntriesSubscription = _timeEntriesRepository
        .watchRecentEntries(profileId: _sessionManager.profileId!)
        .listen((entries) {
          timeEntries.value = entries;
        });
    await _activeEntrySubscription.cancel();
    _activeEntrySubscription = _timeEntriesRepository
        .watchActiveEntry(profileId: _sessionManager.profileId!)
        .listen((entry) {
          _activeEntry = entry;
        });
    await load.execute();
  }

  @override
  Future<void> dispose() async {
    _sessionManager.removeListener(_onSessionChanged);
    await _activeEntrySubscription.cancel();
    _ticker?.cancel();
    super.dispose();
  }
}
