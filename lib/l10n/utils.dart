import 'package:material_ui/material_ui.dart';

import '../domain/models/app_settings.dart';
import 'generated/app_localizations.dart';

String mapThemeModeToString(BuildContext context, ThemeMode theme) {
  final localizations = AppLocalizations.of(context)!;
  switch (theme) {
    case ThemeMode.light:
      return localizations.settingsThemeOptionLight;
    case ThemeMode.dark:
      return localizations.settingsThemeOptionDark;
    case ThemeMode.system:
      return localizations.settingsThemeOptionSystem;
  }
}

String mapLanguageCodeToString(BuildContext context, String languageCode) {
  final localizations = AppLocalizations.of(context)!;
  switch (languageCode) {
    case AppLanguage.hu:
      return localizations.settingsLanguageOptionHungarian;
    case AppLanguage.en:
      return localizations.settingsLanguageOptionEnglish;
    default:
      return localizations.settingsLanguageOptionUnknown;
  }
}
