import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/managers/session/session_manager.dart';
import '../data/repositories/profile/profile_repository.dart';
import '../data/repositories/settings/settings_repository.dart';
import '../data/repositories/timeentries/timeentries_repository.dart';
import '../ui/control/control_screen.dart';
import '../ui/control/control_viewmodel.dart';
import '../ui/core/widgets/widgets.dart';
import '../ui/settings/settings_screen.dart';
import '../ui/settings/settings_viewmodel.dart';
import '../ui/stats/stats_screen.dart';
import '../ui/stats/stats_viewmodel.dart';
import 'routes.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.control,
  debugLogDiagnostics: true,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return CustomScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.stats,
              builder: (context, state) {
                final viewModel = StatsViewModel(
                  sessionManager: context.read<SessionManager>(),
                  timeEntriesRepository: context.read<TimeEntriesRepository>(),
                );
                return StatsScreen(viewModel: viewModel);
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.control,
              builder: (context, state) {
                final viewModel = ControlViewModel(
                  sessionManager: context.read<SessionManager>(),
                  timeEntriesRepository: context.read<TimeEntriesRepository>(),
                );
                return ControlScreen(viewModel: viewModel);
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.settings,
              builder: (context, state) {
                final viewModel = SettingsViewModel(
                  profileRepository: context.read<ProfileRepository>(),
                  settingsRepository: context.read<SettingsRepository>(),
                  sessionManager: context.read<SessionManager>(),
                );
                return SettingsScreen(viewModel: viewModel);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
