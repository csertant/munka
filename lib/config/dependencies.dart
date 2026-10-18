import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/database/database.dart';
import '../data/managers/session/session_manager.dart';
import '../data/managers/session/session_manager_dev.dart';
import '../data/managers/session/session_manager_prod.dart';
import '../data/repositories/settings/settings_repository.dart';
import '../data/repositories/settings/settings_repository_local.dart';
import '../data/services/database_service/database_service.dart';
import '../data/services/database_service/database_service_dev.dart';
import '../data/services/database_service/database_service_prod.dart';
import '../data/services/shared_preferences_service/shared_preferences_service.dart';

List<SingleChildWidget> _sharedProviders = [
  Provider(create: (context) => SharedPreferencesService()),
  ChangeNotifierProvider(
    create: (context) => SettingsRepositoryLocal(
      sharedPreferencesService: context.read<SharedPreferencesService>(),
    ) as SettingsRepository,
  ),
];

List<SingleChildWidget> get stagingProviders {
  return [
    Provider<AppDatabase>(
      create: (context) => AppDatabase(),
      dispose: (context, database) => database.close(),
    ),
    Provider(
      create: (context) =>
          DatabaseServiceProd(database: context.read<AppDatabase>())
              as DatabaseService,
    ),
    ..._sharedProviders,
    ChangeNotifierProvider(
      create: (context) =>
          SessionManagerProd(databaseService: context.read<DatabaseService>())
              as SessionManager,
    ),
  ];
}

List<SingleChildWidget> get developmentProviders {
  return [
    Provider(create: (context) => DatabaseServiceDev() as DatabaseService),
    ..._sharedProviders,
    ChangeNotifierProvider(
      create: (context) => SessionManagerDev() as SessionManager,
    ),
  ];
}
