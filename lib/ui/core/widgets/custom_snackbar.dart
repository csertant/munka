import 'package:material_ui/material_ui.dart';

import '../../../l10n/generated/app_localizations.dart';

class CustomSnackBar {
  static SnackBar info({
    required BuildContext context,
    required String content,
    Duration duration = const Duration(seconds: 3),
  }) {
    final theme = Theme.of(context);
    return SnackBar(
      duration: duration,
      persist: false,
      content: Text(
        content,
        style: theme.textTheme.bodyMedium!.copyWith(
          color: theme.colorScheme.outline,
        ),
      ),
      backgroundColor: theme.colorScheme.onSurface,
      action: SnackBarAction(
        label: AppLocalizations.of(context)!.buttonLabelOk,
        textColor: theme.colorScheme.outline,
        onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      ),
    );
  }

  static SnackBar error({
    required BuildContext context,
    required String content,
    Duration duration = const Duration(seconds: 3),
  }) {
    final theme = Theme.of(context);
    return SnackBar(
      duration: duration,
      persist: false,
      content: Text(
        content,
        style: theme.textTheme.bodyMedium!.copyWith(
          color: theme.colorScheme.onError,
        ),
      ),
      backgroundColor: theme.colorScheme.error,
      action: SnackBarAction(
        label: AppLocalizations.of(context)!.buttonLabelOk,
        textColor: theme.colorScheme.onError,
        onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      ),
    );
  }
}
