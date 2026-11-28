import 'package:material_ui/material_ui.dart';

import '../../l10n/generated/app_localizations.dart';
import '../core/themes/dimensions.dart';
import '../core/widgets/widgets.dart';
import 'share_viewmodel.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({super.key, required this.viewModel});

  final ShareViewModel viewModel;

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.exportTimeEntriesToCsv.addListener(
      _onExportTimeEntriesToCsvResult,
    );
  }

  @override
  void didUpdateWidget(covariant ShareScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.exportTimeEntriesToCsv.removeListener(
      _onExportTimeEntriesToCsvResult,
    );
    widget.viewModel.exportTimeEntriesToCsv.addListener(
      _onExportTimeEntriesToCsvResult,
    );
  }

  @override
  void dispose() {
    widget.viewModel.exportTimeEntriesToCsv.removeListener(
      _onExportTimeEntriesToCsvResult,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar.text(text: localizations.shareScreenTitle),
      body: ListenableBuilder(
        listenable: widget.viewModel.load,
        builder: (context, child) {
          if (widget.viewModel.load.completed) {
            return child!;
          } else if (widget.viewModel.load.running) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ErrorIndicator(
              title: localizations.shareLoadErrorTitle,
              label: localizations.buttonLabelReload,
              onPressed: widget.viewModel.load.execute,
            );
          }
        },
        child: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, child) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CustomIcon(
                      iconPath: CustomIcons.share,
                      size: AppDimensions.iconSizeLarge,
                    ),
                    const SizedBox(height: AppDimensions.paddingLarge),
                    Text(
                      localizations.shareDetails,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: AppDimensions.paddingLarge),
                    OutlinedButton(
                      onPressed:
                          widget.viewModel.exportTimeEntriesToCsv.execute,
                      child: Text(localizations.buttonLabelShare),
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

  void _onExportTimeEntriesToCsvResult() {
    final localizations = AppLocalizations.of(context)!;
    showFeedbackOnResult(
      context: context,
      action: widget.viewModel.exportTimeEntriesToCsv,
      successMessage: localizations.shareTimeEntriesExported,
      errorMessage: localizations.errorWhileExportingTimeEntries,
    );
  }
}
