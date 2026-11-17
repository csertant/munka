import 'package:material_ui/material_ui.dart';

import '../../../l10n/generated/app_localizations.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.errorText,
    this.keyboardType,
    this.labelText,
    this.onTap,
    this.required = false,
  });

  final TextEditingController controller;
  final String? errorText;
  final TextInputType? keyboardType;
  final String? labelText;
  final VoidCallback? onTap;
  final bool required;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: required
          ? (value) => value != null && value.isNotEmpty
                ? null
                : localizations.textFieldRequiredError
          : null,
      keyboardType: keyboardType,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: theme.textTheme.bodyMedium!.copyWith(
          color: theme.colorScheme.onSurface,
        ),
        errorText: errorText,
        errorStyle: theme.textTheme.bodyMedium!.copyWith(
          color: theme.colorScheme.error,
        ),
        focusColor: theme.colorScheme.outlineVariant,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
      ),
    );
  }
}
