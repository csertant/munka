import '../../../utils/utils.dart';
import '../../database/database.dart';
import 'database_service.dart';

class DatabaseServiceProd implements DatabaseService {
  DatabaseServiceProd({required this._database});

  final AppDatabase _database;

  @override
  Stream<TimeEntry?> watchActiveEntry() {
    return _database.watchActiveEntry();
  }

  @override
  Stream<List<TimeEntry>> watchRecentEntries() {
    return _database.watchRecentEntries();
  }

  @override
  Future<Result<Id>> startTimer(
    Id profileId, {
    String? project,
    String? notes,
  }) {
    return guard(
      () => _database.startTimer(profileId, project: project, notes: notes),
    );
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
