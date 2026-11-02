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

  Stream<TimeEntry?> watchActiveEntry({required Id profileId});
  Stream<List<TimeEntry>> watchRecentEntries({required Id profileId});
  Future<Result<void>> saveEntry({required TimeEntriesCompanion entry});
  Future<Result<void>> removeEntry({required Id id});
}
