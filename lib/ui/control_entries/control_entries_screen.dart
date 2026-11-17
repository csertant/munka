import 'package:material_ui/material_ui.dart';

import '../../l10n/generated/app_localizations.dart';
import '../core/themes/dimensions.dart';
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
    widget.viewModel.createTimeEntry.addListener(_onCreateTimeEntryResult);
    widget.viewModel.modifyTimeEntry.addListener(_onModifyTimeEntryResult);
  }

  @override
  void didUpdateWidget(covariant ControlEntriesScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.createTimeEntry.removeListener(
      _onCreateTimeEntryResult,
    );
    widget.viewModel.createTimeEntry.addListener(_onCreateTimeEntryResult);
    oldWidget.viewModel.modifyTimeEntry.removeListener(
      _onModifyTimeEntryResult,
    );
    widget.viewModel.modifyTimeEntry.addListener(_onModifyTimeEntryResult);
  }

  @override
  void dispose() {
    widget.viewModel.createTimeEntry.removeListener(_onCreateTimeEntryResult);
    widget.viewModel.modifyTimeEntry.removeListener(_onModifyTimeEntryResult);
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
            final isEditing = widget.viewModel.isEditing;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: widget.viewModel.projectController,
                      labelText: localizations.controlEntryProject,
                    ),
                    const SizedBox(height: AppDimensions.paddingSmall),
                    CustomTextField(
                      controller: widget.viewModel.notesController,
                      labelText: localizations.controlEntryNotes,
                    ),
                    const SizedBox(height: AppDimensions.paddingSmall),
                    CustomDateTimeField(
                      labelText: localizations.controlEntryStartedAt,
                      required: true,
                      initialValue: widget.viewModel.startedAt,
                      onChanged: widget.viewModel.setStartedAt,
                    ),
                    const SizedBox(height: AppDimensions.paddingSmall),
                    CustomDateTimeField(
                      labelText: localizations.controlEntryEndedAt,
                      required: true,
                      initialValue: widget.viewModel.endedAt,
                      onChanged: widget.viewModel.setEndedAt,
                    ),
                    const SizedBox(height: AppDimensions.paddingLarge),
                    OutlinedButton(
                      onPressed: isEditing
                          ? () => widget.viewModel.modifyTimeEntry.execute()
                          : () async {
                              await widget.viewModel.createTimeEntry.execute();
                              if (context.mounted && !isEditing) {
                                Navigator.of(context).pop();
                              }
                            },
                      child: Text(localizations.buttonLabelSave),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onCreateTimeEntryResult() {
    final localizations = AppLocalizations.of(context)!;
    showFeedbackOnResult(
      context: context,
      action: widget.viewModel.createTimeEntry,
      successMessage: localizations.controlEntriesTimeEntryCreated,
      errorMessage: localizations.errorWhileCreatingTimeEntry,
    );
  }

  void _onModifyTimeEntryResult() {
    final localizations = AppLocalizations.of(context)!;
    showFeedbackOnResult(
      context: context,
      action: widget.viewModel.modifyTimeEntry,
      successMessage: localizations.controlEntriesTimeEntryModified,
      errorMessage: localizations.errorWhileModifyingTimeEntry,
    );
  }
}
