import 'package:material_ui/material_ui.dart';

import '../../data/database/database.dart';
import '../../l10n/generated/app_localizations.dart';
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
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ControlScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

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
              label: localizations.controlLoadErrorLabel,
              onPressed: widget.viewModel.load.execute,
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListenableBuilder(
                listenable: widget.viewModel,
                builder: (context, child) {
                  return Center(
                    child: ControlTimer(
                      currentTime: widget.viewModel.currentTime,
                      elapsed: widget.viewModel.elapsed,
                      isTracking: widget.viewModel.isTracking,
                    ),
                  );
                },
              ),
              const ControlButtons(),
              StreamBuilder<List<TimeEntry>>(
                stream: widget.viewModel.timeEntriesStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final timeEntries = snapshot.data!;
                    return ControlRecentEntries(timeEntries: timeEntries);
                  } else if (snapshot.hasError) {
                    return ErrorIndicator(
                      title: localizations.controlLoadErrorTitle,
                      label: localizations.controlLoadErrorLabel,
                      onPressed: widget.viewModel.load.execute,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
