import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:material_ui/material_ui.dart';

import '../../utils/utils.dart';

part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

enum AppLanguage {
  hu,
  en;

  @override
  String toString() => name;
}

@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(AppLanguage.hu) AppLanguage languageCode,
    @Default(ThemeMode.system) ThemeMode themeMode,
  }) = _AppSettings;

  factory AppSettings.fromJson(Json json) => _$AppSettingsFromJson(json);
}
