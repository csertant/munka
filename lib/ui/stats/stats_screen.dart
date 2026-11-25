import 'package:material_ui/material_ui.dart';

import '../../l10n/generated/app_localizations.dart';
import '../core/themes/dimensions.dart';
import '../core/widgets/widgets.dart';
import 'stats_viewmodel.dart';
import 'widgets/stats_chart.dart';
import 'widgets/stats_granularity_button.dart';
import 'widgets/stats_summary.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key, required this.viewModel});

  final StatsViewModel viewModel;

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar.text(text: localizations.statsScreenTitle),
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
              label: localizations.buttonLabelReload,
              onPressed: widget.viewModel.load.execute,
            );
          }
        },
        child: AnimatedBuilder(
          animation: widget.viewModel,
          builder: (context, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StatsSummary(
                  title: widget.viewModel.summaryTitle,
                  totalHours: widget.viewModel.totalHours,
                  stepBackward: widget.viewModel.stepBackward,
                  stepForward: widget.viewModel.stepForward,
                  canGoForward: widget.viewModel.canGoForward,
                ),
                const SizedBox(height: AppDimensions.paddingMedium),
                Expanded(
                  child: StatsChart(
                    buckets: widget.viewModel.buckets,
                    stepBackward: widget.viewModel.stepBackward,
                    stepForward: widget.viewModel.stepForward,
                    granularity: widget.viewModel.granularity,
                    maxHours: widget.viewModel.maxHours,
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingMedium),
                StatsGranularityButton(
                  granularity: widget.viewModel.granularity,
                  onGranularityChanged: widget.viewModel.setGranularity,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
