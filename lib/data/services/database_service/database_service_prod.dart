import '../../../utils/utils.dart';
import '../../database/database.dart';
import 'database_service.dart';

class DatabaseServiceProd implements DatabaseService {
  DatabaseServiceProd({required this._database});

  final AppDatabase _database;

  // ---- Session management ----

  @override
  Future<Result<Session>> getSession() {
    return guardNotNull(_database.getSession);
  }

  @override
  Future<Result<void>> saveSession({required SessionsCompanion session}) {
    return guardVoid(() => _database.insertOrUpdateSession(session: session));
  }

  @override
  Future<Result<void>> removeSession() {
    return guardVoid(_database.deleteSession);
  }

  // ---- Profile management ----

  @override
  Future<Result<List<Profile>>> getProfiles() {
    return guard(_database.getProfiles);
  }

  @override
  Future<Result<Profile>> getProfileById({required Id profileId}) {
    return guardNotNull(() => _database.getProfileById(profileId: profileId));
  }

  @override
  Future<Result<Profile>> getDefaultProfile() {
    return guard(_database.getDefaultProfile);
  }

  @override
  Future<Result<void>> saveProfile({required ProfilesCompanion profile}) {
    return guardVoid(() => _database.insertOrUpdateProfile(profile: profile));
  }

  @override
  Future<Result<void>> removeProfile({required Id profileId}) {
    return guardVoid(() => _database.deleteProfile(profileId: profileId));
  }

  @override
  Stream<List<Profile>> watchProfiles() {
    return _database.watchProfiles();
  }

  // ---- TimeEntry management ----

  @override
  Stream<TimeEntry?> watchActiveEntry({required Id profileId}) {
    return _database.watchActiveEntry(profileId: profileId);
  }

  @override
  Stream<List<TimeEntry>> watchRecentEntries({required Id profileId}) {
    return _database.watchRecentEntries(profileId: profileId);
  }

  @override
  Future<Result<TimeEntry?>> getActiveEntry({required Id profileId}) {
    return guard(() => _database.getActiveEntry(profileId: profileId));
  }

  @override
  Future<Result<List<TimeEntry>>> getRecentEntries({required Id profileId}) {
    return guard(() => _database.getRecentEntries(profileId: profileId));
  }

  @override
  Future<Result<TimeEntry>> getTimeEntryById({required Id timeEntryId}) {
    return guardNotNull(
      () => _database.getTimeEntryById(timeEntryId: timeEntryId),
    );
  }

  @override
  Future<Result<void>> saveEntry({required TimeEntriesCompanion entry}) {
    return guardVoid(() => _database.insertOrUpdateEntry(entry: entry));
  }

  @override
  Future<Result<void>> removeEntry({required Id timeEntryId}) {
    return guard(() => _database.deleteEntry(timeEntryId: timeEntryId));
  }
}
