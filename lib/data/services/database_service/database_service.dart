import '../../../utils/utils.dart';
import '../../database/database.dart';

abstract class DatabaseService {
  Future<Result<Session>> getSession();
  Future<Result<void>> saveSession({required SessionsCompanion session});
  Future<Result<void>> removeSession();

  Future<Result<List<Profile>>> getProfiles();
  Future<Result<Profile>> getProfileById({required Id profileId});
  Future<Result<Profile>> getDefaultProfile();
  Future<Result<void>> saveProfile({required ProfilesCompanion profile});
  Future<Result<void>> removeProfile({required Id profileId});
  Stream<List<Profile>> watchProfiles();

  Stream<TimeEntry?> watchActiveEntry({required Id profileId});
  Stream<List<TimeEntry>> watchRecentEntries({required Id profileId});
  Future<Result<TimeEntry?>> getActiveEntry({required Id profileId});
  Future<Result<List<TimeEntry>>> getRecentEntries({required Id profileId});
  Future<Result<TimeEntry>> getTimeEntryById({required Id timeEntryId});
  Future<Result<void>> saveEntry({required TimeEntriesCompanion entry});
  Future<Result<void>> removeEntry({required Id timeEntryId});
}
