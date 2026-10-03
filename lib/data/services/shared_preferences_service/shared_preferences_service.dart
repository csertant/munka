import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/models/app_settings.dart';
import '../../../utils/utils.dart';

class SharedPreferencesService {
  final _appSettingsKey = 'APP_SETTINGS';
  final _sharedPreferences = SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(),
  );

  Future<Result<AppSettings>> getAppSettings() async {
    try {
      final sharedPreferences = await _sharedPreferences;
      final result = sharedPreferences.getString(_appSettingsKey);
      if (result != null) {
        return Result.ok(AppSettings.fromJson(json.decode(result) as Json));
      }
      return Result.error(DatabaseError('App settings not found'));
    } on Exception catch (e) {
      return Result.error(AppError.fromError(e));
    }
  }

  Future<Result<void>> saveAppSettings({
    required AppSettings appSettings,
  }) async {
    try {
      final sharedPreferences = await _sharedPreferences;
      await sharedPreferences.setString(
        _appSettingsKey,
        json.encode(appSettings.toJson()),
      );
      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(AppError.fromError(e));
    }
  }
}
