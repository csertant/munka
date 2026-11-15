import 'package:material_ui/material_ui.dart';

import '../../l10n/generated/app_localizations.dart';
import '../core/widgets/widgets.dart';
import 'control_entries_list_viewmodel.dart';

class ControlEntriesListScreen extends StatefulWidget {
  const ControlEntriesListScreen({super.key, required this.viewModel});

  final ControlEntriesListViewModel viewModel;

  @override
  State<ControlEntriesListScreen> createState() =>
      _ControlEntriesListScreenState();
}

class _ControlEntriesListScreenState extends State<ControlEntriesListScreen> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar.text(
        text: localizations.controlEntriesListScreenTitle,
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel.load,
        builder: (context, child) {
          if (widget.viewModel.load.completed) {
            return child!;
          } else if (widget.viewModel.load.running) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ErrorIndicator(
              title: localizations.controlEntriesListLoadErrorTitle,
              label: localizations.controlEntriesListLoadErrorLabel,
              onPressed: widget.viewModel.load.execute,
            );
          }
        },
        child: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, child) {
            return ListView.builder(
              itemCount: widget.viewModel.timeEntries.length,
              itemBuilder: (context, index) =>
                  TimeEntryTile(timeEntry: widget.viewModel.timeEntries[index]),
            );
          },
        ),
      ),
    );
  }
}
