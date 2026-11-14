import 'package:material_ui/material_ui.dart';

import '../../../data/database/database.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../core/themes/dimensions.dart';
import '../control_viewmodel.dart';

class ControlRecentEntries extends StatelessWidget {
  const ControlRecentEntries({super.key, required this.viewModel});

  final ControlViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Expanded(
      child: ValueListenableBuilder<List<TimeEntry>>(
        valueListenable: viewModel.timeEntries,
        builder: (context, timeEntries, child) {
          if (timeEntries.isNotEmpty) {
            return ListView.builder(
              itemCount: timeEntries.length,
              itemBuilder: (context, index) =>
                  _buildTimeEntryTile(timeEntries[index]),
            );
          } else {
            return Center(
              child: Text(localizations.controlNoRecentEntriesLabel),
            );
          }
        },
      ),
    );
  }

  Widget _buildTimeEntryTile(TimeEntry timeEntry) {
    //TODO: Format the time entry display as needed
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      title: Text(timeEntry.project ?? 'No project'),
      subtitle: Text(timeEntry.notes ?? 'No notes'),
      trailing: Text(
        '${timeEntry.startedAt} - ${timeEntry.endedAt ?? 'In progress'}',
      ),
    );
  }
}
