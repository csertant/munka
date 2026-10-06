import 'package:flutter/foundation.dart';

import '../../../utils/utils.dart';

abstract class SessionManager extends ChangeNotifier {
  Id? get profileId;
  bool get hasSessionPresent;

  Future<Result<void>> loadSavedSession();

  Future<Result<void>> initializeSession({required Id profileId});

  Future<Result<void>> endSession();
}
