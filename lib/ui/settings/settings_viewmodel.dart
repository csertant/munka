import 'dart:async';
import 'dart:collection';

import 'package:drift/drift.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/database/database.dart';
import '../../data/managers/session/session_manager.dart';
import '../../data/repositories/profile/profile_repository.dart';
import '../../data/repositories/settings/settings_repository.dart';
import '../../domain/models/app_settings.dart';
import '../../l10n/generated/app_localizations.dart';

import '../../utils/utils.dart';

class SettingsViewModel extends ChangeNotifier {
  SettingsViewModel({
    required this._profileRepository,
    required this._settingsRepository,
    required this._sessionManager,
  }) {
    load = Command0(_load);
    updateTheme = Command1(_updateTheme);
    updateLanguage = Command1(_updateLanguage);
    createProfile = Command2(_createProfile);
    modifyProfile = Command1(_modifyProfile);
    removeProfile = Command1(_removeProfile);
    switchProfile = Command1(_switchProfile);

    _settingsRepository.addListener(notifyListeners);
    _sessionManager.addListener(notifyListeners);
    _profilesSubscription = _profileRepository.watchProfiles().listen((
      profiles,
    ) {
      _profiles = profiles;
      notifyListeners();
    });

    unawaited(load.execute());
  }

  final ProfileRepository _profileRepository;
  final SettingsRepository _settingsRepository;
  final SessionManager _sessionManager;
  late final StreamSubscription<List<Profile>> _profilesSubscription;

  List<Profile> _profiles = [];

  late Command0<void> load;
  late Command1<void, ThemeMode> updateTheme;
  late Command1<void, AppLanguage> updateLanguage;
  late Command2<void, String, String?> createProfile;
  late Command1<void, Profile> modifyProfile;
  late Command1<void, Profile> removeProfile;
  late Command1<void, Profile> switchProfile;
  late Command3<void, bool, bool, DateTime?> removeArticles;

  AppSettings get appSettings => _settingsRepository.appSettings;
  ThemeMode get theme => appSettings.theme;
  AppLanguage get language => appSettings.languageCode;
  Profile get activeProfile => _profiles.firstWhere(
    (profile) => profile.id == _sessionManager.profileId,
  );
  List<Profile> get profiles => UnmodifiableListView(_profiles);
  List<Locale> get availableLocales => AppLocalizations.supportedLocales;
  List<ThemeMode> get availableThemes => ThemeMode.values;
  String get versionString => _settingsRepository.versionString;

  Future<Result<void>> _load() async {
    try {
      return await _settingsRepository.load();
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _updateTheme(ThemeMode theme) {
    return _settingsRepository.updateTheme(theme: theme);
  }

  Future<Result<void>> _updateLanguage(AppLanguage languageCode) {
    return _settingsRepository.updateLanguage(languageCode: languageCode);
  }

  Future<Result<void>> _createProfile(String name, String? description) {
    try {
      return _profileRepository.saveProfile(
        name: name.trim(),
        description: description?.trim(),
      );
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _switchProfile(Profile profile) {
    return _sessionManager.initializeSession(profileId: profile.id);
  }

  Future<Result<void>> _modifyProfile(Profile profile) {
    try {
      return _profileRepository.modifyProfile(
        profile: profile.copyWith(
          name: profile.name.trim(),
          description: Value(profile.description?.trim()),
        ),
      );
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _removeProfile(Profile profile) async {
    try {
      final isActiveProfile = activeProfile.id == profile.id;
      final remainingProfiles = _profiles
          .where((existingProfile) => existingProfile.id != profile.id)
          .toList();
      final removeResult = await _profileRepository.removeProfile(
        profileId: profile.id,
      );
      if (removeResult is Ok<void> &&
          isActiveProfile &&
          remainingProfiles.isNotEmpty) {
        return await _sessionManager.initializeSession(
          profileId: remainingProfiles.first.id,
        );
      }
      return removeResult;
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<void> dispose() async {
    _settingsRepository.removeListener(notifyListeners);
    _sessionManager.removeListener(notifyListeners);
    await _profilesSubscription.cancel();
    super.dispose();
  }
}
