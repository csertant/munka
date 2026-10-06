import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../../../utils/utils.dart';
import '../../database/database.dart';
import '../../services/database_service/database_service.dart';
import 'session_manager.dart';

class SessionManagerProd extends ChangeNotifier implements SessionManager {
  SessionManagerProd({required this._databaseService});

  final DatabaseService _databaseService;

  Session? _session;

  @override
  Id? get profileId => _session?.profileId;
  @override
  bool get hasSessionPresent => _session != null;

  @override
  Future<Result<void>> loadSavedSession() async {
    final result = await _databaseService.getSession();
    if (result is Ok<Session>) {
      _session = result.value;
      notifyListeners();
    }
    return switch (result) {
      Ok<Session>() => const Result.ok(null),
      Error<Session>() => Result.error(result.error),
    };
  }

  @override
  Future<Result<void>> initializeSession({required Id profileId}) async {
    final session = SessionsCompanion.insert(
      id: const Value(1),
      profileId: profileId,
    );
    final result = await _databaseService.saveSession(session: session);
    if (result is Ok<void>) {
      _session = Session(id: 1, profileId: profileId);
      notifyListeners();
    }
    return result;
  }

  @override
  Future<Result<void>> endSession() {
    final removeResult = _databaseService.removeSession();
    if (removeResult is Ok<void>) {
      _session = null;
      notifyListeners();
    }
    return removeResult;
  }
}
