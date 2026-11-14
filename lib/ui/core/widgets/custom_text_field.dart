import 'package:material_ui/material_ui.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.errorText,
  });

  final TextEditingController controller;
  final String? labelText;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      controller: controller,
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
