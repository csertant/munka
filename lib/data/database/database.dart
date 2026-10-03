import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../utils/utils.dart';

part 'database.g.dart';

class Profiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();

  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class Sessions extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get profileId =>
      integer().references(Profiles, #id, onDelete: KeyAction.cascade)();
}

class TimeEntries extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get profileId =>
      integer().references(Profiles, #id, onDelete: KeyAction.cascade)();

  TextColumn get project => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
}

@DriftDatabase(tables: [Profiles, Sessions, TimeEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'munka',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationDocumentsDirectory,
      ),
    );
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');

        // Ensure at least one profile exists.
        await customStatement(
          'INSERT INTO profiles (name, is_default, created_at, updated_at) '
          "SELECT 'Default Profile', 1, "
          "cast(strftime('%s', 'now') as integer), "
          "cast(strftime('%s', 'now') as integer) "
          'WHERE NOT EXISTS (SELECT 1 FROM profiles)',
        );

        // Keep a single default profile (lowest id wins).
        await customStatement(
          'UPDATE profiles SET is_default = 0 '
          'WHERE id NOT IN '
          '(SELECT id FROM profiles WHERE is_default = 1 ORDER BY id LIMIT 1)',
        );
        await customStatement(
          'UPDATE profiles SET is_default = 1 '
          'WHERE id = (SELECT id FROM profiles ORDER BY id LIMIT 1) '
          'AND NOT EXISTS (SELECT 1 FROM profiles WHERE is_default = 1)',
        );

        // Keep session table singleton-safe.
        await customStatement(
          'DELETE FROM sessions '
          'WHERE id NOT IN (SELECT id FROM sessions ORDER BY id DESC LIMIT 1)',
        );
        await customStatement(
          'UPDATE sessions SET id = 1 '
          'WHERE id = (SELECT id FROM sessions ORDER BY id DESC LIMIT 1) '
          'AND id != 1',
        );
      },
    );
  }

  // ---- Session management ----

  Future<Session?> getSession() {
    return select(sessions).getSingleOrNull();
  }

  Future<void> insertOrUpdateSession({required SessionsCompanion session}) {
    return into(sessions).insertOnConflictUpdate(session);
  }

  Future<void> deleteSession() {
    return delete(sessions).go();
  }

  // ---- Profile management ----

  Future<List<Profile>> getProfiles() {
    return select(profiles).get();
  }

  Future<Profile> getDefaultProfile() {
    return (select(
      profiles,
    )..where((p) => p.isDefault.equals(true))).getSingle();
  }

  Future<void> insertOrUpdateProfile({required ProfilesCompanion profile}) {
    return into(profiles).insertOnConflictUpdate(profile);
  }

  Future<void> deleteProfile({required Id profileId}) {
    return (delete(profiles)..where((p) => p.id.equals(profileId))).go();
  }

  Stream<List<Profile>> watchProfiles() {
    return select(profiles).watch();
  }

  // ---- TimeEntry management ----

  Stream<TimeEntry?> watchActiveEntry() {
    return (select(timeEntries)
          ..where((tbl) => tbl.endedAt.isNull())
          ..limit(1))
        .watchSingleOrNull();
  }

  Stream<List<TimeEntry>> watchRecentEntries() {
    return (select(timeEntries)
          ..where((tbl) => tbl.endedAt.isNotNull())
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.startedAt)]))
        .watch();
  }

  Future<Id> startTimer(TimeEntriesCompanion entry) {
    return into(timeEntries).insert(entry);
  }

  Future<void> stopTimer(Id id) {
    return (update(timeEntries)..where((tbl) => tbl.id.equals(id))).write(
      TimeEntriesCompanion(endedAt: Value(DateTime.now())),
    );
  }

  Future<void> deleteEntry(Id id) {
    return (delete(timeEntries)..where((tbl) => tbl.id.equals(id))).go();
  }
}
