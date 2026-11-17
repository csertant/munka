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
    createProfile = Command0(_createProfile);
    modifyProfile = Command0(_modifyProfile);

    unawaited(load.execute());
  }
  final ProfileRepository _profileRepository;

  final int? _profileId;
  Profile? _profile;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool _isDefaultProfile = false;

  late Command0<void> load;
  late Command0<void> createProfile;
  late Command0<void> modifyProfile;

  bool get isEditing => _profileId != null;
  Profile? get profile => _profile;
  bool get isDefaultProfile => _isDefaultProfile;

  Future<Result<void>> _load() async {
    try {
      if (!isEditing) {
        nameController.text = '';
        descriptionController.text = '';
        _isDefaultProfile = false;
        return const Result.ok(null);
      }
      final profileResult = await _profileRepository.getProfileById(
        _profileId!,
      );
      switch (profileResult) {
        case Ok<Profile>():
          _profile = profileResult.value;
          if (_profile == null) {
            return Result.error(NotFoundError('Profile not found.'));
          }
          _isDefaultProfile = _profile!.isDefault;
          nameController.text = _profile!.name;
          descriptionController.text = _profile!.description ?? '';
          return const Result.ok(null);
        case Error<Profile>():
          return Result.error(profileResult.error);
      }
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _createProfile() async {
    try {
      if (nameController.text.trim().isEmpty) {
        return Result.error(ValidationError('Profile name is required.'));
      }
      return await _profileRepository.saveProfile(
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
      );
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _modifyProfile() async {
    try {
      if (nameController.text.trim().isEmpty) {
        return Result.error(ValidationError('Profile name is required.'));
      }
      return await _profileRepository.modifyProfile(
        profile: profile!.copyWith(
          name: nameController.text.trim(),
          description: Value(descriptionController.text.trim()),
        ),
      );
    } finally {
      notifyListeners();
    }
  }

  void setIsDefault(bool value) {
    _isDefaultProfile = value;
    notifyListeners();
  }
}
