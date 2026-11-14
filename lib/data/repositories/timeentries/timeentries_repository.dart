import '../../../utils/utils.dart';
import '../../database/database.dart';

abstract class TimeEntriesRepository {
  Future<Result<TimeEntry?>> getActiveEntry({required Id profileId});
  Future<Result<List<TimeEntry>>> getRecentEntries({required Id profileId});

  Stream<TimeEntry?> watchActiveEntry({required Id profileId});
  Stream<List<TimeEntry>> watchRecentEntries({required Id profileId});

  Future<Result<void>> startTimer({required Id profileId});
  Future<Result<void>> stopTimer({required TimeEntry entry});

  Future<Result<void>> saveEntry({
    required Id profileId,
    String? project,
    String? notes,
    required DateTime startedAt,
    DateTime? endedAt,
  });
  Future<Result<void>> modifyEntry({required TimeEntry entry});
  Future<Result<void>> removeEntry({required Id entryId});
}
