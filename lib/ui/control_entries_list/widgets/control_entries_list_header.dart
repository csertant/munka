import 'package:material_ui/material_ui.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../routing/routes.dart';
import '../../core/widgets/widgets.dart';

class ControlEntriesListHeader extends StatelessWidget {
  const ControlEntriesListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return CustomTitleWithActions(
      title: localizations.controlEntriesListScreenTitle,
      actions: [
        CustomIconButton.redirectInApp(
          context: context,
          iconPath: CustomIcons.add,
          route: Routes.controlEntriesNew,
          tooltip: localizations.buttonLabelAdd,
        ),
        CustomIconButton.redirectInApp(
          context: context,
          iconPath: CustomIcons.share,
          route: Routes.controlEntriesShare,
          tooltip: localizations.buttonLabelShare,
        ),
      ],
    );
  }
}
