import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../l10n/utils.dart';
import '../../routing/routes.dart';
import '../core/widgets/widgets.dart';
import 'settings_viewmodel.dart';
import 'widgets/settings_metadata.dart';
import 'widgets/settings_profiles.dart';
import 'widgets/settings_radio_group.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.viewModel});

  final SettingsViewModel viewModel;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.removeProfile.addListener(_onRemoveProfileResult);
  }

  @override
  void didUpdateWidget(covariant SettingsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.removeProfile.removeListener(_onRemoveProfileResult);
    widget.viewModel.removeProfile.addListener(_onRemoveProfileResult);
  }

  @override
  void dispose() {
    widget.viewModel.removeProfile.removeListener(_onRemoveProfileResult);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(title: localizations.settingsScreenTitle),
      body: ListenableBuilder(
        listenable: widget.viewModel.load,
        builder: (context, child) {
          if (widget.viewModel.load.completed) {
            return child!;
          } else if (widget.viewModel.load.running) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ErrorIndicator(
              title: localizations.settingsLoadErrorTitle,
              label: localizations.settingsLoadErrorLabel,
              onPressed: widget.viewModel.load.execute,
            );
          }
        },
        child: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SettingsProfiles(
                    profiles: widget.viewModel.profiles,
                    selectedProfile: widget.viewModel.activeProfile,
                    onNewProfile: () => context.go(Routes.settingsProfileNew),
                    onRemoveProfile: (profile) => unawaited(
                      widget.viewModel.removeProfile.execute(profile),
                    ),
                    onSwitchProfile: (profile) => {
                      if (profile != null)
                        unawaited(
                          widget.viewModel.switchProfile.execute(profile),
                        ),
                    },
                  ),
                  SettingsRadioGroup<ThemeMode>(
                    title: localizations.settingsThemeTitle,
                    subtitle: localizations.settingsThemeSubtitle,
                    options: widget.viewModel.availableThemes,
                    optionLabels: widget.viewModel.availableThemes
                        .map((e) => mapThemeModeToString(context, e))
                        .toList(),
                    selectedOption: widget.viewModel.themeMode,
                    onChanged: (theme) {
                      if (theme != null) {
                        unawaited(widget.viewModel.updateTheme.execute(theme));
                      }
                    },
                  ),
                  SettingsRadioGroup<String>(
                    title: localizations.settingsLanguageTitle,
                    subtitle: localizations.settingsLanguageSubtitle,
                    options: widget.viewModel.availableLocales
                        .map((e) => e.languageCode.toLowerCase())
                        .toList(),
                    optionLabels: widget.viewModel.availableLocales
                        .map(
                          (e) =>
                              mapLanguageCodeToString(context, e.languageCode),
                        )
                        .toList(),
                    selectedOption: widget.viewModel.language,
                    onChanged: (languageCode) {
                      if (languageCode != null) {
                        unawaited(
                          widget.viewModel.updateLanguage.execute(languageCode),
                        );
                      }
                    },
                  ),
                  SettingsMetadata(
                    versionString: widget.viewModel.versionString,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _onRemoveProfileResult() {
    final localizations = AppLocalizations.of(context)!;
    showFeedbackOnResult(
      context: context,
      action: widget.viewModel.removeProfile,
      successMessage: localizations.settingsProfileRemoved,
      errorMessage: localizations.errorWhileRemovingProfile,
    );
  }
}
