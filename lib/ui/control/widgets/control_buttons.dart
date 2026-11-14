import 'dart:async';

import 'package:material_ui/material_ui.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../core/themes/dimensions.dart';
import '../../core/widgets/widgets.dart';
import '../control_viewmodel.dart';

class ControlButtons extends StatelessWidget {
  const ControlButtons({super.key, required this.viewModel});

  final ControlViewModel viewModel;

  Future<void> _handleStopPressed(BuildContext context) async {
    unawaited(viewModel.stopTracking.execute());
    final result = await showDialog<({String project, String notes})>(
      context: context,
      barrierDismissible: false,
      builder: _buildTimeEntryDialog,
    );
    if (result != null) {
      await viewModel.completeTracking.execute(result.project, result.notes);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: ValueListenableBuilder<bool>(
        valueListenable: viewModel.isTracking,
        builder: (context, tracking, _) {
          if (!tracking) {
            return CustomIconButton.normal(
              iconPath: CustomIcons.play,
              onTap: viewModel.startTracking.execute,
              tooltip: localizations.controlStartButtonLabel,
              size: AppDimensions.iconSizeLarge,
            );
          }
          return CustomIconButton.normal(
            iconPath: CustomIcons.stop,
            onTap: () => _handleStopPressed(context),
            tooltip: localizations.controlStopButtonLabel,
            size: AppDimensions.iconSizeLarge,
          );
        },
      ),
    );
  }

  Widget _buildTimeEntryDialog(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final projectController = TextEditingController();
    final notesController = TextEditingController();

    return AlertDialog(
      title: Text(
        localizations.controlStopButtonLabel,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            controller: projectController,
            labelText: localizations.controlProjectLabel,
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          CustomTextField(
            controller: notesController,
            labelText: localizations.controlNotesLabel,
          ),
        ],
      ),
      actions: [
        CustomIconButton.normal(
          iconPath: CustomIcons.delete,
          tooltip: localizations.controlClearButtonLabel,
          onTap: () async {
            await viewModel.clearTracking.execute();
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop((
              project: projectController.text,
              notes: notesController.text,
            ));
          },
          child: Text(localizations.controlSaveButtonLabel),
        ),
      ],
    );
  }
}
