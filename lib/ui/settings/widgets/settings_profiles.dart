import 'package:material_ui/material_ui.dart';

import '../../../data/database/database.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../routing/routes.dart';
import '../../core/themes/dimensions.dart';
import '../../core/widgets/widgets.dart';

class SettingsProfiles extends StatelessWidget {
  const SettingsProfiles({
    super.key,
    required this.profiles,
    required this.selectedProfile,
    required this.onNewProfile,
    required this.onRemoveProfile,
    required this.onSwitchProfile,
  });

  final List<Profile> profiles;
  final Profile selectedProfile;
  final VoidCallback onNewProfile;
  final ValueChanged<Profile> onRemoveProfile;
  final ValueChanged<Profile?> onSwitchProfile;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final otherProfiles = profiles
        .where((profile) => profile != selectedProfile)
        .toList();
    return Column(
      children: [
        _buildActiveProfile(context, selectedProfile),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: otherProfiles.length,
          itemBuilder: (context, index) {
            final profile = otherProfiles[index];
            return _buildOtherProfile(context, profile);
          },
        ),
        InkWell(
          onTap: onNewProfile,
          child: Row(
            children: [
              const CustomIcon(iconPath: CustomIcons.add),
              Expanded(child: Text(localizations.settingsProfileNewProfile)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActiveProfile(BuildContext context, Profile profile) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Align(
          child: Column(
            children: [
              CustomCircleAvatar(iconPath: CustomIcons.fromName(profile.name)),
              Text(profile.name, style: theme.textTheme.titleMedium),
              Text(
                profile.description ??
                    AppLocalizations.of(context)!.settingsProfileNoDescription,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: CustomIconButton.redirectInApp(
            context: context,
            iconPath: CustomIcons.edit,
            route: Routes.settingsProfileEdit(selectedProfile.id.toString()),
            size: AppDimensions.iconSizeSmall,
          ),
        ),
      ],
    );
  }

  Widget _buildOtherProfile(BuildContext context, Profile profile) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => onSwitchProfile(profile),
      child: Row(
        children: [
          CustomCircleAvatar(iconPath: CustomIcons.fromName(profile.name)),
          Expanded(
            child: Text(profile.name, style: theme.textTheme.bodyMedium),
          ),
          CustomIconButton.normal(
            iconPath: CustomIcons.delete,
            onTap: () => onRemoveProfile(profile),
          ),
        ],
      ),
    );
  }
}
