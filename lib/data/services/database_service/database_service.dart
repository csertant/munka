import '../../../utils/utils.dart';
import '../../database/database.dart';

abstract class DatabaseService {
  Future<Result<Session>> getSession();
  Future<Result<void>> saveSession({required SessionsCompanion session});
  Future<Result<void>> removeSession();

  Future<Result<List<Profile>>> getProfiles();
  Future<Result<Profile>> getDefaultProfile();
  Future<Result<void>> saveProfile({required ProfilesCompanion profile});
  Future<Result<void>> removeProfile({required Id profileId});
  Stream<List<Profile>> watchProfiles();

  Stream<TimeEntry?> watchActiveEntry();
  Stream<List<TimeEntry>> watchRecentEntries();
  Future<Result<Id>> startTimer({required TimeEntriesCompanion entry});
  Future<Result<void>> stopTimer(Id id);
  Future<Result<void>> deleteEntry(Id id);
}
