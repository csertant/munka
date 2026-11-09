import 'package:material_ui/material_ui.dart';

import '../../l10n/generated/app_localizations.dart';
import '../core/widgets/widgets.dart';
import 'settings_profiles_viewmodel.dart';

class SettingsProfilesScreen extends StatefulWidget {
  const SettingsProfilesScreen({super.key, required this.viewModel});

  final SettingsProfilesViewModel viewModel;

  @override
  State<SettingsProfilesScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsProfilesScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.createProfile.addListener(_onCreateProfileResult);
    widget.viewModel.modifyProfile.addListener(_onModifyProfileResult);
  }

  @override
  void didUpdateWidget(covariant SettingsProfilesScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.createProfile.removeListener(_onCreateProfileResult);
    widget.viewModel.createProfile.addListener(_onCreateProfileResult);
    oldWidget.viewModel.modifyProfile.removeListener(_onModifyProfileResult);
    widget.viewModel.modifyProfile.addListener(_onModifyProfileResult);
  }

  @override
  void dispose() {
    widget.viewModel.createProfile.removeListener(_onCreateProfileResult);
    widget.viewModel.modifyProfile.removeListener(_onModifyProfileResult);
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
            return const Center(child: Text('Settings Profiles Screen'));
          },
        ),
      ),
    );
  }

  void _onCreateProfileResult() {
    final localizations = AppLocalizations.of(context)!;
    showFeedbackOnResult(
      context: context,
      action: widget.viewModel.createProfile,
      successMessage: localizations.settingsProfileCreated,
      errorMessage: localizations.errorWhileCreatingProfile,
    );
  }

  void _onModifyProfileResult() {
    final localizations = AppLocalizations.of(context)!;
    showFeedbackOnResult(
      context: context,
      action: widget.viewModel.modifyProfile,
      successMessage: localizations.settingsProfileModified,
      errorMessage: localizations.errorWhileModifyingProfile,
    );
  }
}
