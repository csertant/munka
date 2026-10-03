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
  Stream<TimeEntry?> watchActiveEntry() {
    return _database.watchActiveEntry();
  }

  @override
  Stream<List<TimeEntry>> watchRecentEntries() {
    return _database.watchRecentEntries();
  }

  @override
  Future<Result<Id>> startTimer({required TimeEntriesCompanion entry}) {
    return guard(() => _database.startTimer(entry));
  }

  @override
  Future<Result<void>> stopTimer(Id id) {
    return guard(() => _database.stopTimer(id));
  }

  @override
  Future<Result<void>> deleteEntry(Id id) {
    return guard(() => _database.deleteEntry(id));
  }
}
