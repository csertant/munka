import 'package:material_ui/material_ui.dart';

import '../../l10n/generated/app_localizations.dart';
import '../core/themes/dimensions.dart';
import '../core/widgets/widgets.dart';
import 'control_viewmodel.dart';
import 'widgets/control_buttons.dart';
import 'widgets/control_recent_entries.dart';
import 'widgets/control_timer.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({super.key, required this.viewModel});

  final ControlViewModel viewModel;

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      appBar: CustomAppBar.image(
        imagePath: brightness == Brightness.light
            ? CustomIcons.appIconLight
            : CustomIcons.appIconDark,
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
              title: localizations.controlLoadErrorTitle,
              label: localizations.buttonLabelReload,
              onPressed: widget.viewModel.load.execute,
            );
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final availableHeight = constraints.maxHeight;
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: CustomSliverPersistentHeaderDelegate(
                    minHeight: AppDimensions.sliverCollapsedTopHeight(
                      availableHeight,
                    ),
                    maxHeight: AppDimensions.sliverInitialTopHeight(
                      availableHeight,
                    ),
                    children: [
                      ControlTimer(viewModel: widget.viewModel),
                      ControlButtons(viewModel: widget.viewModel),
                    ],
                  ),
                ),
                ControlRecentEntries(viewModel: widget.viewModel),
              ],
            );
          },
        ),
      ),
    );
  }
}
