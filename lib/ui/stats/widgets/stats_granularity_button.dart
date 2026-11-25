import 'package:material_ui/material_ui.dart';

import '../../../domain/models/models.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../core/themes/dimensions.dart';
import '../../core/widgets/widgets.dart';

class StatsGranularityButton extends StatelessWidget {
  const StatsGranularityButton({
    super.key,
    required this.granularity,
    this.onGranularityChanged,
  });

  final StatsGranularity granularity;
  final ValueChanged<StatsGranularity>? onGranularityChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: SegmentedButton<StatsGranularity>(
        selectedIcon: const CustomIcon(iconPath: CustomIcons.check),
        segments: [
          ButtonSegment(
            icon: const CustomIcon(iconPath: CustomIcons.day),
            value: StatsGranularity.day,
            label: Text(
              localizations.buttonLabelDay,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          ButtonSegment(
            icon: const CustomIcon(iconPath: CustomIcons.week),
            value: StatsGranularity.week,
            label: Text(
              localizations.buttonLabelWeek,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          ButtonSegment(
            icon: const CustomIcon(iconPath: CustomIcons.month),
            value: StatsGranularity.month,
            label: Text(
              localizations.buttonLabelMonth,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          ButtonSegment(
            icon: const CustomIcon(iconPath: CustomIcons.year),
            value: StatsGranularity.year,
            label: Text(
              localizations.buttonLabelYear,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
        selected: {granularity},
        onSelectionChanged: (selection) =>
            onGranularityChanged?.call(selection.first),
      ),
    );
  }
}
