// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) => _AppSettings(
  languageCode:
      $enumDecodeNullable(_$AppLanguageEnumMap, json['languageCode']) ??
      AppLanguage.hu,
  themeMode:
      $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
      ThemeMode.system,
);

Map<String, dynamic> _$AppSettingsToJson(_AppSettings instance) =>
    <String, dynamic>{
      'languageCode': _$AppLanguageEnumMap[instance.languageCode]!,
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
    };

const _$AppLanguageEnumMap = {AppLanguage.hu: 'hu', AppLanguage.en: 'en'};

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
