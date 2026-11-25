import 'package:material_ui/material_ui.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../utils/utils.dart';
import '../../core/themes/dimensions.dart';
import '../../core/widgets/widgets.dart';

class StatsSummary extends StatelessWidget {
  const StatsSummary({
    super.key,
    required this.title,
    required this.totalHours,
    required this.stepBackward,
    required this.stepForward,
    this.canGoForward = false,
  });

  final String title;
  final double totalHours;
  final VoidCallback stepBackward;
  final VoidCallback stepForward;
  final bool canGoForward;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;
    final formattedTotalHours = AppDateUtils.formatHoursDecimal(totalHours);
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomIconButton.normal(
            onTap: stepBackward,
            iconPath: CustomIcons.left,
            tooltip: localizations.statsGoBackwardButtonLabel,
          ),
          Column(
            children: [
              Text(title, style: theme.textTheme.titleMedium),
              Text(
                '$formattedTotalHours h',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          CustomIconButton.normal(
            onTap: canGoForward ? stepForward : () {},
            iconPath: CustomIcons.right,
            tooltip: localizations.statsGoForwardButtonLabel,
            enabled: canGoForward,
          ),
        ],
      ),
    );
  }
}
