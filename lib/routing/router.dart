import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/managers/session/session_manager.dart';
import '../data/repositories/profile/profile_repository.dart';
import '../data/repositories/settings/settings_repository.dart';
import '../data/repositories/timeentries/timeentries_repository.dart';
import '../ui/control/control_screen.dart';
import '../ui/control/control_viewmodel.dart';
import '../ui/control_entries/control_entries_screen.dart';
import '../ui/control_entries/control_entries_viewmodel.dart';
import '../ui/control_entries_list/control_entries_list_screen.dart';
import '../ui/control_entries_list/control_entries_list_viewmodel.dart';
import '../ui/core/widgets/widgets.dart';
import '../ui/settings/settings_screen.dart';
import '../ui/settings/settings_viewmodel.dart';
import '../ui/settings_profiles/settings_profiles_screen.dart';
import '../ui/settings_profiles/settings_profiles_viewmodel.dart';
import '../ui/share/share_screen.dart';
import '../ui/share/share_viewmodel.dart';
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
              routes: [
                GoRoute(
                  path: Routes.controlEntriesEditSegment(':id'),
                  builder: (context, state) {
                    final timeEntryId = state.pathParameters['id']!;
                    final viewModel = ControlEntriesViewModel(
                      timeEntriesRepository: context
                          .read<TimeEntriesRepository>(),
                      sessionManager: context.read<SessionManager>(),
                      timeEntryId: int.tryParse(timeEntryId),
                    );
                    return ControlEntriesScreen(viewModel: viewModel);
                  },
                ),
                GoRoute(
                  path: Routes.controlEntriesNewSegment,
                  builder: (context, state) {
                    final viewModel = ControlEntriesViewModel(
                      timeEntriesRepository: context
                          .read<TimeEntriesRepository>(),
                      sessionManager: context.read<SessionManager>(),
                    );
                    return ControlEntriesScreen(viewModel: viewModel);
                  },
                ),
                GoRoute(
                  path: Routes.controlEntriesListSegment,
                  builder: (context, state) {
                    final viewModel = ControlEntriesListViewModel(
                      timeEntriesRepository: context
                          .read<TimeEntriesRepository>(),
                      sessionManager: context.read<SessionManager>(),
                    );
                    return ControlEntriesListScreen(viewModel: viewModel);
                  },
                ),
                GoRoute(
                  path: Routes.share,
                  builder: (context, state) {
                    final viewModel = ShareViewModel(
                      timeEntriesRepository: context
                          .read<TimeEntriesRepository>(),
                    );
                    return ShareScreen(viewModel: viewModel);
                  },
                ),
              ],
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
              routes: [
                GoRoute(
                  path: Routes.settingsProfileEditSegment(':id'),
                  builder: (context, state) {
                    final profileId = state.pathParameters['id']!;
                    final viewModel = SettingsProfilesViewModel(
                      profileRepository: context.read<ProfileRepository>(),
                      profileId: int.tryParse(profileId),
                    );
                    return SettingsProfilesScreen(viewModel: viewModel);
                  },
                ),
                GoRoute(
                  path: Routes.settingsProfileNewSegment,
                  builder: (context, state) {
                    final viewModel = SettingsProfilesViewModel(
                      profileRepository: context.read<ProfileRepository>(),
                    );
                    return SettingsProfilesScreen(viewModel: viewModel);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
