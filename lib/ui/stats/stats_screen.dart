import 'package:material_ui/material_ui.dart';

import '../../l10n/generated/app_localizations.dart';
import '../core/widgets/widgets.dart';
import 'stats_viewmodel.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key, required this.viewModel});

  final StatsViewModel viewModel;

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant StatsScreen oldWidget) {
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
      body: ListenableBuilder(
        listenable: widget.viewModel.load,
        builder: (context, child) {
          if (widget.viewModel.load.completed) {
            return child!;
          } else if (widget.viewModel.load.running) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ErrorIndicator(
              title: localizations.statsLoadErrorTitle,
              label: localizations.statsLoadErrorLabel,
              onPressed: widget.viewModel.load.execute,
            );
          }
        },
        child: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, child) {
            return Container();
          },
        ),
      ),
    );
  }
}
