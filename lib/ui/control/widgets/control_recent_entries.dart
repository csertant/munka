import 'package:material_ui/material_ui.dart';

import '../../../data/database/database.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../utils/utils.dart';
import '../../core/themes/dimensions.dart';
import '../control_viewmodel.dart';

class ControlRecentEntries extends StatelessWidget {
  const ControlRecentEntries({super.key, required this.viewModel});

  final ControlViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return ValueListenableBuilder<List<TimeEntry>>(
      valueListenable: viewModel.timeEntries,
      builder: (context, timeEntries, child) {
        if (timeEntries.isNotEmpty) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) =>
                  _buildTimeEntryTile(context, timeEntries[index]),
              childCount: timeEntries.length,
            ),
          );
        } else {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(localizations.controlNoRecentEntriesLabel),
            ),
          );
        }
      },
    );
  }

  Widget _buildTimeEntryTile(BuildContext context, TimeEntry timeEntry) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;
    final formattedDuration = AppDateUtils.formatDurationDecimal(
      timeEntry.startedAt,
      timeEntry.endedAt!,
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.paddingMedium,
        AppDimensions.paddingMedium,
        AppDimensions.paddingMedium,
        0,
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: theme.colorScheme.outline),
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        ),
        title: Text(
          timeEntry.project ?? localizations.controlProjectEmptyPlaceholder,
          style: theme.textTheme.titleMedium,
        ),
        subtitle: Text(
          '${AppDateFormat.yMMddHHmm.format(timeEntry.startedAt)} - ${AppDateFormat.yMMddHHmm.format(timeEntry.endedAt!)}',
        ),
        trailing: Text(
          '+ $formattedDuration h',
          style: theme.textTheme.titleMedium!.copyWith(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
