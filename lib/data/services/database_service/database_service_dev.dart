import '../../../utils/utils.dart';
import '../../database/database.dart';
import 'database_service.dart';

final Profile defaultProfile = Profile(
  id: 1,
  name: 'Default Profile',
  description: 'This is the default profile.',
  isDefault: true,
  createdAt: DateTime.now().subtract(const Duration(days: 1)),
  updatedAt: DateTime.now(),
);
final Profile otherProfile = Profile(
  id: 2,
  name: 'Other Profile',
  isDefault: false,
  createdAt: DateTime.now().subtract(const Duration(days: 2)),
  updatedAt: DateTime.now(),
);
final TimeEntry exampleActiveEntry = TimeEntry(
  id: 1,
  profileId: 1,
  project: 'Example Project A',
  notes: 'Example Notes',
  startedAt: DateTime.now().subtract(const Duration(minutes: 5)),
);
final List<TimeEntry> exampleRecentEntries = [
  TimeEntry(
    id: 2,
    profileId: 1,
    project: 'Example Project A',
    notes: 'Example Notes 2',
    startedAt: DateTime.now().subtract(const Duration(minutes: 20)),
    endedAt: DateTime.now().subtract(const Duration(minutes: 15)),
  ),
  TimeEntry(
    id: 3,
    profileId: 1,
    project: 'Example Project B',
    notes: 'Example Notes 3',
    startedAt: DateTime.now().subtract(const Duration(minutes: 10)),
    endedAt: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
];

class DatabaseServiceDev implements DatabaseService {
  @override
  Future<Result<Session>> getSession() async {
    return const Result.ok(Session(id: 1, profileId: 1));
  }

  @override
  Future<Result<void>> saveSession({required SessionsCompanion session}) async {
    return const Result.ok(null);
  }

  @override
  Future<Result<void>> removeSession() async {
    return const Result.ok(null);
  }

  @override
  Future<Result<List<Profile>>> getProfiles() async {
    return Result.ok([defaultProfile, otherProfile]);
  }

  @override
  Future<Result<Profile>> getDefaultProfile() async {
    return Result.ok(defaultProfile);
  }

  @override
  Future<Result<void>> saveProfile({required ProfilesCompanion profile}) async {
    return const Result.ok(null);
  }

  @override
  Future<Result<void>> removeProfile({required Id profileId}) async {
    return const Result.ok(null);
  }

  @override
  Stream<List<Profile>> watchProfiles() {
    return Stream.value([defaultProfile, otherProfile]);
  }

  // ---- TimeEntry management ----

  @override
  Stream<TimeEntry?> watchActiveEntry() {
    return Stream.value(exampleActiveEntry);
  }

  @override
  Stream<List<TimeEntry>> watchRecentEntries() {
    return Stream.value(exampleRecentEntries);
  }

  @override
  Future<Result<Id>> startTimer({required TimeEntriesCompanion entry}) async {
    return const Result.ok(1);
  }

  @override
  Future<Result<void>> stopTimer(Id id) async {
    return const Result.ok(null);
  }

  @override
  Future<Result<void>> deleteEntry(Id id) async {
    return const Result.ok(null);
  }
}
