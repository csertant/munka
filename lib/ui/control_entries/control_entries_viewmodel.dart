import 'dart:async';

import 'package:drift/drift.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/database/database.dart';
import '../../data/managers/session/session_manager.dart';
import '../../data/repositories/timeentries/timeentries_repository.dart';
import '../../utils/utils.dart';

class ControlEntriesViewModel extends ChangeNotifier {
  ControlEntriesViewModel({
    required this._timeEntriesRepository,
    required this._sessionManager,
    this._timeEntryId,
  }) {
    load = Command0(_load);
    createTimeEntry = Command4(_createTimeEntry);
    modifyTimeEntry = Command4(_modifyTimeEntry);

    _sessionManager.addListener(_onSessionChanged);

    unawaited(load.execute());
  }

  final TimeEntriesRepository _timeEntriesRepository;
  final SessionManager _sessionManager;

  final Id? _timeEntryId;
  TimeEntry? _timeEntry;

  late Command0<void> load;
  late Command4<void, String?, String?, DateTime, DateTime> createTimeEntry;
  late Command4<void, String?, String?, DateTime, DateTime> modifyTimeEntry;

  bool get isEditing => _timeEntryId != null;
  TimeEntry? get timeEntry => _timeEntry;

  Future<Result<void>> _load() async {
    try {
      final profileId = _sessionManager.profileId;
      if (profileId == null) {
        return Result.error(NotFoundError('No active session found'));
      }
      if (!isEditing) {
        return const Result.ok(null);
      }
      final timeEntryResult = await _timeEntriesRepository.getTimeEntryById(
        timeEntryId: _timeEntryId!,
      );
      switch (timeEntryResult) {
        case Ok<TimeEntry>():
          _timeEntry = timeEntryResult.value;
          return const Result.ok(null);
        case Error<TimeEntry>():
          return Result.error(timeEntryResult.error);
      }
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _createTimeEntry(
    String? project,
    String? notes,
    DateTime startedAt,
    DateTime endedAt,
  ) {
    try {
      return _timeEntriesRepository.saveEntry(
        profileId: _sessionManager.profileId!,
        project: project?.trim(),
        notes: notes?.trim(),
        startedAt: startedAt,
        endedAt: endedAt,
      );
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _modifyTimeEntry(
    String? project,
    String? notes,
    DateTime startedAt,
    DateTime endedAt,
  ) {
    try {
      return _timeEntriesRepository.modifyEntry(
        entry: timeEntry!.copyWith(
          project: Value(project?.trim()),
          notes: Value(notes?.trim()),
          startedAt: startedAt,
          endedAt: Value(endedAt),
        ),
      );
    } finally {
      notifyListeners();
    }
  }

  Future<void> _onSessionChanged() async {
    await load.execute();
  }

  @override
  Future<void> dispose() async {
    _sessionManager.removeListener(_onSessionChanged);
    super.dispose();
  }
}
