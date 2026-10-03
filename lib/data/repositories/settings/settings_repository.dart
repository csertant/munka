import 'package:material_ui/material_ui.dart';

import '../../../domain/models/app_settings.dart';
import '../../../utils/result.dart';

abstract class SettingsRepository extends ChangeNotifier {
  AppSettings get appSettings;

  String get versionString;

  Future<Result<void>> load();

  Future<Result<void>> updateLanguage({required AppLanguage languageCode});

  Future<Result<void>> updateTheme({required ThemeMode theme});
}
