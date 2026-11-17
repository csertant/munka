import 'package:material_ui/material_ui.dart';

import '../../l10n/generated/app_localizations.dart';
import '../core/widgets/widgets.dart';
import 'control_entries_viewmodel.dart';

class ControlEntriesScreen extends StatefulWidget {
  const ControlEntriesScreen({super.key, required this.viewModel});

  final ControlEntriesViewModel viewModel;

  @override
  State<ControlEntriesScreen> createState() => _ControlEntriesScreenState();
}

class _ControlEntriesScreenState extends State<ControlEntriesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ControlEntriesScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar.text(
        text: widget.viewModel.isEditing
            ? localizations.controlEntriesEditScreenTitle
            : localizations.controlEntriesNewScreenTitle,
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
              title: localizations.controlEntriesLoadErrorTitle,
              label: localizations.buttonLabelReload,
              onPressed: widget.viewModel.load.execute,
            );
          }
        },
        child: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, child) {
            return const Center(child: Text('Control Entries Screen'));
          },
        ),
      ),
    );
  }
}
