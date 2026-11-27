import 'package:material_ui/material_ui.dart';

import '../../l10n/generated/app_localizations.dart';
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
            return const SingleChildScrollView();
          },
        ),
      ),
    );
  }
}
