import '../../../utils/utils.dart';
import '../../database/database.dart';

abstract class TimeEntriesRepository {
  Stream<TimeEntry?> watchActiveEntry();
  Stream<List<TimeEntry>> watchRecentEntries();

  Future<Result<void>> startTimer({required Id profileId});

  Future<Result<void>> stopTimer({required TimeEntry entry});

  Future<Result<void>> saveEntry({
    required Id profileId,
    String? project,
    String? notes,
    required DateTime startedAt,
  });

  Future<Result<void>> modifyEntry({required TimeEntry entry});

  Future<Result<void>> removeEntry({required Id entryId});
}
