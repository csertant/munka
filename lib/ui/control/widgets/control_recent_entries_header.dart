import 'package:material_ui/material_ui.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../routing/routes.dart';
import '../../core/widgets/widgets.dart';

class ControlRecentEntriesHeader extends StatelessWidget {
  const ControlRecentEntriesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return SliverToBoxAdapter(
      child: CustomTitleWithActions(
        title: localizations.controlEntriesListScreenTitle,
        actions: [
          CustomIconButton.redirectInApp(
            context: context,
            iconPath: CustomIcons.share,
            route: Routes.controlEntriesShare,
            tooltip: localizations.buttonLabelShare,
          ),
        ],
      ),
    );
  }
}
