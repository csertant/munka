import '../../../utils/utils.dart';
import '../../database/database.dart';

abstract class DatabaseService {
  Stream<TimeEntry?> watchActiveEntry();
  Stream<List<TimeEntry>> watchRecentEntries();
  Future<Result<Id>> startTimer(Id profileId, {String? project, String? notes});
  Future<Result<void>> stopTimer(Id id);
  Future<Result<void>> deleteEntry(Id id);
}
