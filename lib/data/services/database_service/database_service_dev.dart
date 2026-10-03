import '../../../utils/utils.dart';
import '../../database/database.dart';
import 'database_service.dart';

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
  Stream<TimeEntry?> watchActiveEntry() {
    return Stream.value(exampleActiveEntry);
  }

  @override
  Stream<List<TimeEntry>> watchRecentEntries() {
    return Stream.value(exampleRecentEntries);
  }

  @override
  Future<Result<Id>> startTimer(
    Id profileId, {
    String? project,
    String? notes,
  }) async {
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
