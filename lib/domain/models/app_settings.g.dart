// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) => _AppSettings(
  languageCode: json['languageCode'] as String? ?? AppLanguage.hu,
  themeMode:
      $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
      ThemeMode.system,
);

Map<String, dynamic> _$AppSettingsToJson(_AppSettings instance) =>
    <String, dynamic>{
      'languageCode': instance.languageCode,
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
