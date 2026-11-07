import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:material_ui/material_ui.dart';

import '../../utils/utils.dart';

part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

class AppLanguage {
  static const String hu = 'hu';
  static const String en = 'en';
}

@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(AppLanguage.hu) String languageCode,
    @Default(ThemeMode.system) ThemeMode themeMode,
  }) = _AppSettings;

  factory AppSettings.fromJson(Json json) => _$AppSettingsFromJson(json);
}
