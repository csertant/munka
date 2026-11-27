import 'package:drift/drift.dart';

import '../../../utils/utils.dart';
import '../../database/database.dart';
import '../../services/csv_service/csv_service.dart';
import '../../services/database_service/database_service.dart';
import 'timeentries_repository.dart';

class TimeEntriesRepositoryLocal extends TimeEntriesRepository {
  TimeEntriesRepositoryLocal({
    required this._databaseService,
    required this._csvService,
  });

  final DatabaseService _databaseService;
  final CsvService _csvService;

  @override
  Future<Result<TimeEntry?>> getActiveEntry({required Id profileId}) {
    return _databaseService.getActiveEntry(profileId: profileId);
  }

  @override
  Future<Result<List<TimeEntry>>> getRecentEntries({required Id profileId}) {
    return _databaseService.getRecentEntries(profileId: profileId);
  }

  @override
  Future<Result<TimeEntry>> getTimeEntryById({required Id timeEntryId}) {
    return _databaseService.getTimeEntryById(timeEntryId: timeEntryId);
  }

  @override
  Stream<TimeEntry?> watchActiveEntry({required Id profileId}) {
    return _databaseService.watchActiveEntry(profileId: profileId);
  }

  @override
  Stream<List<TimeEntry>> watchRecentEntries({required Id profileId}) {
    return _databaseService.watchRecentEntries(profileId: profileId);
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
    return _databaseService.saveEntry(entry: entry.toCompanion(true));
  }

  @override
  Future<Result<void>> saveEntry({
    required Id profileId,
    String? project,
    String? notes,
    required DateTime startedAt,
    DateTime? endedAt,
  }) {
    final entry = TimeEntriesCompanion.insert(
      profileId: profileId,
      project: Value(project?.trim()),
      notes: Value(notes?.trim()),
      startedAt: startedAt,
      endedAt: Value(endedAt),
    );
    return _databaseService.saveEntry(entry: entry);
  }

  @override
  Future<Result<void>> modifyEntry({required TimeEntry entry}) {
    return _databaseService.saveEntry(entry: entry.toCompanion(true));
  }

  @override
  Future<Result<void>> removeEntry({required Id entryId}) {
    return _databaseService.removeEntry(timeEntryId: entryId);
  }

  @override
  Future<Result<void>> clearTemporaryCsvFiles() {
    return _csvService.clearTemporaryCsvFiles();
  }

  @override
  Future<Result<void>> exportTimeEntriesToCsv({
    required List<TimeEntry> timeEntries,
  }) {
    return _csvService.exportTimeEntriesToCsv(timeEntries: timeEntries);
  }
}
