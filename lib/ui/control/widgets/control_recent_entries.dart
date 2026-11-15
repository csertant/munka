import 'package:material_ui/material_ui.dart';

import '../../../data/database/database.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../core/widgets/widgets.dart';
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
              (context, index) => TimeEntryTile(timeEntry: timeEntries[index]),
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
}
