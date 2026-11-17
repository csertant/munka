import 'package:material_ui/material_ui.dart';

import '../../l10n/generated/app_localizations.dart';
import '../core/themes/dimensions.dart';
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
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar.text(
        text: widget.viewModel.isEditing
            ? localizations.settingsProfilesEditScreenTitle
            : localizations.settingsProfilesNewScreenTitle,
      ),
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
              label: localizations.buttonLabelReload,
              onPressed: widget.viewModel.load.execute,
            );
          }
        },
        child: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, child) {
            final isEditing = widget.viewModel.isEditing;
            final profile = widget.viewModel.profile;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                child: Column(
                  children: [
                    const SizedBox(height: AppDimensions.paddingLarge),
                    CustomCircleAvatar(
                      iconPath: CustomIcons.fromName(
                        isEditing ? profile!.name : '',
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingMedium),
                    Text(
                      isEditing ? '@${profile!.id}' : '@?',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.colorScheme.onTertiary,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingSmall),
                    CustomTextField(
                      controller: widget.viewModel.nameController,
                      labelText: localizations.settingsProfileName,
                      required: true,
                    ),
                    const SizedBox(height: AppDimensions.paddingSmall),
                    CustomTextField(
                      controller: widget.viewModel.descriptionController,
                      labelText: localizations.settingsProfileDescription,
                    ),
                    const SizedBox(height: AppDimensions.paddingSmall),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadiusMedium,
                        ),
                      ),
                      title: Text(
                        localizations.settingsProfileIsDefault,
                        style: theme.textTheme.bodyMedium,
                      ),
                      value: widget.viewModel.isDefaultProfile,
                      onChanged: widget.viewModel.setIsDefault,
                    ),
                    const SizedBox(height: AppDimensions.paddingLarge),
                    OutlinedButton(
                      onPressed: isEditing
                          ? () => widget.viewModel.modifyProfile.execute()
                          : () async {
                              await widget.viewModel.createProfile.execute();
                              if (context.mounted && !isEditing) {
                                Navigator.of(context).pop();
                              }
                            },
                      child: Text(localizations.buttonLabelSave),
                    ),
                  ],
                ),
              ),
            );
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
