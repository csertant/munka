import 'dart:async';

import 'package:drift/drift.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/database/database.dart';
import '../../data/repositories/profile/profile_repository.dart';
import '../../utils/utils.dart';

class SettingsProfilesViewModel extends ChangeNotifier {
  SettingsProfilesViewModel({
    required this._profileRepository,
    this._profileId,
  }) {
    load = Command0(_load);
    createProfile = Command2(_createProfile);
    modifyProfile = Command1(_modifyProfile);

    unawaited(load.execute());
  }
  final ProfileRepository _profileRepository;

  final int? _profileId;
  Profile? _profile;

  late Command0<void> load;
  late Command2<void, String, String?> createProfile;
  late Command1<void, Profile> modifyProfile;

  bool get isEditing => _profileId != null;
  Profile? get profile => _profile;

  Future<Result<void>> _load() async {
    try {
      if (!isEditing) {
        return const Result.ok(null);
      }
      final profileResult = await _profileRepository.getProfileById(
        _profileId!,
      );
      switch (profileResult) {
        case Ok<Profile>():
          _profile = profileResult.value;
          return const Result.ok(null);
        case Error<Profile>():
          return Result.error(profileResult.error);
      }
    } finally {
      notifyListeners();
    }
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
}
