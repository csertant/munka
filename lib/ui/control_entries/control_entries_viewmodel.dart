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
    createTimeEntry = Command0(_createTimeEntry);
    modifyTimeEntry = Command0(_modifyTimeEntry);

    _sessionManager.addListener(_onSessionChanged);

    unawaited(load.execute());
  }

  final TimeEntriesRepository _timeEntriesRepository;
  final SessionManager _sessionManager;

  final Id? _timeEntryId;
  TimeEntry? _timeEntry;
  final TextEditingController projectController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  DateTime? _startedAt;
  DateTime? _endedAt;

  late Command0<void> load;
  late Command0<void> createTimeEntry;
  late Command0<void> modifyTimeEntry;

  bool get isEditing => _timeEntryId != null;
  TimeEntry? get timeEntry => _timeEntry;
  DateTime? get startedAt => _startedAt;
  DateTime? get endedAt => _endedAt;

  Future<Result<void>> _load() async {
    try {
      final profileId = _sessionManager.profileId;
      if (profileId == null) {
        return Result.error(NotFoundError('No active session found'));
      }
      if (!isEditing) {
        projectController.text = '';
        notesController.text = '';
        _startedAt = null;
        _endedAt = null;
        return const Result.ok(null);
      }
      final timeEntryResult = await _timeEntriesRepository.getTimeEntryById(
        timeEntryId: _timeEntryId!,
      );
      switch (timeEntryResult) {
        case Ok<TimeEntry>():
          _timeEntry = timeEntryResult.value;
          if (_timeEntry == null) {
            return Result.error(NotFoundError('Time entry not found.'));
          }
          projectController.text = _timeEntry!.project ?? '';
          notesController.text = _timeEntry!.notes ?? '';
          _startedAt = _timeEntry!.startedAt;
          _endedAt = _timeEntry!.endedAt;
          return const Result.ok(null);
        case Error<TimeEntry>():
          return Result.error(timeEntryResult.error);
      }
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _createTimeEntry() async {
    try {
      if (_startedAt == null || _endedAt == null) {
        return Result.error(
          ValidationError('Start and end time are required.'),
        );
      }
      return await _timeEntriesRepository.saveEntry(
        profileId: _sessionManager.profileId!,
        project: projectController.text.trim(),
        notes: notesController.text.trim(),
        startedAt: _startedAt!,
        endedAt: _endedAt,
      );
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _modifyTimeEntry() async {
    try {
      if (_startedAt == null || _endedAt == null) {
        return Result.error(
          ValidationError('Start and end time are required.'),
        );
      }
      return await _timeEntriesRepository.modifyEntry(
        entry: timeEntry!.copyWith(
          project: Value(projectController.text.trim()),
          notes: Value(notesController.text.trim()),
          startedAt: _startedAt,
          endedAt: Value(_endedAt),
        ),
      );
    } finally {
      notifyListeners();
    }
  }

  Future<void> _onSessionChanged() async {
    await load.execute();
  }

  void setStartedAt(DateTime? value) {
    _startedAt = value;
    notifyListeners();
  }

  void setEndedAt(DateTime? value) {
    _endedAt = value;
    notifyListeners();
  }

  @override
  Future<void> dispose() async {
    _sessionManager.removeListener(_onSessionChanged);
    super.dispose();
  }
}
