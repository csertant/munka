import 'package:drift/drift.dart';

import '../../../utils/utils.dart';
import '../../database/database.dart';
import '../../services/database_service/database_service.dart';
import 'timeentries_repository.dart';

class TimeEntriesRepositoryLocal extends TimeEntriesRepository {
  TimeEntriesRepositoryLocal({required this._databaseService});

  final DatabaseService _databaseService;

  @override
  Stream<TimeEntry?> watchActiveEntry() {
    return _databaseService.watchActiveEntry();
  }

  @override
  Stream<List<TimeEntry>> watchRecentEntries() {
    return _databaseService.watchRecentEntries();
  }

  @override
  Future<Result<void>> startTimer({required Id profileId}) {
    final entry = TimeEntriesCompanion.insert(
      profileId: profileId,
      startedAt: DateTime.now(),
    );
    return _databaseService.saveEntry(entry: entry);
  }

  @override
  Future<Result<void>> stopTimer({required TimeEntry entry}) {
    final modifiedEntry = entry.copyWith(endedAt: Value(DateTime.now()));
    return _databaseService.saveEntry(entry: modifiedEntry.toCompanion(true));
  }

  @override
  Future<Result<void>> saveEntry({
    required Id profileId,
    String? project,
    String? notes,
    required DateTime startedAt,
  }) {
    final entry = TimeEntriesCompanion.insert(
      profileId: profileId,
      project: Value(project?.trim()),
      notes: Value(notes?.trim()),
      startedAt: startedAt,
    );
    return _databaseService.saveEntry(entry: entry);
  }

  @override
  Future<Result<void>> modifyEntry({required TimeEntry entry}) {
    return _databaseService.saveEntry(entry: entry.toCompanion(true));
  }

  @override
  Future<Result<void>> removeEntry({required Id entryId}) {
    return _databaseService.removeEntry(id: entryId);
  }
}
