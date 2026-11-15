import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../data/database/database.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../routing/routes.dart';
import '../../../utils/utils.dart';
import '../themes/dimensions.dart';

class TimeEntryTile extends StatelessWidget {
  const TimeEntryTile({super.key, required this.timeEntry});

  final TimeEntry timeEntry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;
    final formattedDuration = AppDateUtils.formatDurationDecimal(
      timeEntry.startedAt,
      timeEntry.endedAt!,
    );
    final formattedStartEnd =
        '${AppDateFormat.yMMddHHmm.format(timeEntry.startedAt)} - ${AppDateFormat.yMMddHHmm.format(timeEntry.endedAt!)}';

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.paddingMedium,
        AppDimensions.paddingMedium,
        AppDimensions.paddingMedium,
        0,
      ),
      child: ListTile(
        onTap: () =>
            context.go(Routes.controlEntriesEdit(timeEntry.id.toString())),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: theme.colorScheme.outline),
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        ),
        title: Text(
          timeEntry.project ?? localizations.controlProjectEmptyPlaceholder,
          style: theme.textTheme.titleMedium,
        ),
        subtitle: Text(formattedStartEnd, style: theme.textTheme.bodyMedium),
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
