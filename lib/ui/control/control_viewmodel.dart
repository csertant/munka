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
    _timeEntriesStream = _timeEntriesRepository.watchRecentEntries(
      profileId: _sessionManager.profileId!,
    );
    _activeEntryStream = _timeEntriesRepository.watchActiveEntry(
      profileId: _sessionManager.profileId!,
    );

    unawaited(load.execute());
  }

  final SessionManager _sessionManager;
  final TimeEntriesRepository _timeEntriesRepository;
  late Stream<List<TimeEntry>> _timeEntriesStream;
  late Stream<TimeEntry?> _activeEntryStream;

  TimeEntry? _activeEntry;

  Timer? _ticker;
  DateTime _currentTime = DateTime.now();
  DateTime? _startedAt;
  Duration _elapsed = Duration.zero;

  late Command0<void> load;

  Stream<List<TimeEntry>> get timeEntriesStream => _timeEntriesStream;
  Stream<TimeEntry?> get activeEntryStream => _activeEntryStream;
  TimeEntry? get activeEntry => _activeEntry;
  bool get isTracking => _startedAt != null;
  DateTime get currentTime => _currentTime;
  Duration get elapsed => _elapsed;

  Future<Result<void>> _load() async {
    try {
      _startTicker();
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

  void _startTicker() {
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      _currentTime = now;

      if (_startedAt != null) {
        _elapsed = now.difference(_startedAt!);
      }
      notifyListeners();
    });
  }

  void startTracking({DateTime? existingStart}) {
    _startedAt = existingStart ?? DateTime.now();
    _elapsed = DateTime.now().difference(_startedAt!);
    notifyListeners();
  }

  void stopTracking() {
    _startedAt = null;
    _elapsed = Duration.zero;
    notifyListeners();
  }

  Future<void> _onSessionChanged() async {
    _timeEntriesStream = _timeEntriesRepository.watchRecentEntries(
      profileId: _sessionManager.profileId!,
    );
    _activeEntryStream = _timeEntriesRepository.watchActiveEntry(
      profileId: _sessionManager.profileId!,
    );
    unawaited(load.execute());
  }

  @override
  Future<void> dispose() async {
    _sessionManager.removeListener(_onSessionChanged);
    _ticker?.cancel();
    super.dispose();
  }
}
