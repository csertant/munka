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
    final otherProfiles = profiles
        .where((profile) => profile != selectedProfile)
        .toList();
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Column(
        children: [
          const SizedBox(height: AppDimensions.paddingLarge),
          _buildActiveProfile(context, selectedProfile),
          const SizedBox(height: AppDimensions.paddingExtraLarge),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: otherProfiles.length,
            itemBuilder: (context, index) {
              final profile = otherProfiles[index];
              return _buildOtherProfile(context, profile, index);
            },
          ),
          _buildNewProfileButton(context, otherProfiles.isNotEmpty),
        ],
      ),
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
              const SizedBox(height: AppDimensions.paddingMedium),
              Text(profile.name, style: theme.textTheme.titleLarge),
              Text(
                profile.description ??
                    AppLocalizations.of(context)!.settingsProfileNoDescription,
                style: theme.textTheme.bodyLarge,
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
          ),
        ),
      ],
    );
  }

  Widget _buildOtherProfile(BuildContext context, Profile profile, int index) {
    final theme = Theme.of(context);
    final borderRadiusForOtherProfile = _buildBorderRadiusForOtherProfile(
      index == 0,
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outline),
        borderRadius: borderRadiusForOtherProfile,
      ),
      child: InkWell(
        onTap: () => onSwitchProfile(profile),
        borderRadius: borderRadiusForOtherProfile,
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          child: Row(
            children: [
              CustomCircleAvatar(
                iconPath: CustomIcons.fromName(profile.name),
                padding: const EdgeInsets.all(AppDimensions.paddingSmall),
                size: AppDimensions.avatarSizeSmall,
              ),
              const SizedBox(width: AppDimensions.paddingMedium),
              Expanded(
                child: Text(profile.name, style: theme.textTheme.titleSmall),
              ),
              CustomIconButton.normal(
                iconPath: CustomIcons.delete,
                onTap: () => onRemoveProfile(profile),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewProfileButton(BuildContext context, bool hasOtherProfiles) {
    final localizations = AppLocalizations.of(context)!;
    final borderRadiusForNewProfile = _buildBorderRadiusForNewProfile(
      hasOtherProfiles,
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        border: _buildBorderForNewProfile(context, hasOtherProfiles),
        borderRadius: borderRadiusForNewProfile,
      ),
      child: InkWell(
        onTap: onNewProfile,
        borderRadius: borderRadiusForNewProfile,
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomIcon(iconPath: CustomIcons.add),
              const SizedBox(width: AppDimensions.paddingMedium),
              Text(localizations.settingsProfileNewProfile),
            ],
          ),
        ),
      ),
    );
  }

  BorderRadius _buildBorderRadiusForOtherProfile(bool isFirst) {
    return BorderRadius.vertical(
      top: isFirst
          ? const Radius.circular(AppDimensions.borderRadiusMedium)
          : Radius.zero,
    );
  }

  BorderRadius _buildBorderRadiusForNewProfile(bool hasOtherProfiles) {
    return BorderRadius.vertical(
      top: hasOtherProfiles
          ? Radius.zero
          : const Radius.circular(AppDimensions.borderRadiusMedium),
      bottom: const Radius.circular(AppDimensions.borderRadiusMedium),
    );
  }

  Border _buildBorderForNewProfile(
    BuildContext context,
    bool hasOtherProfiles,
  ) {
    final theme = Theme.of(context);
    return hasOtherProfiles
        ? Border(
            left: BorderSide(color: theme.colorScheme.outline),
            right: BorderSide(color: theme.colorScheme.outline),
            bottom: BorderSide(color: theme.colorScheme.outline),
          )
        : Border.all(color: theme.colorScheme.outline);
  }
}
